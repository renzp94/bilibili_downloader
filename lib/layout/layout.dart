import 'dart:ui';

import 'package:bilibili_downloader/layout/content.dart';
import 'package:flutter/material.dart';

import 'aside.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
            color: Colors.white.withOpacity(0.5),
            child: Row(children: const [LayoutAside(), LayoutContent()])),
      ),
    );
  }
}
