import 'package:bilibili_downloader/constant.dart';
import 'package:bilibili_downloader/models/video.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DB {
  static late Box<DownloadVideoInfo> downloadBox;
  static late Map<String, Box<dynamic>?> boxNames = {
    downloadBoxName: null,
  };
  static init() async {
    Hive.registerAdapter(DownloadVideoInfoAdapter());
    await Hive.initFlutter();
    boxNames.forEach((key, value) async {
      boxNames[key] = await Hive.openBox<DownloadVideoInfo>(key);
    });
  }
}
