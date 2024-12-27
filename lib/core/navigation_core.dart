import 'package:dashboard_mealz/core/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationCore {
  NavigationCore._();

  static final NavigationCore _instance = NavigationCore._();

  static NavigationCore get instance => _instance;

   void push(Widget widget) {
    Get.to(() => widget);
  }

   void pushNamed(String routeName) {
    Get.toNamed(routeName);
  }

   void pushReplacementNamed(String routeName) {
    Get.offNamed(routeName);
  }

  static GetMaterialApp init() {
    return GetMaterialApp(
      initialRoute: NavigationRoutes.home,
      getPages: NavigationRoutes.getRoutes(),
    );
  }
}
