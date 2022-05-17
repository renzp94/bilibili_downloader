import 'package:bilibili_downloader/app.dart';
import 'package:bilibili_downloader/models/db.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DB.init();
  runApp(const App());
}
