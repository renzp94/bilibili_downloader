import 'package:flutter/material.dart';

class AsideMenuItem extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final IconData? icon;
  final bool? isSelected;

  const AsideMenuItem(
      {Key? key, required this.title, this.onTap, this.icon, this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool active = isSelected != null && isSelected!;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        leading: icon != null
            ? Icon(
                icon,
                color: active ? Colors.white : Colors.black87,
              )
            : null,
        title: Text(
          title,
          style: TextStyle(color: active ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
