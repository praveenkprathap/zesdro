// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'app/data/models/image_model.dart';
import 'app/data/models/user_model_db.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 8560750273441928452),
      name: 'UserDetails',
      lastPropertyId: const IdUid(5, 8791224676756377519),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7284083419154488022),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2246604263958350571),
            name: 'displayName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7115405455587878999),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6054725212465726318),
            name: 'uid',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8791224676756377519),
            name: 'photoURL',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 5791984589763745272),
      name: 'ImageFiles',
      lastPropertyId: const IdUid(3, 352612827775118481),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4920327333912246221),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 9178900746408393976),
            name: 'fileData',
            type: 23,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 352612827775118481),
            name: 'uid',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 5791984589763745272),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    UserDetails: EntityDefinition<UserDetails>(
        model: _entities[0],
        toOneRelations: (UserDetails object) => [],
        toManyRelations: (UserDetails object) => {},
        getId: (UserDetails object) => object.id,
        setId: (UserDetails object, int id) {
          object.id = id;
        },
        objectToFB: (UserDetails object, fb.Builder fbb) {
          final displayNameOffset = fbb.writeString(object.displayName);
          final emailOffset = fbb.writeString(object.email);
          final uidOffset = fbb.writeString(object.uid);
          final photoURLOffset = fbb.writeString(object.photoURL);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, displayNameOffset);
          fbb.addOffset(2, emailOffset);
          fbb.addOffset(3, uidOffset);
          fbb.addOffset(4, photoURLOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = UserDetails(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              displayName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              uid: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              photoURL: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, ''));

          return object;
        }),
    ImageFiles: EntityDefinition<ImageFiles>(
        model: _entities[1],
        toOneRelations: (ImageFiles object) => [],
        toManyRelations: (ImageFiles object) => {},
        getId: (ImageFiles object) => object.id,
        setId: (ImageFiles object, int id) {
          object.id = id;
        },
        objectToFB: (ImageFiles object, fb.Builder fbb) {
          final fileDataOffset = fbb.writeListInt8(object.fileData);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, fileDataOffset);
          fbb.addInt64(2, object.uid);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ImageFiles(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              uid: const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
              fileData: const fb.Uint8ListReader(lazy: false)
                  .vTableGet(buffer, rootOffset, 6, Uint8List(0)) as Uint8List);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [UserDetails] entity fields to define ObjectBox queries.
class UserDetails_ {
  /// see [UserDetails.id]
  static final id =
      QueryIntegerProperty<UserDetails>(_entities[0].properties[0]);

  /// see [UserDetails.displayName]
  static final displayName =
      QueryStringProperty<UserDetails>(_entities[0].properties[1]);

  /// see [UserDetails.email]
  static final email =
      QueryStringProperty<UserDetails>(_entities[0].properties[2]);

  /// see [UserDetails.uid]
  static final uid =
      QueryStringProperty<UserDetails>(_entities[0].properties[3]);

  /// see [UserDetails.photoURL]
  static final photoURL =
      QueryStringProperty<UserDetails>(_entities[0].properties[4]);
}

/// [ImageFiles] entity fields to define ObjectBox queries.
class ImageFiles_ {
  /// see [ImageFiles.id]
  static final id =
      QueryIntegerProperty<ImageFiles>(_entities[1].properties[0]);

  /// see [ImageFiles.fileData]
  static final fileData =
      QueryByteVectorProperty<ImageFiles>(_entities[1].properties[1]);

  /// see [ImageFiles.uid]
  static final uid =
      QueryIntegerProperty<ImageFiles>(_entities[1].properties[2]);
}
