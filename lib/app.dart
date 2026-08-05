import 'package:bilibili_downloader/layout/layout.dart';
import 'package:bilibili_downloader/store/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'models/database.dart';
import 'utils/logger.dart';

class App extends StatelessWidget {
  const App({super.key});

  static void start() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Logger().init();
    Logger().info('应用启动');
    Get.put(AppDatabase());
    Get.put(Store());

    runApp(const App());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "BiliDown",
        home: Scaffold(
          backgroundColor: Colors.grey[100],
          body: const Layout(),
        ));
  }
}
