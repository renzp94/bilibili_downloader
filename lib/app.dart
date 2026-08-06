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
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0F0F1A),
          dialogTheme: const DialogThemeData(
            backgroundColor: Color(0xFF1E1E2E),
          ),
          splashColor: Colors.white.withValues(alpha: 0.06),
          highlightColor: Colors.white.withValues(alpha: 0.03),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF0275EE),
            secondary: Color(0xFF0275EE),
          ),
        ),
        home: const Scaffold(body: Layout()));
  }
}
