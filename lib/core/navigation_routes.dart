import 'package:dashboard_mealz/presentation/layout/controllers/layout_binding.dart';
import 'package:dashboard_mealz/presentation/layout/layout.dart';
import 'package:dashboard_mealz/presentation/sign/controllers/sign_binding.dart';
import 'package:dashboard_mealz/presentation/sign/sign.dart';
import 'package:get/get.dart';

class NavigationRoutes {
  static const String home = '/';
  static const String sign = '/sign-in';

  static List<GetPage> getRoutes() {
    return [
      GetPage(
          name: home,
          page: () => Layout(),
          binding: LayoutBinding(),
          transition: Transition.fadeIn),
      GetPage(
          name: sign,
          page: () => SignPage(),
          binding: SignBinding(),
          transition: Transition.fadeIn),
    ];
  }
}
