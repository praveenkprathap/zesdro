import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zesdro/app/components/custom_snackbar.dart';
import 'package:zesdro/app/data/models/image_model.dart';
import 'package:zesdro/app/routes/app_pages.dart';
import 'package:zesdro/utils/object_box_global.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

class HomeController extends GetxController {
  void navigateToProfilePage() {
    Get.toNamed(Routes.PROFILE);
  }

  void gotoCreatePost() async {
    final editedImage = await Get.to(
      () => const ImageEditor(),
    );

    if (editedImage != null) {
      // can post
      final convertedImage = await ImageUtils.convert(
        editedImage, // <-- Uint8List/path of image
        format: 'jpg',
        quality: 80,
      );
      ObjectBoxSingleton.instance.objectBox.addImage(ImageFiles(
          fileData: convertedImage,
          uid: ObjectBoxSingleton.instance.user!.uid));
    }
  }

  void sharePost(Uint8List image) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.jpg').writeAsBytes(image);

    await Share.shareFiles([file.path]);
  }

  void downloadPost(Uint8List image) async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = '$timeStamp.png';
    await Permission.storage.request();
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      CustomSnackBar.showCustomToast(title: "Download Started", message: " ");
      final downloadsDir = await getExternalStorageDirectory();
      if (!await downloadsDir!.exists()) {
        await downloadsDir.create();
      }
      print("---------------------------------------------------");
      print('${downloadsDir.path}/$fileName');
      final file = File('${downloadsDir.path}/$fileName');
      try {
        await file.writeAsBytes(image);
      } catch (e) {
        print('Error writing file: $e');
      }
      CustomSnackBar.showCustomToast(
          title: 'Image downloaded to: ${file.path}', message: " ");
    } else {
      CustomSnackBar.showCustomToast(
          title: "Permission Denied", message: " ", color: Colors.red);
    }
  }
}
