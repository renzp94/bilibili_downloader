import 'dart:io';

import 'package:bilibili_downloader/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../constant.dart';

void warningTips(String message) {
  Get.snackbar('', message,
      titleText: Text(
        '警告',
        style: TextStyle(
            color: Colors.amber.shade900, fontWeight: FontWeight.w900),
      ),
      icon: Icon(
        Icons.warning,
        color: Colors.amber.shade900,
      ),
      snackPosition: SnackPosition.TOP,
      maxWidth: 300,
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 300));
}

void successTips(String message) {
  Get.snackbar('', message,
      titleText: const Text(
        '成功',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.w900),
      ),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
      snackPosition: SnackPosition.TOP,
      maxWidth: 300,
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 300));
}

Future<String> getDefaultDownloadDir() async {
  Directory? appDownloadDir = await getDownloadsDirectory();
  appDownloadDir ??= await getApplicationDocumentsDirectory();
  String downloadDir = appDownloadDir.path;

  List<String> dirs = downloadDir.split('/');
  dirs.removeLast();
  dirs.add(defaultDownloadDir);

  return dirs.join('/');
}

Future<Settings> getSettings() async {
  String defaultDownloadDir = await getDefaultDownloadDir();
  Box<Settings>? dbSettings = Hive.box<Settings>(settingsBoxName);

  return dbSettings.get(0) ??
      Settings(
          downloadDir: defaultDownloadDir,
          maxDownloadCount: defaultMaxDownloadCount);
}
