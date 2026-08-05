import 'package:flutter/material.dart';

class AsideMenuData {
  final String title;
  final IconData? icon;
  AsideMenuData({required this.title, this.icon});
}

class AsideMenu extends StatelessWidget {
  final List<AsideMenuData> data;
  final int selectedIndex;
  final Function(int)? onItemTap;

  const AsideMenu({
    super.key,
    required this.data,
    required this.selectedIndex,
    this.onItemTap,
  });

  static const _accent = Color(0xFFFB7299);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.fromLTRB(12, 12, 0, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 28, 20, 20),
            child: Row(
              children: [
                Icon(Icons.movie_creation_outlined,
                    size: 28, color: _accent),
                SizedBox(width: 12),
                Text('BiliDown',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: 14,
                      color: _accent,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: List.generate(data.length, (i) {
                  final active = selectedIndex == i;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (i == 2)
                        const Padding(
                          padding: EdgeInsets.fromLTRB(12, 20, 0, 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('通用',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white38,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.8)),
                          ),
                        ),
                      GestureDetector(
                        onTap: () => onItemTap?.call(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          margin: const EdgeInsets.only(bottom: 2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 9),
                          decoration: BoxDecoration(
                            color: active
                                ? _accent.withValues(alpha: 0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(data[i].icon,
                                  size: 18,
                                  color: active
                                      ? _accent
                                      : Colors.white54),
                              const SizedBox(width: 12),
                              Text(data[i].title,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: active
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: active
                                        ? _accent
                                        : Colors.white70,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
