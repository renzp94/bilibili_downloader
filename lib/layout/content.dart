import 'package:bilibili_downloader/store/store.dart';
import 'package:flutter/material.dart';

import '../pages/routes.dart';

class LayoutContent extends StatelessWidget {
  const LayoutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.06),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: PageView(
            controller: Store.to.pageController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: routes.map((e) => e.page).toList(),
          ),
        ),
      ),
    );
  }
}
