import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

import '../constant.dart';

part 'database.g.dart';

/// 下载视频表
@DataClassName('DownloadVideoInfo')
class DownloadVideos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bvid => text().withLength(max: 32)();
  IntColumn get aid => integer()();
  TextColumn get pic => text()();
  IntColumn get cid => integer()();
  TextColumn get title => text()();
  TextColumn get videoTitle => text()();
  TextColumn get uri => text().nullable()();
  RealColumn get progress => real().withDefault(const Constant(0))();
  TextColumn get status =>
      text().withLength(max: 16).withDefault(const Constant('wait'))();
  TextColumn get errorMsg => text().withLength(max: 256).nullable()();
}

/// 应用设置表（单条记录，id 固定为 1）
@DataClassName('Settings')
class AppSettings extends Table {
  IntColumn get id => integer()();
  TextColumn get downloadDir => text().withDefault(const Constant(''))();
  IntColumn get maxDownloadCount =>
      integer().withDefault(const Constant(defaultMaxDownloadCount))();
  IntColumn get splitCount => integer().withDefault(const Constant(4))();
  BoolColumn get deleteWithFile =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get skipDeleteConfirm =>
      boolean().withDefault(const Constant(false))();
  IntColumn get quality =>
      integer().withDefault(const Constant(defaultQuality))();
}

/// 搜索历史表
@DataClassName('SearchHistory')
class SearchHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get url => text()();
  TextColumn get title => text()();
  TextColumn get pic => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [DownloadVideos, AppSettings, SearchHistories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(appSettings, appSettings.splitCount);
          }
          if (from < 3) {
            await m.addColumn(appSettings, appSettings.deleteWithFile);
            await m.addColumn(appSettings, appSettings.skipDeleteConfirm);
          }
          if (from < 4) {
            await m.createTable(searchHistories);
          }
          if (from < 5) {
            await m.addColumn(downloadVideos, downloadVideos.errorMsg);
          }
          if (from < 6) {
            await m.addColumn(appSettings, appSettings.quality);
          }
          if (from < 7) {
            await m.addColumn(downloadVideos, downloadVideos.videoTitle);
          }
        },
      );

  /// 内存中的 CancelToken 映射，不持久化
  final Map<int, CancelToken> cancelTokens = {};

  // ── 设置相关 ──

  Future<Settings> getSettings() async {
    final s = await (select(appSettings)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    final dir = await _getDefaultDownloadDir();
    return s ??
        Settings(
            id: 1,
            downloadDir: dir,
            maxDownloadCount: defaultMaxDownloadCount,
            splitCount: 4,
            deleteWithFile: false,
            skipDeleteConfirm: false,
            quality: defaultQuality);
  }

  Future<void> saveSettings(Settings s) =>
      into(appSettings).insertOnConflictUpdate(s);

  // ── 下载任务相关 ──

  Future<List<DownloadVideoInfo>> allVideos() => select(downloadVideos).get();

  Stream<List<DownloadVideoInfo>> watchAllVideos() =>
      select(downloadVideos).watch();

  Future<void> addVideo(DownloadVideosCompanion video) =>
      into(downloadVideos).insert(video);

  Future<void> addVideos(List<DownloadVideosCompanion> videos) =>
      batch((b) => b.insertAll(downloadVideos, videos));

  Future<void> updateVideoProgress(int id, double progress, String status) =>
      (update(downloadVideos)..where((t) => t.id.equals(id))).write(
        DownloadVideosCompanion(
            progress: Value(progress), status: Value(status)),
      );

  Future<void> updateVideoStatus(int id, String status) =>
      (update(downloadVideos)..where((t) => t.id.equals(id)))
          .write(DownloadVideosCompanion(status: Value(status)));

  Future<void> updateVideoUri(int id, String uri) =>
      (update(downloadVideos)..where((t) => t.id.equals(id))).write(
        DownloadVideosCompanion(uri: Value(uri)),
      );

  Future<int> deleteVideo(int id) =>
      (delete(downloadVideos)..where((t) => t.id.equals(id))).go();

  Future<int> clearAllVideos() => delete(downloadVideos).go();

  // ── 搜索历史 ──

  Future<List<SearchHistory>> recentHistory({int limit = 8}) =>
      (select(searchHistories)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(limit))
          .get();

  Future<void> addHistory(String url, String title, String pic) async {
    await (delete(searchHistories)..where((t) => t.url.equals(url))).go();
    await into(searchHistories)
        .insert(SearchHistoriesCompanion.insert(url: url, title: title, pic: pic));
  }

  Future<int> deleteHistory(int id) =>
      (delete(searchHistories)..where((t) => t.id.equals(id))).go();

  Future<int> clearHistory() => delete(searchHistories).go();
}

Future<String> _getDefaultDownloadDir() async {
  Directory? appDownloadDir = await getDownloadsDirectory();
  appDownloadDir ??= await getApplicationDocumentsDirectory();
  final segments = appDownloadDir.path.split('/')..removeLast();
  segments.add(defaultDownloadDir);
  return segments.join('/');
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/bilibili_downloader.db');
    return NativeDatabase.createInBackground(file);
  });
}
