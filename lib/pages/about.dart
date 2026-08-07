import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/tools.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  void _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _version = 'V${info.version}');
  }

  static const _repoUrl = 'https://github.com/renzp94/bilibili_downloader';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset('assets/images/logo.png',
                  height: 80, width: 80),
            ),
            const SizedBox(height: 16),
            const Text('biliDown',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            const SizedBox(height: 6),
            const Text('B站视频下载工具 · 开源跨平台',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white38)),
            const SizedBox(height: 32),
            _glassCard(),
          ],
        ),
      ),
    );
  }

  Widget _glassCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 28, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        children: [
          _infoRow(Icons.info_outline, '版本',
              _version.isNotEmpty ? _version : '...'),
          const Divider(height: 28, color: Colors.white12),
          _infoRow(Icons.person_outline, '作者', 'renzp94'),
          const Divider(height: 28, color: Colors.white12),
          _infoRowWithAction(Icons.code, '仓库', _repoUrl,
              () {
            Clipboard.setData(
                const ClipboardData(text: _repoUrl));
            successTips('已复制');
          }),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white38),
        const SizedBox(width: 12),
        Text('$label：',
            style: const TextStyle(
                fontSize: 13, color: Colors.white70)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(value,
              style: const TextStyle(
                  fontSize: 13, color: Colors.white38)),
        ),
      ],
    );
  }

  Widget _infoRowWithAction(IconData icon, String label,
      String value, VoidCallback onTap) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white38),
        const SizedBox(width: 12),
        Text('$label：',
            style: const TextStyle(
                fontSize: 13, color: Colors.white70)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(value,
              style: const TextStyle(
                  fontSize: 13, color: Colors.white38)),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onTap,
          child: const Icon(Icons.copy, size: 14,
              color: Colors.white24),
        ),
      ],
    );
  }
}
