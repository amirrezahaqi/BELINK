import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';

class MainAppItem extends StatelessWidget {
  const MainAppItem(
      {super.key,
      this.width = 80,
      this.height = 80,
      required this.iconPath,
      this.iconColor = SolidColors.colorPrimary,
      this.shadowColor = SolidColors.blackColor,
      this.blurRadius = 10,
      this.shadowXOffset = 0,
      this.shadowYOffset = 5,
      this.shadowOpacity = 0.4,
      this.borderRadius = 12,
      this.iconHeight = 48,
      required this.text,
      required this.textStyle,
      required this.onTap});

  final double width;
  final double height;

  final String iconPath;
  final Color iconColor;
  final String text;
  final TextStyle textStyle;
  final Color shadowColor;
  final double blurRadius;
  final double shadowXOffset;
  final double shadowYOffset;
  final double shadowOpacity;
  final double borderRadius;
  final double iconHeight;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? SolidColors.darkModeItemColor
              : SolidColors.scaffoldColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: [
            BoxShadow(
                color: shadowColor.withOpacity(shadowOpacity),
                blurRadius: blurRadius,
                offset: Offset(shadowXOffset, shadowYOffset))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath,
                height: iconHeight,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
            const SizedBox(
              height: Dimens.small - 4,
            ),
            Text(text.tr, style: textStyle)
          ],
        ),
      ),
    );
  }
}

// نمونه ویحت دسته بندی ها
// MainAppItem(
// width: size.width / 4,
// height: size.height / 8,
// blurRadius: 5,
// iconPath: Assets.icon.coffee,
// text: 'COFFEE',
// textStyle: AppTextStyle.subTitleTextStyle
//     .copyWith(fontWeight: FontWeight.w400, fontSize: 18),
// onTap: () {},
// )

// نمونه ویجت ایتم های اصلی
// MainAppItem(
// width: size.width / 2.4,
// height: size.height / 5,
// borderRadius: 24,
// blurRadius: 5,
// iconHeight: 96,
// iconColor: Colors.grey,
// iconPath: Assets.icon.privateLink,
// text: 'COFFEE',
// textStyle: AppTextStyle.subTitleTextStyle.copyWith(fontWeight: FontWeight.w400,fontSize: 18),
// onTap: () {
//
// },
// )