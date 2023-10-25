import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';
import 'package:new_started/gen/assets.gen.dart';

import '../tag_widget/article_tag_widget.dart';

class MoreArticleWidget extends StatelessWidget {
  const MoreArticleWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: size.width * 0.8,
      height: size.height * 0.02,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Get.isDarkMode
            ? SolidColors.darkModeItemColor
            : SolidColors.scaffoldColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimens.small),
            child: Column(
              children: [
                // post title
                SizedBox(
                    width: size.width * 0.3,
                    height: size.height * 0.07,
                    child: Text(
                      AppTextConstants.shortLorem,
                      style: AppTextStyle.articleTitleTextStyle
                          .apply(fontSizeFactor: 0.5),
                      maxLines: 2,
                    )),

                SizedBox(height: size.height * 0.01),
                // tag and star
                Row(
                  children: [
                    TagItem(
                      text: AppTextConstants.sports,
                      onTap: () {},
                    ),
                    SizedBox(width: size.width * 0.09),
                    const Icon(CupertinoIcons.star_fill,
                        color: CupertinoColors.systemYellow),
                    const Icon(Icons.more_vert, color: SolidColors.grayColor)
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: size.width * 0.31,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset(Assets.images.poster.path).image,
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12)),
          ),
        ],
      ),
    );
  }
}
