import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zesdro/app/data/models/image_model.dart';
import 'package:zesdro/config/theme/light_theme_colors.dart';
import 'package:zesdro/utils/object_box_global.dart';

import '../controllers/profile_controller.dart';

// ignore: must_be_immutable
class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  double continerSize = Get.width - 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                    width: Get.width,
                  ),
                  Container(
                    padding: (ObjectBoxSingleton.instance.user!.photoURL != "")
                        ? const EdgeInsets.all(80)
                        : const EdgeInsets.all(60),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: LightThemeColors.primaryColor,
                        image: (ObjectBoxSingleton.instance.user!.photoURL !=
                                "")
                            ? DecorationImage(
                                image: NetworkImage(
                                    ObjectBoxSingleton.instance.user!.photoURL))
                            : null),
                    child: (ObjectBoxSingleton.instance.user!.photoURL != "")
                        ? Container()
                        : Text(
                            ObjectBoxSingleton.instance.user!.displayName[0],
                            style: const TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                color: LightThemeColors.iconColor),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    ObjectBoxSingleton.instance.user!.displayName,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: LightThemeColors.iconColor),
                  ),
                  Text(
                    ObjectBoxSingleton.instance.user!.email,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: LightThemeColors.iconColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<List<ImageFiles>>(
                      stream: ObjectBoxSingleton.instance.objectBox.getImages(),
                      builder: (context, snapshot) {
                        return Column(
                            children: List.generate(
                                (snapshot.data!.length / 3).ceil(), (index) {
                          List<Widget> children = [];

                          for (int i = 0; i < 3; i++) {
                            if (snapshot.data!.length > index + i) {
                              children.add(Container(
                                width: continerSize / 3,
                                height: continerSize / 3,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: LightThemeColors.primaryColor,
                                    image: DecorationImage(
                                        image: MemoryImage(
                                            snapshot.data![index + i].fileData),
                                        fit: BoxFit.cover),
                                    border: Border.all(
                                        color: LightThemeColors.accentColor)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          controller.deleteImage(
                                              snapshot.data![index + i].id);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: LightThemeColors
                                                    .primaryColor),
                                            child: const Icon(
                                              Icons.delete,
                                              color: LightThemeColors.iconColor,
                                            ))),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          controller.editImage(
                                              snapshot.data![index + i]);
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: LightThemeColors
                                                    .primaryColor),
                                            child: const Icon(
                                              Icons.edit,
                                              color: LightThemeColors.iconColor,
                                            )))
                                  ],
                                ),
                              ));
                            }
                          }

                          return Row(
                            children: children,
                          );
                        }));
                      }),
                ]),
          ),
        ),
      ),
    );
  }
}
