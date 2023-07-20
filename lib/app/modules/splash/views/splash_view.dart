import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zesdro/app/components/zoom_animation_widget.dart';
import 'package:zesdro/config/theme/light_theme_colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CircularRevealAnimation(
            // @required [Animation<double>]
            animation: controller.animation,
            // child's center if not specified
            centerAlignment: Alignment.center,
            // 0 if not specified
            minRadius: 12,
            // distance from center to further child's corner if not specified
            maxRadius: Get.height,
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                radius: 1.0,
                colors: [
                  LightThemeColors.accentColor,
                  LightThemeColors.primaryColor,
                  //DarkThemeColors.primaryColor,
                ],
              )),
              child: Center(
                child: ZoomInOutWidget(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      SizedBox(
                          height: 75,
                          child: Image.asset("assets/images/app_icon.png")),
                      Text(
                        "ZESDRO",
                        style: Get.theme.textTheme.headlineSmall,
                      ),
                      const Spacer(),
                      Text(
                        "Version V1.0.0",
                        style: Get.theme.textTheme.labelSmall!
                            .copyWith(color: LightThemeColors.accentColor),
                      ),
                      Text(
                        "ZESDRO TECHNOLOGIES PRIVATE LIMITED",
                        style: Get.theme.textTheme.labelSmall!
                            .copyWith(color: LightThemeColors.accentColor),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
