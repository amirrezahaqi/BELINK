import 'package:flutter/material.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';

class TagItem extends StatelessWidget {
  const TagItem(
      {super.key,
      required this.text,
      this.width = 100,
      this.height = 30,
      this.textColor = SolidColors.blackColor,
      required this.onTap});

  final String text;
  final double width;
  final double height;
  final Color textColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: SolidColors.grayColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
            child: Text(text,
                style: AppTextStyle.tagTextStyle.apply(color: textColor))),
      ),
    );
  }
}
