import 'dart:ui';

class AppColors {
  AppColors._();

  static AppColors? _instance;

  static AppColors get instance => _instance ??= AppColors._();

  Color get appBlueColor => const Color(0xFF6381E6);
}
