import 'package:hive_flutter/hive_flutter.dart';
part 'video.g.dart';

@HiveType(typeId: 0)
class DownloadVideoInfo {
  @HiveField(0, defaultValue: '')
  String bvid;
  @HiveField(1, defaultValue: -1)
  int aid;
  @HiveField(2, defaultValue: '')
  String pic;
  @HiveField(3, defaultValue: -1)
  int cid;
  @HiveField(4, defaultValue: '')
  String title;
  @HiveField(5)
  String? uri;

  DownloadVideoInfo(
      {required this.bvid,
      required this.aid,
      required this.pic,
      required this.cid,
      required this.title});
}
