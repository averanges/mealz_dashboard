import 'package:dashboard_mealz/presentation/sign/controllers/sign_controller.dart';
import 'package:get/get.dart';

class SignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignController());
  }
}
