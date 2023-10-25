import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/widgets/bottom_sheet/more_bottom_sheet.dart';
import 'package:new_started/model/link_model/link_model.dart';
import 'package:new_started/view/web_view_screen/widgets/tag_widget/article_tag_widget.dart';

class LinkItem extends StatelessWidget {
  const LinkItem({
    super.key,
    required this.linkModel,
    required this.size,
    this.shadowColor = SolidColors.blackColor,
    this.borderRadius = 12,
    this.blurRadius = 5,
    this.shadowOpacity = 0.2,
    this.shadowXOffset = 0,
    this.shadowYOffset = 5,
    this.horizontalMargin = Dimens.medium,
    this.verticalMargin = 0,
    this.contentPadding = 12,
    required this.onTap,
  });

  final Size size;
  final Color shadowColor;
  final double blurRadius;
  final double shadowXOffset;
  final double shadowYOffset;
  final double shadowOpacity;
  final double borderRadius;
  final double horizontalMargin;
  final double verticalMargin;
  final double contentPadding;
  final LinkModel linkModel;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final HiveLinkController linkController = Get.find<HiveLinkController>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: size.height * 0.16,
        padding: EdgeInsets.all(contentPadding),
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        decoration: BoxDecoration(
            color: Get.isDarkMode
                ? SolidColors.darkModeItemColor
                : SolidColors.scaffoldColor,
            boxShadow: [
              BoxShadow(
                  color: shadowColor.withOpacity(shadowOpacity),
                  blurRadius: blurRadius,
                  offset: Offset(shadowXOffset, shadowYOffset))
            ],
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title and more vert
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: size.width * 0.7,
                    child: Text(
                      linkModel.name,
                      maxLines: 2,
                      style: AppTextStyle.articleTitleTextStyle
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                    )),
                // more vert icon
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.large),
                  child: GestureDetector(
                    onTap: () => moreBottomSheet(context, linkModel),
                    child: const Icon(
                      Icons.more_vert,
                      color: SolidColors.colorPrimary,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.02),
            // domain and type text
            Row(
              children: [
                //tag
                TagItem(
                    onTap: () {},
                    width: size.width * 0.16,
                    height: size.height * 0.03,
                    text: linkModel.tag.title),
                SizedBox(width: size.width * 0.06),
                // domain
                Text(linkModel.domain,
                    maxLines: 2, style: AppTextStyle.domainLinkTextStyle),

                const Expanded(child: SizedBox()),
                // book mark icon
                GestureDetector(
                    onTap: () {
                      linkModel.isBookMark = !linkModel.isBookMark;
                      linkModel.save();
                    },
                    child: Icon(
                        linkModel.isBookMark
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        size: Dimens.large - 4,
                        color: SolidColors.grayIconColor)),
                SizedBox(width: size.width * 0.02),
                // share icon
                GestureDetector(
                    onTap: () => linkController.shareLink(linkModel),
                    child: const Icon(Icons.share,
                        size: Dimens.large - 4,
                        color: SolidColors.grayIconColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
