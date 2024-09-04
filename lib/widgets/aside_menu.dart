import 'package:flutter/material.dart';

import 'aside_menu_item.dart';

class AsideMenuData {
  final String title;
  final IconData? icon;

  AsideMenuData({required this.title, this.icon});
}

class AsideMenu extends StatefulWidget {
  final List<AsideMenuData> data;
  final int selectedIndex;
  final Function? onItemTap;
  const AsideMenu({
    super.key,
    required this.data,
    required this.selectedIndex,
    this.onItemTap,
  });

  @override
  State<AsideMenu> createState() => _AsideMenuState();
}

class _AsideMenuState extends State<AsideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  'assets/images/logo.png',
                ),
                height: 40,
                width: 40,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12, top: 8),
                child: Text(
                  'BiliDown',
                  style: TextStyle(
                      fontFamily: "PressStart2P",
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: widget.data
                    .asMap()
                    .keys
                    .map((i) => AsideMenuItem(
                          title: widget.data[i].title,
                          icon: widget.data[i].icon,
                          isSelected: widget.selectedIndex == i,
                          onTap: () {
                            if (widget.onItemTap != null) {
                              widget.onItemTap!(i);
                            }
                          },
                        ))
                    .toList(),
              )),
        )
      ]),
    );
  }
}
