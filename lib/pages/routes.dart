import 'package:flutter/material.dart';

import 'download_manage.dart';
import 'home.dart';

enum Pages {
  home,
  downloadManage,
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
];