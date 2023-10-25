import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';

class ColorPickerBottom extends StatelessWidget {
  const ColorPickerBottom({
    super.key,
    required this.onTap,
  });
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.30,
        height: size.height * 0.07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: SolidColors.grayColor, width: 1)),
        child: Center(
            child: Text(
          AppTextConstants.colorTxt.tr,
          style: AppTextStyle.colorPickerStyle,
        )),
      ),
    );
  }
}
