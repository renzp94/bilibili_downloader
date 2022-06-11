import 'package:hive_flutter/hive_flutter.dart';
import '../constant.dart';

part 'settings.g.dart';

@HiveType(typeId: 2)
class Settings {
  @HiveField(0, defaultValue: '')
  String downloadDir;
  @HiveField(1, defaultValue: defaultMaxDownloadCount)
  int maxDownloadCount;

  Settings({required this.downloadDir, required this.maxDownloadCount});
}
