import 'package:dashboard_mealz/presentation/item/controllers/item_page_controller.dart';
import 'package:dashboard_mealz/presentation/item/view/controllers/data_grid_controller.dart';
import 'package:dashboard_mealz/presentation/item/view/file_upload/controllers/file_upload_controller.dart';
import 'package:dashboard_mealz/presentation/layout/controllers/layout_controller.dart';
import 'package:dashboard_mealz/presentation/product/controllers/product_controllers.dart';
import 'package:get/get.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LayoutController());
    Get.lazyPut(() => ProductControllers());
    Get.lazyPut(() => ItemPageController());
    Get.lazyPut(() => FileUploadController());
    Get.lazyPut(() => DataGridController());
  }
}
