import 'package:bilibili_downloader/pages/about.dart';
import 'package:bilibili_downloader/pages/settings.dart';
import 'package:flutter/material.dart';

import 'download_manage.dart';
import 'home.dart';

enum Pages {
  home,
  downloadManage,
  about,
  settings,
}

class Routes {
  final Pages key;
  final String title;
  final Widget page;
  final IconData? icon;

  const Routes({
    required this.key,
    required this.title,
    required this.page,
    this.icon,
  });
}

const routes = [
  Routes(key: Pages.home, title: '首页', page: HomePage(), icon: Icons.home),
  Routes(
      key: Pages.downloadManage,
      title: '下载管理',
      page: DownloadManagePage(),
      icon: Icons.download),
  Routes(
      key: Pages.settings,
      title: '设置',
      page: SettingsPage(),
      icon: Icons.settings),
  Routes(
      key: Pages.about,
      title: '关于',
      page: AboutPage(),
      icon: Icons.help_rounded),
];
