import 'package:bilibili_downloader/layout/content.dart';
import 'package:flutter/material.dart';

import 'aside.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F0F1A), Color(0xFF1A1A2E), Color(0xFF12121F)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: const Row(children: [LayoutAside(), LayoutContent()]),
      ),
    );
  }
}
