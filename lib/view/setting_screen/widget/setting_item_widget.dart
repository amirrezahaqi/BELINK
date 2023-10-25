import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/translate/translate_controler.dart';
import 'package:new_started/core/constants/eums/app_direction.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/gen/assets.gen.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.onTap,
    required this.title,
  });

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    final TranslateController translateController =
        Get.find<TranslateController>();
    return ListTile(
        onTap: onTap,
        title: Text(title, style: AppTextStyle.settingItemStyle),
        trailing: SvgPicture.asset(
            translateController.directionality.value == AppDirection.ltr
                ? Assets.icon.rightArrow
                : Assets.icon.leftArrow));
  }
}
