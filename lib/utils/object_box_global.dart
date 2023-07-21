import 'package:google_sign_in/google_sign_in.dart';
import 'package:zesdro/app/data/models/user_model.dart';
import 'package:zesdro/utils/db_handler.dart';

class ObjectBoxSingleton {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  UserModel? user;
  late ObjectBox objectBox;
  ObjectBoxSingleton._();
  static final instance = ObjectBoxSingleton._();
}
