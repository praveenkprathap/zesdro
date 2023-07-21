import 'package:get/get.dart';
import 'package:image_editor_plus/utils.dart';
import 'package:zesdro/app/data/models/image_model.dart';
import 'package:zesdro/app/routes/app_pages.dart';
import 'package:zesdro/utils/object_box_global.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

class HomeController extends GetxController {
  var images = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

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
}
