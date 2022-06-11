import 'package:bilibili_downloader/constant.dart';
import 'package:bilibili_downloader/models/settings.dart';
import 'package:bilibili_downloader/models/video.dart';
import 'package:bilibili_downloader/models/video_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DB {
  static init() async {
    Hive.registerAdapter(DownloadVideoInfoAdapter());
    Hive.registerAdapter(CancelTokenAdapter());
    Hive.registerAdapter(SettingsAdapter());
    await Hive.initFlutter();
    await Hive.openBox<DownloadVideoInfo>(downloadBoxName);
    await Hive.openBox<Settings>(settingsBoxName);
  }
}
