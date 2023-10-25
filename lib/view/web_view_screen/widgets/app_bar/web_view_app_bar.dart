import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/model/link_model/link_model.dart';

class WebViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WebViewAppBar({super.key, required this.size, required this.link});

  final Size size;
  final LinkModel link;
  @override
  Widget build(BuildContext context) {
    final HiveLinkController linkController = Get.find<HiveLinkController>();
    final ThemeData themeData = Theme.of(context);
    return AppBar(
      backgroundColor: themeData.appBarTheme.backgroundColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(link.name,
              style: AppTextStyle.articleTitleTextStyle
                  .apply(fontSizeFactor: 0.7)),
          const Expanded(child: SizedBox()),
          GestureDetector(
              onTap: () {
                link.isBookMark = !link.isBookMark;
                link.save();
              },
              child: Icon(
                  link.isBookMark
                      ? CupertinoIcons.bookmark_fill
                      : CupertinoIcons.bookmark,
                  size: 28,
                  color: SolidColors.grayIconColor)),
          SizedBox(width: size.width * 0.02),
          // share icon
          GestureDetector(
              onTap: () => linkController.shareLink(link),
              child: const Icon(Icons.share,
                  size: 28, color: SolidColors.grayIconColor)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size.height * 0.05);
}
