import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/widgets/app_bottom/app_bottom_widget.dart';
import 'package:new_started/gen/assets.gen.dart';

class EmptyState extends StatelessWidget {
  const EmptyState(
      {Key? key,
      required this.content,
      required this.btnText,
      required this.onBtnTap})
      : super(key: key);
  final String content;
  final String btnText;
  final Function() onBtnTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.icon.emptyStateImage, width: size.width / 1.5),
        SizedBox(height: size.height * 0.04),
        Text(content.tr,
            style: AppTextStyle.aboutTeamNameStyle.apply(fontSizeFactor: 0.6)),
        SizedBox(height: size.height * 0.04),
        // اضافه کردن لینک جدید
        LinkeryBottom(
            text: btnText,
            width: size.width / 2,
            borderRadius: 24,
            onPress: onBtnTap)
      ],
    );
  }
}
