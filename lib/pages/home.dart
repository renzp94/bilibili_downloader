import 'package:bilibili_downloader/constant.dart';
import 'package:bilibili_downloader/models/database.dart';
import 'package:bilibili_downloader/store/store.dart';
import 'package:bilibili_downloader/utils/tools.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Value;

import '../api/video.dart';
import 'routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final _urlController = TextEditingController();
  bool _searching = false;
  String? _videoTitle;
  String? _videoPic;
  List<DownloadVideoInfo> _list = [];
  List<SearchHistory> _history = [];
  final Set<int> _checkedCids = {};
  late Settings _settings;

  @override
  void initState() {
    super.initState();
    _initSettings();
    _loadHistory();
  }

  void _initSettings() async => _settings = await getSettings();
  void _loadHistory() async {
    final h = await Get.find<AppDatabase>().recentHistory();
    if (mounted) setState(() => _history = h);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;
    if (!url.contains(videoUrlPrefix)) {
      warningTips('请输入正确的B站视频链接');
      return;
    }
    _getVideoList(url);
  }

  void _searchFromHistory(SearchHistory h) {
    _urlController.text = h.url;
    _getVideoList(h.url);
  }

  Future<void> _getVideoList(String url) async {
    setState(() => _searching = true);
    try {
      final bvid = _parseBvid(url);
      final res = await fetchVideoList(bvid);
      final data = res.data['data'];
      final title = data['title'] as String;
      final pic = data['pic'] as String;
      setState(() {
        _videoTitle = title;
        _videoPic = pic;
        final pages = data['pages'] as List;
        _list = List.generate(
            pages.length,
            (i) => DownloadVideoInfo(
                  id: -1,
                  bvid: bvid,
                  aid: data['aid'],
                  pic: pic,
                  cid: pages[i]['cid'],
                  title: pages.length > 1
                      ? 'P${i + 1} ${pages[i]['part']}'
                      : title,
                  progress: 0,
                  status: i < _settings.maxDownloadCount
                      ? 'downloading'
                      : 'wait',
                  errorMsg: null,
                ));
        _checkedCids.clear();
        _checkedCids.addAll(_list.map((e) => e.cid));
      });
      Get.find<AppDatabase>().addHistory(url, title, pic);
    } catch (_) {
      warningTips('获取视频信息失败');
    } finally {
      setState(() => _searching = false);
    }
  }

  String _parseBvid(String url) {
    final start = videoUrlPrefix.length;
    var end = url.length;
    if (url.contains('?')) end = url.indexOf('?');
    return url.substring(start, end).replaceAll('/', '');
  }

  void _toggleItem(DownloadVideoInfo item) {
    setState(() {
      if (_checkedCids.contains(item.cid)) {
        _checkedCids.remove(item.cid);
      } else {
        _checkedCids.add(item.cid);
      }
    });
  }

  void _toggleAll() {
    setState(() {
      if (_checkedCids.length == _list.length) {
        _checkedCids.clear();
      } else {
        _checkedCids.addAll(_list.map((e) => e.cid));
      }
    });
  }

  Future<void> _onDownload() async {
    if (_checkedCids.isEmpty) return;
    final selected =
        _list.where((e) => _checkedCids.contains(e.cid)).toList();
    final db = Get.find<AppDatabase>();
    final existingCids = (await db.allVideos()).map((e) => e.cid).toSet();

    final toAdd =
        selected.where((e) => !existingCids.contains(e.cid)).toList();
    if (toAdd.isNotEmpty) {
      await db.addVideos(toAdd
          .map((item) => DownloadVideosCompanion.insert(
                bvid: item.bvid,
                aid: item.aid,
                pic: item.pic,
                cid: item.cid,
                title: item.title,
                status: Value(item.status),
              ))
          .toList());
    }
    Store.to.animateToPage(Pages.downloadManage);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final hasResult = _list.isNotEmpty;

    return Column(
      children: [
        // 头部
        _buildHeader(),
        // 搜索栏
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
          child: _buildSearchBar(),
        ),
        // 内容区
        Expanded(
            child: hasResult ? _buildResult() : _buildEmpty()),
        // 底部下载栏
        if (hasResult && _checkedCids.isNotEmpty)
          _buildBottomBar(),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 32, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png',
              height: 32, width: 32),
          const SizedBox(width: 8),
          Text('BiliDown',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                fontSize: 16,
                color: Colors.black.withValues(alpha: 0.8),
              )),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _urlController,
            onSubmitted: (_) => _onSearch(),
            decoration: InputDecoration(
              prefixIcon:
                  const Icon(Icons.link, size: 20),
              hintText: '粘贴B站视频链接...',
              filled: true,
              fillColor:
                  Colors.white.withValues(alpha: 0.6),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: _searching ? null : _onSearch,
          icon: _searching
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2))
              : const Icon(Icons.search, size: 20),
          label: const Text('搜索'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildEmpty() {
    if (_history.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.video_library_outlined,
              size: 80,
              color: Colors.grey.withValues(alpha: 0.4)),
          const SizedBox(height: 16),
          Text('粘贴B站视频链接开始下载',
              style: TextStyle(
                  fontSize: 16,
                  color:
                      Colors.grey.withValues(alpha: 0.6))),
          const SizedBox(height: 4),
          Text('支持单个视频或多P视频',
              style: TextStyle(
                  fontSize: 13,
                  color:
                      Colors.grey.withValues(alpha: 0.4))),
        ],
      );
    }
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 4, bottom: 8),
            child: Row(
              children: [
                Icon(Icons.history,
                    size: 16,
                    color: Colors.black45),
                const SizedBox(width: 6),
                Text('搜索历史',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black45,
                        fontWeight: FontWeight.w500)),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    await Get.find<AppDatabase>()
                        .clearHistory();
                    if (mounted)
                      setState(() => _history = []);
                  },
                  child: Text('清空',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black38)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (_, i) =>
                  _buildHistoryItem(_history[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(SearchHistory h) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        onTap: () => _searchFromHistory(h),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(h.pic,
                    height: 40,
                    width: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        Container(
                            height: 40,
                            width: 72,
                            color: Colors.grey
                                .withValues(alpha: 0.15),
                            child: const Icon(
                                Icons.broken_image,
                                size: 14,
                                color:
                                    Colors.grey))),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(h.title,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13)),
                    const SizedBox(height: 2),
                    Text(h.url,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11,
                            color:
                                Colors.black38)),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  await Get.find<AppDatabase>()
                      .deleteHistory(h.id);
                  _loadHistory();
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close,
                      size: 14,
                      color: Colors.black26),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResult() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildResultHeader(),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (_, i) =>
                  _buildListItem(_list[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (_videoPic != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(_videoPic!,
                  height: 36,
                  width: 64,
                  fit: BoxFit.cover),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(_videoTitle ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
          ),
          const SizedBox(width: 8),
          _textButton(
            _checkedCids.length == _list.length
                ? '取消全选'
                : '全选',
            _toggleAll,
          ),
          const SizedBox(width: 8),
          Text(
              '${_checkedCids.length}/${_list.length}',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black
                      .withValues(alpha: 0.5))),
        ],
      ),
    );
  }

  Widget _buildListItem(DownloadVideoInfo item) {
    final checked = _checkedCids.contains(item.cid);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => _toggleItem(item),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: checked
                ? Colors.blue.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: checked
                ? Border.all(
                    color: Colors.blue
                        .withValues(alpha: 0.3))
                : null,
          ),
          child: Row(
            children: [
              Checkbox(
                value: checked,
                onChanged: (_) =>
                    _toggleItem(item),
                visualDensity:
                    VisualDensity.compact,
              ),
              const SizedBox(width: 4),
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(6),
                child: Image.network(
                  item.pic,
                  height: 54,
                  width: 96,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      Container(
                    height: 54,
                    width: 96,
                    color: Colors.grey
                        .withValues(alpha: 0.2),
                    child: const Icon(
                        Icons.broken_image,
                        color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(item.title,
                    style: const TextStyle(
                        fontSize: 14),
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 32, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        border: Border(
            top: BorderSide(
                color: Colors.black
                    .withValues(alpha: 0.06))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: _onDownload,
            icon: const Icon(Icons.download,
                size: 20),
            label: Text(
                '下载选中 (${_checkedCids.length}个)'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textButton(
      String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 4, vertical: 2),
        child: Text(text,
            style: const TextStyle(
                fontSize: 13,
                color: Colors.blue)),
      ),
    );
  }
}
