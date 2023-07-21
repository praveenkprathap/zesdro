import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zesdro/app/data/models/user_model.dart';
import 'package:zesdro/app/routes/app_pages.dart';
import 'package:zesdro/utils/constants.dart';
import 'package:zesdro/utils/object_box_global.dart';

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
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      try {
        var data = GetStorage().read(Constants.user);
        ObjectBoxSingleton.instance.user = UserModel.fromMap(data);
      } catch (e) {
        print(e);
      }

      if (ObjectBoxSingleton.instance.user != null) {
        Get.offNamed(Routes.HOME);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    });
  }
}
