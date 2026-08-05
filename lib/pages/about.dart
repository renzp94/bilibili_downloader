import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/tools.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const _repoUrl = 'https://github.com/renzp94/bilibili_downloader';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/images/logo.png',
                      height: 72, width: 72),
                ),
                const SizedBox(height: 12),
                Text('BiliDown',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 16,
                      color: Colors.black.withValues(alpha: 0.7),
                    )),
                const SizedBox(height: 8),
                Text('B站视频下载工具 · 开源跨平台',
                    style: TextStyle(
                        fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _infoCard(),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _infoRow(Icons.info_outline, '版本', 'V0.1.0'),
          const Divider(height: 24),
          _infoRow(Icons.person_outline, '作者', 'renzp94'),
          const Divider(height: 24),
          _infoRowWithAction(
            Icons.code, '仓库', _repoUrl, () {
              Clipboard.setData(const ClipboardData(text: _repoUrl));
              successTips('已复制');
            },
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 12),
        Text('$label：', style: const TextStyle(fontSize: 13)),
        const SizedBox(width: 4),
        Flexible(child: Text(value, style: const TextStyle(fontSize: 13, color: Colors.black54))),
      ],
    );
  }

  Widget _infoRowWithAction(IconData icon, String label, String value, VoidCallback onTap) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 12),
        Text('$label：', style: const TextStyle(fontSize: 13)),
        const SizedBox(width: 4),
        Flexible(child: Text(value, style: const TextStyle(fontSize: 13, color: Colors.black54))),
        const SizedBox(width: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.copy, size: 15, color: Colors.black45),
          ),
        ),
      ],
    );
  }
}
