import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zesdro/app/data/models/image_model.dart';
import 'package:zesdro/config/theme/light_theme_colors.dart';
import 'package:zesdro/utils/constants.dart';
import 'package:zesdro/utils/object_box_global.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightThemeColors.scaffoldBackgroundColor,
        appBar: PreferredSize(
            child: appBar(), preferredSize: const Size.fromHeight(65)),
        body: StreamBuilder<List<ImageFiles>>(
            stream: ObjectBoxSingleton.instance.objectBox.getImages(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                    itemBuilder: (context, index) {
                      return imageWidget(context, index, snapshot);
                    });
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/lottie/empty.json'),
                    Text(
                      "No posts available!\ncreate one now!",
                      style: Get.theme.textTheme.titleSmall?.copyWith(
                          color: LightThemeColors.headlinesTextColor
                              .withOpacity(0.7)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ));
              }
            }),
        floatingActionButton: createPostButton());
  }

  imageWidget(context, index, snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
            onTap: () {
              Get.to(
                () => PhotoView(
                    imageProvider: MemoryImage(snapshot.data![index].fileData)),
              );
            },
            child: Stack(
              children: [
                Image.memory(snapshot.data![index].fileData),
                Positioned(
                    right: 5,
                    bottom: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: LightThemeColors.buttonTextColor
                              .withOpacity(0.6)),
                      child: Text(
                        "Post ${index + 1}",
                        style: Get.theme.textTheme.titleSmall?.copyWith(
                            color: LightThemeColors.headlinesTextColor
                                .withOpacity(0.7)),
                      ),
                    )),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.downloadPost(
                                snapshot.data![index].fileData);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: LightThemeColors.primaryColor),
                              child: const Icon(
                                Icons.download_outlined,
                                size: 17,
                                color: LightThemeColors.iconColor,
                              ))),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.sharePost(
                                snapshot.data![index].fileData);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: LightThemeColors.primaryColor),
                              child: const Icon(
                                Icons.share_outlined,
                                size: 17,
                                color: LightThemeColors.iconColor,
                              )))
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  appBar() {
    return SafeArea(
      child: Container(
        width: Get.width,
        color: LightThemeColors.scaffoldBackgroundColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(colors: [
                LightThemeColors.primaryColor,
                Color(0xFFCBCBF6),
                LightThemeColors.primaryColor
              ])),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Image.asset(Constants.logoPath),
            Text(
              "ZESDRO",
              style: Get.theme.textTheme.headlineSmall?.copyWith(
                  color: LightThemeColors.headlinesTextColor.withOpacity(0.7)),
            ),
            GestureDetector(
              onTap: controller.navigateToProfilePage,
              child: Container(
                padding: (ObjectBoxSingleton.instance.user!.photoURL != "")
                    ? const EdgeInsets.all(25)
                    : const EdgeInsets.all(15),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LightThemeColors.primaryColor,
                    image: (ObjectBoxSingleton.instance.user!.photoURL != "")
                        ? DecorationImage(
                            image: NetworkImage(
                                ObjectBoxSingleton.instance.user!.photoURL))
                        : null),
                child: (ObjectBoxSingleton.instance.user!.photoURL != "")
                    ? Container()
                    : Text(
                        ObjectBoxSingleton.instance.user!.displayName[0],
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: LightThemeColors.iconColor.withOpacity(0.7)),
                      ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  createPostButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: controller.gotoCreatePost,
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
                "Create Post",
                style: TextStyle(
                  color: LightThemeColors.accentColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.add_box_rounded,
                color: LightThemeColors.accentColor,
              )
            ]),
          ),
        ),
      ],
    );
  }
}
