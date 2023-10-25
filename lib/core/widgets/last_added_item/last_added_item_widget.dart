import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/theme_controller/theme_controller.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/model/link_model/link_model.dart';

class LastAddedItem extends StatelessWidget {
  const LastAddedItem(
      {super.key,
      required this.linkModel,
      required this.size,
      this.shadowColor = SolidColors.blackColor,
      this.borderRadius = 12,
      this.blurRadius = 5,
      this.shadowOpacity = 0.4,
      this.shadowXOffset = 0,
      this.shadowYOffset = 5,
      this.horizontalMargin = Dimens.medium,
      this.verticalMargin = 0,
      this.contentPadding = 12,
      this.width = double.infinity,
      this.height = 120,
      required this.onTap,
      required this.onMoreVertTap});

  final Size size;
  final LinkModel linkModel;
  final Color shadowColor;
  final double blurRadius;
  final double shadowXOffset;
  final double shadowYOffset;
  final double shadowOpacity;
  final double borderRadius;
  final double horizontalMargin;
  final double verticalMargin;
  final double contentPadding;
  final double width;
  final double height;
  final Function() onTap;
  final Function() onMoreVertTap;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return GestureDetector(
        onTap: onTap,
        child: Obx(
          () {
            return Container(
              width: width,
              height: height,
              padding: EdgeInsets.all(contentPadding),
              margin: EdgeInsets.symmetric(
                  horizontal: horizontalMargin, vertical: verticalMargin),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Get.isDarkMode
                          ? SolidColors.darkModeItemColor
                          : SolidColors.scaffoldColor,
                      themeController.primaryColor.value
                    ],
                    stops: const [0.4, 0.99],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
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
                          child: Text(linkModel.name,
                              maxLines: 2,
                              style: AppTextStyle.lastArticleTitleTextStyle)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: Dimens.large),
                        child: GestureDetector(
                          onTap: onMoreVertTap,
                          child: const Icon(
                            Icons.more_vert,
                            size: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  // domain and type text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(linkModel.domain,
                          style: AppTextStyle.lastArticleTitleTextStyle
                              .copyWith(color: SolidColors.textGray)),
                      Text(linkModel.category!.name,
                          style: AppTextStyle.subTitleTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: themeController.primaryColor.value)),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
