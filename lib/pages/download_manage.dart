import 'dart:io';

import 'package:bilibili_downloader/api/downloader.dart';
import 'package:bilibili_downloader/api/video.dart'
    show Segment, downloadVideo, fetchVideoSegments;
import 'package:bilibili_downloader/models/database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:bilibili_downloader/utils/tools.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, Value;

import '../store/store.dart';
import '../utils/logger.dart';
import '../widgets/video_item.dart';

class DownloadManagePage extends StatefulWidget {
  const DownloadManagePage({super.key});

  @override
  State<DownloadManagePage> createState() =>
      _DownloadManagePageState();
}

class _DownloadManagePageState
    extends State<DownloadManagePage>
    with AutomaticKeepAliveClientMixin {
  List<DownloadVideoInfo> _downloadList = [];
  final Set<int> _activeIds = {};
  late Settings _settings;
  late AppDatabase _db;

  static const _accent = Color(0xFF0275EE);

  @override
  void initState() {
    super.initState();
    _db = Get.find<AppDatabase>();
    _loadVideos();
    ever(Store.to.refreshSignal,
        (_) => _loadVideos());
  }

  void _loadVideos() async {
    final videos = await _db.allVideos();
    _settings = await getSettings();
    if (mounted) {
      setState(() => _downloadList = videos);
      _startDownload();
    }
  }

  void _startDownload() => _loopDownload();

  void _loopDownload() async {
    if (!mounted) return;
    final items = _downloadList
        .where((e) =>
            e.status == 'downloading' &&
            !_activeIds.contains(e.id))
        .toList();
    if (items.isEmpty) {
      await _reloadAndCheckWait();
      return;
    }
    _activeIds.addAll(items.map((e) => e.id));
    await Future.wait(items.map(_downloadOne));
    _activeIds.removeAll(items.map((e) => e.id));
    await _reloadAndCheckWait();
  }

  Future<void> _reloadAndCheckWait() async {
    final videos = await _db.allVideos();
    if (!mounted) return;
    setState(() => _downloadList = videos);
    final waitItems =
        videos.where((e) => e.status == 'wait').toList();
    if (waitItems.isNotEmpty)
      await _enqueueDownloads(waitItems);
    if (!mounted) return;
    final refreshed = await _db.allVideos();
    if (!mounted) return;
    setState(() => _downloadList = refreshed);
    _loopDownload();
  }

  Future<void> _downloadOne(
      DownloadVideoInfo video) async {
    try {
      final cancelToken = CancelToken();
      _db.cancelTokens[video.id] = cancelToken;
      final outputPath =
          '${_settings.downloadDir}/${video.title}.flv';
      final segments = await _fetchSegmentsWithRetry(
          video.bvid, video.cid);
      if (segments.isEmpty)
        throw Exception('无可用下载链接');
      if (segments.length == 1) {
        await _downloadSingleSegment(
            segments.first, outputPath,
            cancelToken, video);
      } else {
        await _downloadMultiSegments(
            segments, outputPath,
            cancelToken, video);
      }
      Logger().info('下载完成: ${video.title}');
      _onProgress(video, 1.0);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        await _db.updateVideoProgress(
            video.id, video.progress, 'pause');
      } else {
        Logger().error(
            '下载失败: ${video.title} - ${e.message}');
        await _saveError(video.id, video.progress,
            e.message ?? '网络错误');
      }
    } catch (e) {
      Logger().error('下载失败: ${video.title} - $e');
      await _saveError(
          video.id, video.progress, e.toString());
    }
  }

  Future<List<Segment>> _fetchSegmentsWithRetry(
      String bvid, int cid) async {
    for (var i = 0; i < 3; i++) {
      final segs = await fetchVideoSegments(bvid, cid,
          quality: _settings.quality);
      if (segs.isNotEmpty) return segs;
      await Future.delayed(
          const Duration(seconds: 1));
    }
    throw Exception('获取下载链接失败，已重试3次');
  }

  Future<void> _downloadSingleSegment(
      Segment seg,
      String outputPath,
      CancelToken cancelToken,
      DownloadVideoInfo video) async {
    await _db.updateVideoUri(video.id, seg.url);
    if (_settings.splitCount > 1) {
      await downloadWithSplits(
        url: seg.url,
        outputPath: outputPath,
        splitCount: _settings.splitCount,
        cancelToken: cancelToken,
        onProgress: (p) =>
            _onProgress(video, p),
      );
    } else {
      await downloadVideo(
        uri: seg.url,
        filename: outputPath,
        cancelToken: cancelToken,
        onReceiveProgress: (c, t) =>
            _onProgress(
                video, t > 0 ? c / t : 0.0),
      );
    }
  }

  Future<void> _downloadMultiSegments(
      List<Segment> segments,
      String outputPath,
      CancelToken cancelToken,
      DownloadVideoInfo video) async {
    final totalSize = segments
        .fold<int>(0, (s, e) => s + e.size);
    final segDir =
        '${_settings.downloadDir}/.${video.title}.flv_segs';
    final workDir = Directory(segDir);
    if (!workDir.existsSync())
      workDir.createSync(recursive: true);
    var downloadedSize = 0;
    for (var i = 0; i < segments.length; i++) {
      final segFile =
          File('${workDir.path}/seg_$i');
      final expectedSize = segments[i].size;
      if (!segFile.existsSync() ||
          segFile.lengthSync() != expectedSize) {
        final freshSegs =
            await _fetchSegmentsWithRetry(
                video.bvid, video.cid);
        if (segFile.existsSync())
          segFile.deleteSync();
        await downloadVideo(
          uri: freshSegs[i].url,
          filename: segFile.path,
          cancelToken: cancelToken,
          onReceiveProgress: (c, _) =>
              _onProgress(video,
                  (downloadedSize + c) / totalSize),
        );
      }
      downloadedSize += expectedSize;
      _onProgress(
          video, downloadedSize / totalSize);
    }
    final sink = File(outputPath).openWrite();
    for (var i = 0; i < segments.length; i++) {
      sink.add(await File(
              '${workDir.path}/seg_$i')
          .readAsBytes());
    }
    await sink.flush();
    await sink.close();
    workDir.deleteSync(recursive: true);
  }

  Future<void> _saveError(int id, double progress,
      String msg) async {
    await _db.updateVideoProgress(
        id, progress, 'error');
    await (_db.update(_db.downloadVideos)
          ..where((t) => t.id.equals(id)))
        .write(DownloadVideosCompanion(
            errorMsg: Value(msg)));
  }

  void _onProgress(
      DownloadVideoInfo video, double progress) {
    final status = progress >= 1.0
        ? 'done'
        : 'downloading';
    _db.updateVideoProgress(
        video.id, progress, status);
    if (!mounted) return;
    setState(() {
      _downloadList = _downloadList.map((e) {
        if (e.id != video.id) return e;
        return DownloadVideoInfo(
          id: e.id,
          bvid: e.bvid,
          aid: e.aid,
          pic: e.pic,
          cid: e.cid,
          title: e.title,
          uri: e.uri,
          progress: progress,
          status: status,
          errorMsg: e.errorMsg,
        );
      }).toList();
    });
  }

  // ── 并发控制 ──

  Future<void> _enqueueDownload(int id) async {
    final downloading = _downloadList
        .where(
            (e) => e.status == 'downloading')
        .length;
    final status = downloading <
            _settings.maxDownloadCount
        ? 'downloading'
        : 'wait';
    await _db.updateVideoStatus(id, status);
  }

  Future<void> _enqueueDownloads(
      Iterable<DownloadVideoInfo> items) async {
    var slots = _settings.maxDownloadCount -
        _downloadList
            .where((e) =>
                e.status == 'downloading')
            .length;
    for (final v in items) {
      final status = slots > 0
          ? 'downloading'
          : 'wait';
      if (slots > 0) slots--;
      await _db.updateVideoStatus(
          v.id, status);
    }
  }

  // ── 操作 ──

  Future<void> _pauseVideo(
      DownloadVideoInfo video) async {
    _db.cancelTokens
        .remove(video.id)
        ?.cancel();
  }

  Future<void> _resumeVideo(
      DownloadVideoInfo video) async {
    await _enqueueDownload(video.id);
    await _reloadAndStart();
  }

  Future<void> _retryVideo(
      DownloadVideoInfo video) async {
    await _db.updateVideoProgress(
        video.id, 0, 'wait');
    await _enqueueDownload(video.id);
    await _reloadAndStart();
  }

  Future<void> _pauseAll() async {
    for (final v in _downloadList) {
      if (v.status == 'downloading')
        _db.cancelTokens
            .remove(v.id)
            ?.cancel();
    }
    for (final v in _downloadList) {
      if (v.status == 'downloading' ||
          v.status == 'wait') {
        await _db.updateVideoStatus(
            v.id, 'pause');
      }
    }
    await _reloadAndStart();
  }

  Future<void> _resumeAll() async {
    final paused = _downloadList
        .where((e) => e.status == 'pause')
        .toList();
    await _enqueueDownloads(paused);
    await _reloadAndStart();
  }

  Future<void> _retryAll() async {
    final failed = _downloadList
        .where((e) => e.status == 'error')
        .toList();
    for (final v in failed) {
      await _db.updateVideoProgress(
          v.id, 0, 'wait');
    }
    await _enqueueDownloads(failed);
    await _reloadAndStart();
  }

  Future<void> _reloadAndStart() async {
    final videos = await _db.allVideos();
    if (mounted) {
      setState(() => _downloadList = videos);
      _startDownload();
    }
  }

  // ── 删除 ──

  Future<bool?> _confirmDelete(
      {required String title,
      required bool isSingle,
      bool showDeleteFile = true}) async {
    var deleteFile = false;
    return showDialog<bool?>(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (ctx, setDialogState) {
            return AlertDialog(
              backgroundColor:
                  const Color(0xFF1E1E2E),
              title: Text(isSingle
                      ? '删除任务'
                      : '清空全部',
                  style: const TextStyle(
                      color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                      isSingle
                          ? '确定要删除「$title」吗？'
                          : '确定要清空全部下载任务吗？',
                      style: const TextStyle(
                          color: Colors.white70)),
                  if (showDeleteFile) ...[
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      value: deleteFile,
                      activeColor: _accent,
                      title: const Text(
                          '同时删除已下载的文件',
                          style: TextStyle(
                              color: Colors.white70)),
                      controlAffinity:
                          ListTileControlAffinity
                              .leading,
                      dense: true,
                      contentPadding:
                          EdgeInsets.zero,
                      onChanged: (v) =>
                          setDialogState(() =>
                              deleteFile =
                                  v ?? false),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () =>
                        Navigator.pop(ctx),
                    child: const Text('取消',
                        style: TextStyle(
                            color: Colors.white38))),
                TextButton(
                  onPressed: () => Navigator.pop(
                      ctx, deleteFile),
                  child: const Text('删除',
                      style: TextStyle(
                          color: _accent)),
                ),
              ],
            );
          });
        });
  }

  void _deleteFile(
      DownloadVideoInfo video) {
    final f = File(
        '${_settings.downloadDir}/${video.title}.flv');
    if (f.existsSync()) f.deleteSync();
    final d = Directory(
        '${_settings.downloadDir}/.${video.title}.flv_parts');
    if (d.existsSync())
      d.deleteSync(recursive: true);
  }

  Future<void> _deleteVideo(
      DownloadVideoInfo video) async {
    final deleteFile = await _confirmDelete(
      title: video.title,
      isSingle: true,
      showDeleteFile:
          video.status != 'error',
    );
    if (deleteFile == null) return;
    _db.cancelTokens
        .remove(video.id)
        ?.cancel();
    await _db.deleteVideo(video.id);
    if (deleteFile) _deleteFile(video);
    setState(() => _downloadList.removeWhere(
        (e) => e.id == video.id));
  }

  Future<void> _clearAll() async {
    if (_downloadList.isEmpty) return;
    final deleteFile = await _confirmDelete(
        title: '', isSingle: false);
    if (deleteFile == null) return;
    for (final v in _downloadList) {
      _db.cancelTokens
          .remove(v.id)
          ?.cancel();
      if (deleteFile &&
          (v.status == 'done' ||
              v.status == 'pause'))
        _deleteFile(v);
    }
    await _db.clearAllVideos();
    setState(() => _downloadList.clear());
  }

  // ═══ UI ═══

  static const _statusMap = {
    'wait': ('排队中', Colors.white30),
    'downloading': ('下载中', Color(0xFF64B5F6)),
    'pause': ('已暂停', Colors.orangeAccent),
    'done': ('已完成', Color(0xFF81C784)),
    'error': ('失败', Color(0xFFE57373)),
  };

  Widget _glassCard(
      {required Widget child,
      EdgeInsets? padding,
      BorderRadius? radius}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: radius ?? BorderRadius.circular(10),
        border:
            Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        borderRadius: radius ?? BorderRadius.circular(10),
        child: child,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final activeCount = _downloadList
        .where((e) =>
            e.status == 'downloading' ||
            e.status == 'wait')
        .length;
    final pauseCount = _downloadList
        .where((e) => e.status == 'pause')
        .length;
    final downloadingCount =
        activeCount + pauseCount;
    final doneCount = _downloadList
        .where((e) => e.status == 'done')
        .length;
    final failCount = _downloadList
        .where((e) => e.status == 'error')
        .length;

    if (_downloadList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(28),
        child: _buildEmpty(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(28),
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            _buildStats(activeCount, pauseCount,
                doneCount, failCount),
            const SizedBox(height: 12),
            _glassCard(
              padding: EdgeInsets.zero,
              child: TabBar(
                isScrollable: false,
                indicatorColor: _accent,
                labelColor: _accent,
                unselectedLabelColor: Colors.white38,
                labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                unselectedLabelStyle:
                    const TextStyle(fontSize: 13),
                indicatorSize:
                    TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                      text:
                          '全部 (${_downloadList.length})'),
                  Tab(
                      text:
                          '下载中 ($downloadingCount)'),
                  Tab(
                      text:
                          '下载完成 ($doneCount)'),
                  Tab(
                      text: '下载失败 ($failCount)'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  _buildList(_downloadList),
                  _buildList(_downloadList
                      .where((e) =>
                          e.status ==
                              'downloading' ||
                          e.status == 'wait' ||
                          e.status == 'pause')
                      .toList()),
                  _buildList(_downloadList
                      .where((e) =>
                          e.status == 'done')
                      .toList()),
                  _buildList(_downloadList
                      .where((e) =>
                          e.status == 'error')
                      .toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined,
              size: 64, color: Colors.white12),
          const SizedBox(height: 14),
          const Text('暂无下载任务',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white38)),
          const SizedBox(height: 6),
          const Text(
              '在首页搜索视频后点击下载即可添加',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white24)),
        ],
      ),
    );
  }

  Widget _buildStats(int active, int pause,
      int done, int fail) {
    return _glassCard(
      child: Row(
        children: [
          _statChip('进行中', active,
              const Color(0xFF64B5F6)),
          if (pause > 0) ...[
            const SizedBox(width: 14),
            _statChip('已暂停', pause,
                Colors.orangeAccent),
          ],
          const SizedBox(width: 14),
          _statChip('已完成', done,
              const Color(0xFF81C784)),
          if (fail > 0) ...[
            const SizedBox(width: 14),
            _statChip('失败', fail,
                const Color(0xFFE57373)),
          ],
          const Spacer(),
          if (active > 0) ...[
            _miniBtn(Icons.pause, '全部暂停',
                () => _pauseAll()),
            const SizedBox(width: 4),
          ],
          if (pause > 0)
            _miniBtn(Icons.play_arrow,
                '全部开始', () => _resumeAll()),
          if (fail > 0) ...[
            const SizedBox(width: 4),
            _miniBtn(Icons.refresh, '全部重试',
                () => _retryAll()),
          ],
          TextButton.icon(
            onPressed: () => _clearAll(),
            icon: const Icon(Icons.delete_sweep,
                size: 16, color: Colors.white38),
            label: const Text('清空全部',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white38)),
          ),
        ],
      ),
    );
  }

  Widget _statChip(String label, int count,
      Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 7, height: 7,
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text('$label ',
            style: const TextStyle(
                fontSize: 12,
                color: Colors.white38)),
        Text('$count',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color)),
      ],
    );
  }

  Widget _buildList(
      List<DownloadVideoInfo> items) {
    if (items.isEmpty) {
      return const Center(
        child: Text('暂无数据',
            style: TextStyle(
                color: Colors.white24)),
      );
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) =>
          _buildItem(items[i]),
    );
  }

  Widget _buildItem(
      DownloadVideoInfo item) {
    final (label, color) = _statusMap[
            item.status] ??
        ('未知', Colors.grey);
    final showProgress =
        item.status == 'downloading' ||
            item.status == 'pause';

    return Container(
      margin:
          const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius:
            BorderRadius.circular(10),
        border: Border.all(
            color: Colors.white
                .withValues(alpha: 0.06)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (showProgress)
            Positioned.fill(
              child: Align(
                alignment:
                    Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor:
                      item.progress > 0
                          ? item.progress
                          : 0,
                  child: Container(
                      color: _accent
                          .withValues(
                              alpha: 0.1)),
                ),
              ),
            ),
          Padding(
            padding:
                const EdgeInsets.all(12),
            child: Column(
              children: [
                VideoItem(item),
                const SizedBox(height: 8),
                if (item.errorMsg != null &&
                    item.errorMsg!
                        .isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                            bottom: 6),
                    child: Text(
                        item.errorMsg!,
                        maxLines: 2,
                        overflow: TextOverflow
                            .ellipsis,
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors
                                .redAccent
                                .withValues(
                                    alpha:
                                        0.7))),
                  ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  children: [
                    Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape
                                    .circle)),
                        const SizedBox(
                            width: 6),
                        Text(label,
                            style: TextStyle(
                                fontSize: 12,
                                color: color)),
                        if (showProgress) ...[
                          const SizedBox(
                              width: 8),
                          Text(
                              '${(item.progress * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                  fontSize: 12,
                                  color:
                                      Colors.white30)),
                        ],
                      ],
                    ),
                    Row(
                        mainAxisSize:
                            MainAxisSize
                                .min,
                        children: _buildActions(
                            item)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions(
      DownloadVideoInfo item) {
    final actions = <Widget>[];
    switch (item.status) {
      case 'downloading':
        actions.add(_iconBtn(
            Icons.pause_rounded, '暂停',
            () => _pauseVideo(item)));
        break;
      case 'pause':
        actions.add(_iconBtn(
            Icons.play_arrow_rounded,
            '继续',
            () => _resumeVideo(item)));
        break;
      case 'error':
        actions.add(_iconBtn(
            Icons.refresh_rounded, '重试',
            () => _retryVideo(item)));
        break;
      case 'done':
        actions.add(const Icon(
            Icons.check_circle,
            color: Color(0xFF81C784),
            size: 18));
        actions.add(_iconBtn(
            Icons.folder_open, '打开目录',
            () {
          final dir = Directory(
              _settings.downloadDir);
          if (!dir.existsSync())
            dir.createSync(
                recursive: true);
          Process.run('open',
              [dir.absolute.path],
              runInShell: true);
        }));
        break;
    }
    actions.add(_iconBtn(
        Icons.delete_outline, '删除',
        () => _deleteVideo(item)));
    return actions;
  }

  Widget _iconBtn(IconData icon,
      String tooltip, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(4),
      child: Padding(
        padding:
            const EdgeInsets.all(4),
        child: Tooltip(
            message: tooltip,
            child: Icon(icon,
                size: 18,
                color: Colors.white38)),
      ),
    );
  }

  Widget _miniBtn(IconData icon,
      String tooltip, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(4),
      child: Padding(
        padding:
            const EdgeInsets.all(4),
        child: Tooltip(
            message: tooltip,
            child: Icon(icon,
                size: 16,
                color: Colors.white38)),
      ),
    );
  }
}
