import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';

class LinkeryBottomNavItem extends StatelessWidget {
  const LinkeryBottomNavItem(
      {super.key,
      required this.onTap,
      required this.imagePath,
      required this.lable,
      this.lableSpace = 4,
      this.isActive = false,
      this.activeColor = SolidColors.activeBottomNavColor,
      this.deactivateColor = SolidColors.deactivateBottomNavColor,
      this.activeLableColor = SolidColors.activeLableBottomNavColor});

  final Function() onTap;
  final String imagePath;
  final String lable;
  final double lableSpace;
  final bool isActive;
  final Color activeColor;
  final Color activeLableColor;
  final Color deactivateColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(imagePath,
              colorFilter: ColorFilter.mode(
                  isActive ? activeColor : deactivateColor, BlendMode.srcIn)),
          SizedBox(height: lableSpace),
          Text(lable.tr,
              style: AppTextStyle.bottomNavLableTextStyle
                  .apply(color: isActive ? activeLableColor : deactivateColor))
        ],
      ),
    );
  }
}
