import 'package:dio/dio.dart';

var options = BaseOptions(baseUrl: 'https://api.bilibili.com');

Dio dio = Dio(options)
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (request, handler) {
      print(request.uri);
      handler.next(request);
    },
    onResponse: (response, handler) {
      handler.next(response);
    },
  ));
