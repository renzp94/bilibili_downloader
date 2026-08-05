import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Logger {
  static final Logger _instance = Logger._();
  factory Logger() => _instance;
  Logger._();

  File? _file;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _file = File('${dir.path}/bilibili_downloader.log');
    if (_file!.existsSync() && _file!.lengthSync() > 1024 * 1024) {
      final content = _file!.readAsStringSync();
      _file!.writeAsStringSync(content.substring(content.length ~/ 2));
    }
  }

  void _write(String level, String msg) {
    final time = DateTime.now().toIso8601String().substring(0, 19);
    final line = '[$time] [$level] $msg';
    if (_file != null) {
      _file!.writeAsStringSync('$line\n', mode: FileMode.append, flush: true);
    }
  }

  void info(String msg) => _write('INFO', msg);
  void warn(String msg) => _write('WARN', msg);
  void error(String msg) => _write('ERROR', msg);

  String? get filePath => _file?.path;
}
