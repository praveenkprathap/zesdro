import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
          leading: Image.asset(Constants.logoPath),
          centerTitle: true,
          actions: [
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
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: LightThemeColors.iconColor),
                      ),
              ),
            )
          ],
          backgroundColor: LightThemeColors.accentColor),
      body: StreamBuilder<List<ImageFiles>>(
          stream: ObjectBoxSingleton.instance.objectBox.getImages(),
          builder: (context, snapshot) => ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.memory(snapshot.data![index].fileData),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.gotoCreatePost,
        backgroundColor: LightThemeColors.primaryColor,
        child: const Icon(
          Icons.add,
          size: 50,
          color: LightThemeColors.accentColor,
        ),
      ),
    );
  }
}
