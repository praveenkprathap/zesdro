import 'package:zesdro/app/data/models/user_model.dart';
import 'package:zesdro/utils/db_handler.dart';

class ObjectBoxSingleton {
  UserModel? user;
  late ObjectBox objectBox;

  ObjectBoxSingleton._();
  static final instance = ObjectBoxSingleton._();
}
