import 'package:dashboard_mealz/core/core.dart';
import 'package:dashboard_mealz/core/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Core.instance.init();

  print(Core.instance.authCore.initialRoute);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Core.instance.authCore.initialRoute,
      getPages: NavigationRoutes.getRoutes(),
    ),
  );
}
