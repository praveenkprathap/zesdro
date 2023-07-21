import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';

@Entity()
class ImageFiles {
  @Id()
  int id;
  Uint8List fileData;
  int uid;

  ImageFiles({this.id = 0, required this.uid, required this.fileData});
}
