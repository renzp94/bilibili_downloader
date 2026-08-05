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
  static const _accent = Color(0xFFFB7299);

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
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_settings == null) {
      return const Center(
          child: CircularProgressIndicator(color: _accent));
    }

    return Padding(
      padding: const EdgeInsets.all(28),
      child: ListView(
        children: [
          _sectionTitle('下载设置'),
          const SizedBox(height: 8),
          _buildDirSetting(),
          _buildRadioGroup(
              '下载任务数', _taskCountList, _settings!.maxDownloadCount,
              (v) =>
                  setState(() => _settings = _copy(maxDownloadCount: v))),
          _buildRadioGroup(
              '分片数', _splitCountList, _settings!.splitCount,
              (v) => setState(() => _settings = _copy(splitCount: v))),
          _buildQualityRadio(),
          const SizedBox(height: 24),
          _sectionTitle('其他'),
          const SizedBox(height: 8),
          _glassCard(
            child: ListTile(
              leading: const Icon(Icons.article_outlined,
                  size: 18, color: Colors.white54),
              title: const Text('查看日志',
                  style: TextStyle(
                      fontSize: 13, color: Colors.white70)),
              trailing: const Icon(Icons.chevron_right,
                  size: 16, color: Colors.white24),
              dense: true,
              contentPadding: EdgeInsets.zero,
              onTap: _openLogDir,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              height: 44,
              child: ElevatedButton.icon(
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox(
                        width: 16, height: 16,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white))
                    : const Icon(Icons.save, size: 18),
                label: const Text('保存设置'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      _accent.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(text,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white38,
              letterSpacing: 0.5)),
    );
  }

  Widget _buildDirSetting() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _glassCard(
        child: Row(
          children: [
            const Icon(Icons.folder, size: 18,
                color: Colors.white54),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: _pickDirectory,
                child: Text(_settings!.downloadDir,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.folder_open, size: 17,
                  color: Colors.white38),
              tooltip: '打开目录',
              onPressed: () async {
                final dir =
                    Directory(_settings!.downloadDir);
                if (!dir.existsSync())
                  dir.createSync(recursive: true);
                await Process.run('open',
                    [dir.absolute.path],
                    runInShell: true);
              },
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 17,
                  color: Colors.white38),
              tooltip: '更改目录',
              onPressed: _pickDirectory,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioGroup(String label, List<int> options,
      int current, ValueChanged<int> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _glassCard(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, top: 4),
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70)),
            ),
            Row(
              children: options
                  .map((v) => Expanded(
                        child: RadioListTile(
                          title: Text('$v',
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70)),
                          value: v, dense: true,
                          activeColor: _accent,
                          contentPadding: EdgeInsets.zero,
                          selected: current == v,
                          groupValue: current,
                          visualDensity:
                              VisualDensity.compact,
                          onChanged: (int? value) {
                            if (value != null) onChanged(value);
                          },
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityRadio() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _glassCard(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 4),
              child: Text('视频画质',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70)),
            ),
            Row(
              children: qualityOptions
                  .map((e) => Expanded(
                        child: RadioListTile(
                          title: Text(e.$2,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70)),
                          value: e.$1, dense: true,
                          activeColor: _accent,
                          contentPadding: EdgeInsets.zero,
                          selected:
                              _settings!.quality == e.$1,
                          groupValue:
                              _settings!.quality,
                          visualDensity:
                              VisualDensity.compact,
                          onChanged: (int? value) {
                            if (value != null) {
                              setState(() => _settings =
                                  _copy(quality: value));
                            }
                          },
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
