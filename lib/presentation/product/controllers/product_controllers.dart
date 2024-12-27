import 'package:dashboard_mealz/common/shared_widgets/order_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductControllers extends GetxController {
  Future<void> showRow(int index) async {
    await showDialog(
        context: Get.context!,
        builder: (context) => const OrderDetailsDialog());
  }
}
