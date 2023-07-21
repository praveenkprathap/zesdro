import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/utils.dart';
import 'package:zesdro/app/data/models/image_model.dart';
import 'package:zesdro/utils/object_box_global.dart';

class ProfileController extends GetxController {
  void deleteImage(int id) {
    ObjectBoxSingleton.instance.objectBox.removeImage(id);
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
