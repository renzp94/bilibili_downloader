import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import '../constant.dart';
import 'dio.dart';

/// 所有可用画质，从高到低
const _allQualities = [120, 112, 80, 64, 32, 16];

// 获取视频列表
Future<Response<dynamic>> fetchVideoList(String bvid) {
  return dio.get('/x/web-interface/view', queryParameters: {"bvid": bvid});
}

// 下载视频
Future<Response<dynamic>> downloadVideo({
  required String uri,
  required String filename,
  CancelToken? cancelToken,
  Function(int, int)? onReceiveProgress,
}) {
  return Dio().download(uri, filename,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      options: Options(responseType: ResponseType.stream, headers: {
        'Referer': "https://bilibili.com",
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',
      }));
}

/// 获取视频下载分段，从指定画质向下降级尝试
Future<List<Segment>> fetchVideoSegments(String bvid, int cid,
    {int quality = defaultQuality}) async {
  final idx = _allQualities.indexOf(quality);
  assert(idx != -1, '未知画质: $quality');
  final qualities = _allQualities.sublist(idx);
  String? lastError;

  for (final qn in qualities) {
    try {
      final res = await dio.get(
        '/x/player/playurl',
        queryParameters: {"bvid": bvid, "cid": cid, "qn": qn},
      );
      final durls = res.data['data']['durl'];
      if (durls != null && (durls as List).isNotEmpty) {
        return (durls.cast<Map<String, dynamic>>())
            .map((d) => Segment(
                url: d['url'] as String,
                size: (d['size'] as num).toInt()))
            .toList();
      }
    } catch (e) {
      lastError = e.toString();
      dev.log('获取视频分段失败 qn=$qn: $lastError');
    }
  }
  throw Exception('无法获取下载链接: $lastError');
}

class Segment {
  final String url;
  final int size;
  const Segment({required this.url, required this.size});
}
