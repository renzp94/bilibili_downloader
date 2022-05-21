import 'package:bilibili_downloader/pages/routes.dart';
import 'package:bilibili_downloader/store/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/aside_menu.dart';

class LayoutAside extends StatelessWidget {
  const LayoutAside({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AsideMenu(
          data: routes
              .map((e) => AsideMenuData(title: e.title, icon: e.icon))
              .toList(),
          selectedIndex: Store.to.pageControllerIndex.value,
          onItemTap: (i) => Store.to.animateToPage(Pages.values[i]),
        ));
  }
}
