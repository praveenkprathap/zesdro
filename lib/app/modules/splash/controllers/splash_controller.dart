import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:zesdro/app/routes/app_pages.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var a = 0;
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    animationController.forward();
    // Future.delayed(const Duration(milliseconds: 3000))
    //     .then((value) => Get.offNamed(Routes.HOME));
  }
}
