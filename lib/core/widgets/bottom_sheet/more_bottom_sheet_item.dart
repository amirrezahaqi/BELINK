import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';

class MoreBottomSheetItem extends StatelessWidget {
  const MoreBottomSheetItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });
  final String title;
  final String iconPath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.medium),
        child: Row(
          children: [
            // ignore: deprecated_member_use
            SvgPicture.asset(iconPath, color: themeData.iconTheme.color),
            const SizedBox(
              width: 20,
            ),
            Text(title.tr)
          ],
        ),
      ),
    );
  }
}
