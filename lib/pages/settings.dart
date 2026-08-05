import 'dart:io';

import 'package:bilibili_downloader/models/database.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import '../utils/logger.dart';
import '../utils/tools.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Settings? _settings;
  bool _saving = false;
  static const _taskCountList = [1, 3, 5, 10];
  static const _splitCountList = [1, 2, 4, 8];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final s = await getSettings();
    setState(() => _settings = s);
  }

  Future<void> _pickDirectory() async {
    final path = await getDirectoryPath(
      initialDirectory: _settings?.downloadDir,
      confirmButtonText: 'Choose',
    );
    if (path == null) return;
    setState(() => _settings = _copy(downloadDir: path));
  }

  Settings _copy({
    String? downloadDir,
    int? maxDownloadCount,
    int? splitCount,
    int? quality,
  }) {
    return Settings(
      id: _settings!.id,
      downloadDir: downloadDir ?? _settings!.downloadDir,
      maxDownloadCount: maxDownloadCount ?? _settings!.maxDownloadCount,
      splitCount: splitCount ?? _settings!.splitCount,
      deleteWithFile: _settings!.deleteWithFile,
      skipDeleteConfirm: _settings!.skipDeleteConfirm,
      quality: quality ?? _settings!.quality,
    );
  }

  void _save() async {
    setState(() => _saving = true);
    await Get.find<AppDatabase>().saveSettings(_settings!);
    setState(() => _saving = false);
    successTips('保存成功');
  }

  void _openLogDir() async {
    final path = Logger().filePath;
    if (path == null) return;
    final dir = Directory(path).parent;
    await Process.run('open', [dir.absolute.path], runInShell: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_settings == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(
        children: [
          _section('下载设置', Icons.download, [
            _buildDirSetting(),
            _buildChoiceGroup(
                '下载任务数', _taskCountList, _settings!.maxDownloadCount,
                (v) => setState(() => _settings = _copy(maxDownloadCount: v))),
            _buildChoiceGroup(
                '分片数', _splitCountList, _settings!.splitCount,
                (v) => setState(() => _settings = _copy(splitCount: v))),
            _buildQualitySetting(),
          ]),
          const SizedBox(height: 16),
          _section('其他', Icons.more_horiz, [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: _cardDecoration(),
              child: ListTile(
                leading: const Icon(Icons.article_outlined, size: 20, color: Colors.black54),
                title: const Text('查看日志', style: TextStyle(fontSize: 13)),
                trailing: const Icon(Icons.chevron_right, size: 18),
                dense: true,
                contentPadding: EdgeInsets.zero,
                onTap: _openLogDir,
              ),
            ),
          ]),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 200,
              height: 44,
              child: ElevatedButton.icon(
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox(
                        width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.save, size: 18),
                label: const Text('保存设置', style: TextStyle(fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8, top: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Colors.black54),
              const SizedBox(width: 6),
              Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildDirSetting() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const Icon(Icons.folder, size: 20, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: _pickDirectory,
              borderRadius: BorderRadius.circular(4),
              child: Text(_settings!.downloadDir,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.folder_open, size: 18),
            tooltip: '打开目录',
            onPressed: () async {
              final dir = Directory(_settings!.downloadDir);
              if (!dir.existsSync()) dir.createSync(recursive: true);
              await Process.run('open', [dir.absolute.path], runInShell: true);
            },
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            tooltip: '更改目录',
            onPressed: _pickDirectory,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceGroup(
      String label, List<int> options, int current, ValueChanged<int> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Text('$label：', style: const TextStyle(fontSize: 13)),
          Expanded(
            child: RadioGroup<int>(
              groupValue: current,
              onChanged: (v) { if (v != null) onChanged(v); },
              child: Row(
                children: options.map((v) => Expanded(
                  child: RadioListTile(
                    title: Text('$v', style: const TextStyle(fontSize: 14)),
                    value: v, dense: true,
                    contentPadding: EdgeInsets.zero,
                    selected: current == v,
                    visualDensity: VisualDensity.compact,
                  ),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualitySetting() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const Text('视频画质：', style: TextStyle(fontSize: 13)),
          Expanded(
            child: RadioGroup<int>(
              groupValue: _settings!.quality,
              onChanged: (v) {
                if (v != null) {
                  setState(() => _settings = _copy(quality: v));
                }
              },
              child: Row(
                children: qualityOptions
                    .map((e) => Expanded(
                          child: RadioListTile(
                            title: Text(e.$2, style: const TextStyle(fontSize: 13)),
                            value: e.$1, dense: true,
                            contentPadding: EdgeInsets.zero,
                            selected: _settings!.quality == e.$1,
                            visualDensity: VisualDensity.compact,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
