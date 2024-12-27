import 'package:dashboard_mealz/presentation/item/controllers/item_page_controller.dart';
import 'package:dashboard_mealz/presentation/item/view/controllers/data_grid_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController {
  final RxInt currentPageIndex = 0.obs;
  final List<List<String>> data = [];

  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  final DataGridController _dataGridController = Get.find<DataGridController>();
  final ItemPageController _itemPageController = Get.find<ItemPageController>();

  DataGridController get dataGridController => _dataGridController;
  ItemPageController get itemPageController => _itemPageController;

  void changePage(int index) {
    currentPageIndex.value = index;
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    _itemPageController.changePage(0);
  }

  void parseExcelData(List<List<String>> data) {
    this.data.addAll(data);
  }
}
