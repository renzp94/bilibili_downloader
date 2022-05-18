import 'package:hive_flutter/hive_flutter.dart';
part 'video.g.dart';

@HiveType(typeId: 0)
class DownloadVideoInfo {
  @HiveField(0, defaultValue: '')
  // bvid
  String bvid;
  @HiveField(1, defaultValue: -1)
  // aid
  int aid;
  @HiveField(2, defaultValue: '')
  // 封面
  String pic;
  @HiveField(3, defaultValue: -1)
  // cid(唯一标识)
  int cid;
  @HiveField(4, defaultValue: '')
  // 名称
  String title;
  @HiveField(5)
  // 下载地址
  String? uri;
  @HiveField(6, defaultValue: 0)
  // 下载进度
  double? process;
  @HiveField(7, defaultValue: 'wait')
  // 下载状态，wait：等待下载 downloading：下载中 done：下载完成 error：失败 pause：暂停 cancel：取消
  String? status;

  DownloadVideoInfo(
      {required this.bvid,
      required this.aid,
      required this.pic,
      required this.cid,
      required this.title,
      this.uri,
      this.process,
      this.status});
}
