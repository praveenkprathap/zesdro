import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zesdro/app/components/custom_snackbar.dart';
import 'package:zesdro/app/data/models/user_model.dart';
import 'package:zesdro/app/data/models/user_model_db.dart';
import 'package:zesdro/app/routes/app_pages.dart';
import 'package:zesdro/utils/constants.dart';
import 'package:zesdro/utils/object_box_global.dart';

class LoginController extends GetxController {
  UserModel? user;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> signInHandler() async {
    try {
      GoogleSignInAccount? data = await googleSignIn.signIn();
      if (data != null) {
        int id =
            ObjectBoxSingleton.instance.objectBox.checkUserExist(data.email);
        if (id == 0) {
          id = await ObjectBoxSingleton.instance.objectBox.addUser(UserDetails(
            displayName: data.displayName ?? "",
            email: data.email,
            uid: data.id,
            photoURL: data.photoUrl ?? "",
          ));
        }

        user = UserModel(data.displayName ?? "", data.email, data.id,
            data.photoUrl ?? "", id);
        GetStorage().write(Constants.user, user!.toMap());
        ObjectBoxSingleton.instance.user = user;

        Get.offNamed(Routes.HOME);
      } else {}
    } catch (error) {
      print(error);
      CustomSnackBar.showCustomErrorToast(message: "Something went wrong");
    }
  }
}
