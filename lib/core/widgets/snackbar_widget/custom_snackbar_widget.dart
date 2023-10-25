import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';

SnackbarController customSnackbar({
  required String title,
  required String massage,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
  Color backgroundColor = SolidColors.colorPrimary,
  Color textColor = SolidColors.blackColor,
  double borderRadius = 12.0,
  double margin = Dimens.medium,
  int durationSeconds = 2,
}) {
  return Get.snackbar(
      // دوتای اول باگ خود گت ایکسن اگر وارد نشن ارور میدن
      "title",
      "massage",
      // تو خروجی این دوتا نمایش داده میشن
      titleText: Text(title.tr,
          style: AppTextStyle.snackBarTitle.apply(color: textColor)),
      messageText: Text(massage.tr,
          style: AppTextStyle.snackBarMassage.apply(color: textColor)),
      duration: Duration(seconds: durationSeconds),
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      margin: EdgeInsets.all(margin));
}
