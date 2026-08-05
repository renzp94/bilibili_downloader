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
  final headResponse = await Dio().head(url, options: Options(
    headers: {
      'Referer': 'https://bilibili.com',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
    },
  ));
  final totalSize = int.parse(headResponse.headers.value('content-length') ?? '0');
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

  var completed = 0.0;
  await Future.wait(ranges.map((r) async {
    final partFile = File('${workDir.path}/part_${r.index}');
    if (partFile.existsSync() && partFile.lengthSync() == r.end - r.start + 1) {
      completed += 1 / ranges.length;
      onProgress?.call(completed);
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
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
        responseType: ResponseType.plain,
      ),
      onReceiveProgress: (c, t) {
        final partProgress = (completed + (c / t) / ranges.length);
        onProgress?.call(partProgress.clamp(0, 1));
      },
    );
    completed += 1 / ranges.length;
    onProgress?.call(completed.clamp(0, 1));
  }));

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
  const _PartRange({required this.index, required this.start, required this.end});
}
