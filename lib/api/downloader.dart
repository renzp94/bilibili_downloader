import 'dart:io';

import 'package:dio/dio.dart';

import '../utils/logger.dart';

/// 分片并发下载 + 二进制拼接
Future<void> downloadWithSplits({
  required String url,
  required String outputPath,
  required int splitCount,
  CancelToken? cancelToken,
  void Function(double progress)? onProgress,
}) async {
  // HEAD 请求获取文件总大小
  final headResponse = await Dio().head(
    url,
    options: Options(
      headers: {
        'Referer': 'https://bilibili.com',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      },
    ),
  );
  final totalSize = int.parse(
    headResponse.headers.value('content-length') ?? '0',
  );
  if (totalSize == 0) throw Exception('无法获取文件大小');

  final outputFile = File(outputPath);
  final workDir = Directory('$outputPath.parts');
  if (!workDir.existsSync()) workDir.createSync(recursive: true);

  final partSize = (totalSize / splitCount).ceil();
  final ranges = List.generate(splitCount, (i) {
    final start = i * partSize;
    var end = start + partSize - 1;
    if (i == splitCount - 1) end = totalSize - 1;
    if (start >= totalSize) return null;
    return _PartRange(index: i, start: start, end: end);
  }).whereType<_PartRange>().toList();

  final downloaded = List<int>.filled(ranges.length, 0);
  final partSizes = ranges.map((r) => r.end - r.start + 1).toList();

  int totalDownloaded() => downloaded.fold(0, (a, b) => a + b);

  await Future.wait(
    ranges.map((r) async {
      final i = r.index;
      final partFile = File('${workDir.path}/part_$i');
      if (partFile.existsSync() && partFile.lengthSync() == partSizes[i]) {
        downloaded[i] = partSizes[i];
        onProgress?.call(totalDownloaded() / totalSize);
        return;
      }
      await Dio().download(
        url,
        partFile.path,
        cancelToken: cancelToken,
        options: Options(
          headers: {
            'Range': 'bytes=${r.start}-${r.end}',
            'Referer': 'https://bilibili.com',
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          },
          responseType: ResponseType.plain,
        ),
        onReceiveProgress: (c, _) {
          downloaded[i] = c;
          final p = totalDownloaded() / totalSize;
          onProgress?.call(p.clamp(0.0, 1.0));
        },
      );
      downloaded[i] = partSizes[i];
      onProgress?.call(totalDownloaded() / totalSize);
    }),
  );

  // 二进制拼接
  final sink = outputFile.openWrite();
  for (final r in ranges) {
    final part = File('${workDir.path}/part_${r.index}');
    sink.add(await part.readAsBytes());
  }
  await sink.flush();
  await sink.close();
  workDir.deleteSync(recursive: true);
  Logger().info('分片下载完成: $outputPath');
}

class _PartRange {
  final int index;
  final int start;
  final int end;
  const _PartRange({
    required this.index,
    required this.start,
    required this.end,
  });
}
