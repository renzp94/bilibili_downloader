import 'dart:ui';

import 'package:bilibili_downloader/widgets/aside_menu.dart';
import 'package:flutter/material.dart';
import 'package:bilibili_downloader/pages/download_manage.dart';
import 'package:bilibili_downloader/pages/home.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "bilibili下载器",
      home: Scaffold(
          backgroundColor: Colors.grey[100],
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/menu_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                  color: Colors.white.withOpacity(0.5),
                  child: Row(children: [
                    AsideMenu(
                      data: [
                        AsideMenuData(title: '首页', icon: Icons.home),
                        AsideMenuData(title: '下载管理', icon: Icons.download),
                      ],
                      selectedIndex: _currentIndex,
                      onItemTap: (i) {
                        setState(() {
                          _currentIndex = i;
                        });
                        _pageController.animateToPage(i,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      },
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: const EdgeInsets.all(12),
                          child: PageView(
                            controller: _pageController,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (int index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            children: [
                              HomePage(
                                pageController: _pageController,
                              ),
                              const DownloadManagePage()
                            ],
                          )),
                    )
                  ])),
            ),
          )),
    );
  }
}
