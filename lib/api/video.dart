import 'package:dio/dio.dart';
import 'dio.dart';

// 获取视频列表
Future<Response<dynamic>> fetchVideoList(String bvid) {
  return dio.get('/x/web-interface/view', queryParameters: {"bvid": bvid});
}

// 下载视频
Future<Response<dynamic>> downloadVideo(
    {required String uri,
    required String filename,
    CancelToken? cancelToken,
    Function(int, int)? onReceiveProgress}) {
  return Dio().download(uri, './biliDown/$filename.flv',
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      options: Options(responseType: ResponseType.stream, headers: {
        'Referer': "https://api.bilibili.com",
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',
      }));
}

// 获取视频下载信息
Future<Response<dynamic>> fetchDownloadVideoInfo(String bvid, int cid) {
  return dio.get(
    '/x/player/playurl',
    queryParameters: {"bvid": bvid, "cid": cid, "qn": "120"},
  );
}
