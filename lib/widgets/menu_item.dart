import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final IconData? icon;
  final bool? isSelected;

  const MenuItem(
      {Key? key, required this.title, this.onTap, this.icon, this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool active = isSelected != null && isSelected!;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        leading: icon != null
            ? Icon(
                icon,
                color: active ? Colors.white : Colors.black,
              )
            : null,
        title: Text(
          title,
          style: TextStyle(color: active ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
