import 'package:dashboard_mealz/presentation/item/view/controllers/data_grid_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemPageController extends GetxController {
  final RxInt currentPageIndex = 0.obs;

  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  final DataGridController _dataGridController = Get.find<DataGridController>();

  DataGridController get dataGridController => _dataGridController;

  void changePage(int index) {
    currentPageIndex.value = index;
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
