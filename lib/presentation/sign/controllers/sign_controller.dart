import 'package:dashboard_mealz/common/consts/enums.dart';
import 'package:dashboard_mealz/common/utils/token_generator.dart';
import 'package:dashboard_mealz/core/core.dart';
import 'package:dashboard_mealz/core/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class SignController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final String email = dotenv.env['TEST_ID']!;
  final String password = dotenv.env['TEST_PASSWORD']!;

  RxString errorMessage = RxString('');

  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  Future<void> signIn() async {
    try {
      if (emailController.text != email ||
          passwordController.text != password) {
        errorMessage.value = 'Invalid email or password';
        return;
      }
      final token = generateToken();
      await Core.instance.sharedPreferencesDataSource.set(
        SharedPreferencesKeys.userToken,
        token,
      );
      Core.instance.logger.d('User Token: $token');

      Core.instance.navigationCore.pushReplacementNamed(NavigationRoutes.home);
    } catch (e) {
      errorMessage.value = 'Something went wrong';
    }
  }
}
