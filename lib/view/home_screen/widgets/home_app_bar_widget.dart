import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/gen/assets.gen.dart';

AppBar homeAppBar({required Size size, required Function() bellTap}) {
  return AppBar(
    backgroundColor: Get.isDarkMode
        ? SolidColors.darkModeItemColor
        : SolidColors.scaffoldColor,
    automaticallyImplyLeading: false,
    elevation: 0,
    title: Center(child: Assets.images.beelink.image(width: 200)),
  );
}
