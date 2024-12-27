import 'package:dashboard_mealz/presentation/item/controllers/item_page_controller.dart';
import 'package:dashboard_mealz/presentation/item/view/data_grid/data_grid.dart';
import 'package:dashboard_mealz/presentation/item/view/file_upload/file_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemPage extends StatelessWidget {
  ItemPage({super.key});

  final ItemPageController _itemPageController = Get.find<ItemPageController>();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _itemPageController.pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        _itemPageController.changePage(index);
      },
      children: [FileUpload(), DataGrid()],
    );
  }
}
