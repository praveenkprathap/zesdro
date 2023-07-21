import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:zesdro/config/theme/light_theme_colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              Lottie.asset('assets/lottie/login.json'),
              const Spacer(),
              Text(
                "ZESDRO",
                style: Get.theme.textTheme.headlineMedium!.copyWith(
                    color:
                        LightThemeColors.headlinesTextColor.withOpacity(0.7)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Text(
                  "Unlock the full potential of our app by logging in with Google and enjoy seamless access to exclusive features and personalized content!",
                  style: Get.theme.textTheme.labelMedium!.copyWith(
                      color:
                          LightThemeColors.headlinesTextColor.withOpacity(0.7)),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              SignInButton(
                Buttons.googleDark,
                onPressed: controller.signInHandler,
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
