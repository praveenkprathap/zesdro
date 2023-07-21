import 'package:objectbox/objectbox.dart';

@Entity()
class UserDetails {
  @Id()
  int id;
  String displayName;
  String email;
  String uid;
  String photoURL;

  UserDetails(
      {this.id = 0,
      this.displayName = "",
      this.email = "",
      this.uid = "",
      this.photoURL = ""});
}
