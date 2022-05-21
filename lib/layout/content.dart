import 'package:bilibili_downloader/store/store.dart';
import 'package:flutter/material.dart';

import '../pages/routes.dart';

class LayoutContent extends StatelessWidget {
  const LayoutContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.all(12),
          child: PageView(
            controller: Store.to.pageController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: routes.map((e) => e.page).toList(),
          )),
    );
  }
}
