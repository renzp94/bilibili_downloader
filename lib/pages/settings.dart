import 'package:bilibili_downloader/constant.dart';
import 'package:bilibili_downloader/models/settings.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/tools.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Settings? _settings;
  final List<int> _taskCountList = [1, 3, 5, 10];

  @override
  void initState() {
    super.initState();
    setSettings();
  }

  void setSettings() async {
    Settings settings = await getSettings();
    setState(() {
      _settings = settings;
    });
  }

  Future<void> _getDirectoryPath(BuildContext context) async {
    const String confirmButtonText = 'Choose';
    print(_settings?.downloadDir);
    final String? directoryPath = await getDirectoryPath(
      initialDirectory: _settings?.downloadDir,
      confirmButtonText: confirmButtonText,
    );
    if (directoryPath == null) {
      return;
    }
    setState(() {
      _settings!.downloadDir = directoryPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: _settings != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: InkWell(
                          child: Text(
                            _settings!.downloadDir,
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.grey),
                          ),
                          onTap: () => _getDirectoryPath(context),
                        ),
                        leading: const Text(
                          '下载目录: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                        leading: const Text('下载任务：'),
                        title: Row(
                          children: _taskCountList
                              .map((item) => Expanded(
                                    child: RadioListTile(
                                      title: Text(item.toString()),
                                      value: item,
                                      contentPadding: const EdgeInsets.all(0),
                                      selected:
                                          _settings!.maxDownloadCount == item,
                                      groupValue: _settings!.maxDownloadCount,
                                      onChanged: (int? value) {
                                        if (value != null) {
                                          setState(() {
                                            _settings!.maxDownloadCount = value;
                                          });
                                        }
                                      },
                                    ),
                                  ))
                              .toList(),
                        )),
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      height: 40,
                      margin: const EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                        child: const Text('保存'),
                        onPressed: () {
                          Box<Settings> db =
                              Hive.box<Settings>(settingsBoxName);
                          if (db.isEmpty) {
                            db.add(_settings!);
                          } else {
                            db.putAt(0, _settings!);
                          }

                          successTips("保存成功");
                        },
                      ),
                    ),
                  ),
                ],
              )
            : const Icon(Icons.hourglass_empty));
  }
}
