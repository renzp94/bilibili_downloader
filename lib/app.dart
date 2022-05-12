import 'package:bilibili_downloader/pages/download_manage.dart';
import 'package:bilibili_downloader/pages/home.dart';
import 'package:bilibili_downloader/widgets/menu_item.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(
      title: "bilibili下载器",
      home: Scaffold(
        body: Row(children: [
          Container(
            width: 240,
            color: Colors.white70,
            child: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://www.bilibili.com/favicon.ico',
                      color: Colors.blue,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12, top: 4),
                      child: Text(
                        'Bilibili下载器',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      children: [
                        MenuItem(
                          title: '首页',
                          icon: Icons.home,
                          isSelected: _currentIndex == 0,
                          onTap: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                            _pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                        ),
                        MenuItem(
                          title: '下载管理',
                          icon: Icons.download,
                          isSelected: _currentIndex == 1,
                          onTap: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                            _pageController.animateToPage(1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                        ),
                      ],
                    )),
              )
            ]),
          ),
          Expanded(
              child: PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: const [HomePage(), DownloadManagePage()],
          ))
        ]),
      ),
    );
  }
}
