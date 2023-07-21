import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zesdro/app/data/models/image_model.dart';
import 'package:zesdro/config/theme/light_theme_colors.dart';
import 'package:zesdro/utils/object_box_global.dart';

import '../controllers/profile_controller.dart';

// ignore: must_be_immutable
class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  double tileSize = Get.width - 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: logoutButton(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  backButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  profileImage(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    ObjectBoxSingleton.instance.user!.displayName,
                    style: Get.theme.textTheme.headlineSmall?.copyWith(
                        color: LightThemeColors.headlinesTextColor
                            .withOpacity(0.7)),
                  ),
                  Text(
                    ObjectBoxSingleton.instance.user!.email,
                    style: Get.theme.textTheme.bodySmall?.copyWith(
                        color: LightThemeColors.headlinesTextColor
                            .withOpacity(0.7)),
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
                              children.add(InkWell(
                                onTap: () {
                                  Get.to(
                                    () => PhotoView(
                                        imageProvider: MemoryImage(
                                      snapshot.data![index + i].fileData,
                                    )),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: tileSize / 3,
                                    height: tileSize / 3,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: LightThemeColors.primaryColor,
                                        image: DecorationImage(
                                            image: MemoryImage(snapshot
                                                .data![index + i].fileData),
                                            fit: BoxFit.cover),
                                        border: Border.all(
                                            color:
                                                LightThemeColors.accentColor)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              controller.deleteImage(
                                                  snapshot.data![index + i].id);
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: LightThemeColors
                                                        .primaryColor),
                                                child: const Icon(
                                                  Icons.delete_outline_rounded,
                                                  size: 17,
                                                  color: LightThemeColors
                                                      .iconColor,
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
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: LightThemeColors
                                                        .primaryColor),
                                                child: const Icon(
                                                  Icons.edit_outlined,
                                                  size: 17,
                                                  color: LightThemeColors
                                                      .iconColor,
                                                )))
                                      ],
                                    ),
                                  ),
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

  logoutButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: controller.handleSignOut,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            //width: Get.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: LightThemeColors.primaryColor,
            ),
            child: const Row(children: [
              Text(
                "Logout",
                style: TextStyle(
                  color: LightThemeColors.accentColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.logout_rounded,
                color: LightThemeColors.accentColor,
              )
            ]),
          ),
        ),
      ],
    );
  }

  backButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_rounded)),
          const Spacer(),
          Text(
            "Profile",
            style: Get.theme.textTheme.headlineSmall?.copyWith(
                color: LightThemeColors.headlinesTextColor.withOpacity(0.7)),
          ),
          const Spacer(),
          const SizedBox(
            width: 46,
          )
        ],
      ),
    );
  }

  profileImage() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: LightThemeColors.primaryColor),
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 150,
        height: 150,
        padding: (ObjectBoxSingleton.instance.user!.photoURL != "")
            ? const EdgeInsets.all(5)
            : const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: (ObjectBoxSingleton.instance.user!.photoURL != "")
                ? DecorationImage(
                    fit: BoxFit.cover,
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
    );
  }
}
