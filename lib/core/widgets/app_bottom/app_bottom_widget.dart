import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/theme_controller/theme_controller.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';

class LinkeryBottom extends StatelessWidget {
  const LinkeryBottom(
      {super.key,
      this.width = double.infinity,
      this.height = 62,
      required this.text,
      required this.onPress,
      this.borderRadius = 32});

  final double width;
  final double height;
  final String text;
  final Function() onPress;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() {
      return ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(Size(width, height)),
            backgroundColor:
                MaterialStatePropertyAll(themeController.primaryColor.value),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius))),
            elevation: const MaterialStatePropertyAll(0)),
        child: Text(
          text.tr,
          style: AppTextStyle.linkeryBottomTextStyle,
        ),
      );
    });
  }
}
