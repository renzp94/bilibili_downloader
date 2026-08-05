import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/routes.dart';

class Store extends GetxController {
  static Store get to => Get.find();

  var pageControllerIndex = Pages.home.index.obs;
  var pageController = PageController(initialPage: Pages.home.index);
  var refreshSignal = 0.obs;

  void animateToPage(Enum page) {
    pageControllerIndex.value = page.index;
    if (page == Pages.downloadManage) refreshSignal++;
    update();
    pageController.animateToPage(page.index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
