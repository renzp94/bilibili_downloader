import 'package:bilibili_downloader/constant.dart';
import 'package:dio/dio.dart';

var options = BaseOptions(baseUrl: baseUrl);

Dio dio = Dio(options)
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (request, handler) {
      handler.next(request);
    },
    onResponse: (response, handler) {
      handler.next(response);
    },
  ));
