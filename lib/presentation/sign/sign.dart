import 'package:dashboard_mealz/common/consts/app_sizes.dart';
import 'package:dashboard_mealz/common/consts/colors.dart';
import 'package:dashboard_mealz/common/consts/images.dart';
import 'package:dashboard_mealz/common/utils/input_validators.dart';
import 'package:dashboard_mealz/presentation/sign/controllers/sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignPage extends StatelessWidget {
  SignPage({super.key});

  final SignController signController = Get.find<SignController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(builder: (context, constraints) {
          return Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 350,
              height: constraints.maxHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: SvgPicture.asset(AppImages.instance.logo),
                    ),
                  ),
                  SizedBox(height: AppSizes.instance.largeYPadding),
                  Obx(() {
                    return signController.errorMessage.value.isNotEmpty
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(signController.errorMessage.value,
                                style: const TextStyle(color: Colors.red)))
                        : const SizedBox.shrink();
                  }),
                  SizedBox(height: AppSizes.instance.mediumYPadding),
                  Form(
                    key: signController.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: signController.emailController,
                          onFieldSubmitted: (value) {
                            if (signController.formKey.currentState!
                                .validate()) {
                              signController.signIn();
                            }
                          },
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User ID...',
                          ),
                        ),
                        SizedBox(height: AppSizes.instance.smallYPadding),
                        TextFormField(
                          validator: InputValidators.passwordValidator,
                          controller: signController.passwordController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onFieldSubmitted: (value) {
                            if (signController.formKey.currentState!
                                .validate()) {
                              signController.signIn();
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password...',
                          ),
                        ),
                        SizedBox(height: AppSizes.instance.largeYPadding),
                        SignInButton(signController: signController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class SignInButton extends StatefulWidget {
  const SignInButton({super.key, required this.signController});

  final SignController signController;

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: GestureDetector(
          onTap: () async {
            if (widget.signController.formKey.currentState!.validate()) {
              await widget.signController.signIn();
            }
          },
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.instance.mediumHPadding),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isHover
                    ? AppColors.instance.appBlueColor.withOpacity(0.8)
                    : AppColors.instance.appBlueColor,
              ),
              child: const Text('Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)))),
    );
  }
}
