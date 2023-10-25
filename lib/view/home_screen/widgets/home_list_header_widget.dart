import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/theme_controller/theme_controller.dart';
import 'package:new_started/controller/translate/translate_controler.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/eums/app_direction.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';

class HomeListHeader extends StatelessWidget {
  const HomeListHeader(
      {super.key, required this.title, required this.viewAllOnTap});

  final String title;
  final Function() viewAllOnTap;

  @override
  Widget build(BuildContext context) {
    final TranslateController translateController =
        Get.find<TranslateController>();
    final ThemeController themeController = Get.find<ThemeController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //title txt
        Obx(() => Text(
              title.tr,
              style: AppTextStyle.homeTextTitle
                  .apply(color: themeController.primaryColor.value),
            )),
        GestureDetector(
          onTap: viewAllOnTap,
          child: Row(
            children: [
              if (translateController.directionality.value == AppDirection.rtl)
                SvgPicture.asset(
                  './assets/icon/arrow.svg',
                  height: 20,
                  // ignore: deprecated_member_use
                  color: SolidColors.darkGray,
                ),
              const SizedBox(width: Dimens.small),
              Text(AppTextConstants.viewAll.tr,
                  style: AppTextStyle.homeTextViewAll),
              // در صورتی که زبان برنامه انگلیسی یا چینی باشه
              if (translateController.directionality.value == AppDirection.ltr)
                SvgPicture.asset(
                  './assets/icon/arrow.svg',
                  height: 20,
                  // ignore: deprecated_member_use
                  color: SolidColors.darkGray,
                )
            ],
          ),
        ),
      ],
    );
  }
}
