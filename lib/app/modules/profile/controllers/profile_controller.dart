import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/utils.dart';
import 'package:zesdro/app/data/models/image_model.dart';
import 'package:zesdro/app/routes/app_pages.dart';
import 'package:zesdro/utils/constants.dart';
import 'package:zesdro/utils/object_box_global.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../components/custom_alert_button.dart';

class ProfileController extends GetxController {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> handleSignOut() async {
    await ObjectBoxSingleton.instance.googleSignIn.signOut();
    GetStorage().write(Constants.user, null);
    Get.offNamed(Routes.LOGIN);
  }

  deleteImage(int id) {
    Get.defaultDialog(
      title: "Delete",
      middleText: "Are you sure want to delete the post?",
      radius: 10,
      onConfirm: () {
        ObjectBoxSingleton.instance.objectBox.removeImage(id);
        Get.back();
      },
      textConfirm: "Delete",
      confirmTextColor: Colors.black,
      onCancel: () => Get.closeAllSnackbars(),
    );
  }

  void editImage(ImageFiles file) async {
    final editedImage = await Get.to(
      () => ImageEditor(image: file.fileData),
    );

    if (editedImage != null) {
      final convertedImage = await ImageUtils.convert(
        editedImage,
        format: 'jpg',
        quality: 80,
      );
      file.fileData = convertedImage;
      ObjectBoxSingleton.instance.objectBox.updateImage(file);
    }
  }
}
