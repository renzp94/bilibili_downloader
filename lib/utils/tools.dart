import 'package:flutter/material.dart';
import 'package:get/get.dart';

void warningTips(String message) {
  Get.snackbar('', message,
      titleText: Text(
        '警告',
        style: TextStyle(
            color: Colors.amber.shade900, fontWeight: FontWeight.w900),
      ),
      icon: Icon(
        Icons.warning,
        color: Colors.amber.shade900,
      ),
      snackPosition: SnackPosition.TOP,
      maxWidth: 300,
      duration: const Duration(milliseconds: 1500),
      animationDuration: const Duration(milliseconds: 300));
}