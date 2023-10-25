import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/navigation_controller/bottom_navigation_controller.dart';
import 'package:new_started/controller/theme_controller/theme_controller.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';
import 'package:new_started/core/widgets/bottom_navigation/bottom_navigation_item.dart';
import 'package:new_started/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkeryBottomNavigation extends StatelessWidget {
  const LinkeryBottomNavigation({
    super.key,
    required this.onTapChange,
  });
  final Function(int index) onTapChange;
  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller =
        Get.find<BottomNavigationController>();
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(Dimens.small),
        height: 74,
        // color: SolidColors.scaffoldColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // home
            LinkeryBottomNavItem(
              onTap: () => onTapChange(controller.homeIndex),
              imagePath: Assets.icon.home,
              isActive: controller.currentIndex.value == controller.homeIndex,
              lable: AppTextConstants.homeLable,
              activeLableColor:
                  themeController.primaryColor.value.withOpacity(0.5),
              activeColor: themeController.primaryColor.value,
            ),
            // last Read
            LinkeryBottomNavItem(
              onTap: () {
                myLaunchUrl(String url) async {
                  var uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                }

                myLaunchUrl("https://amirrezahaqi.ir");
              },
              imagePath: Assets.icon.star,
              isActive:
                  controller.currentIndex.value == controller.articleIndex,
              lable: AppTextConstants.lastReadLable,
              activeLableColor:
                  themeController.primaryColor.value.withOpacity(0.5),
              activeColor: themeController.primaryColor.value,
            ),
            // book mark
            LinkeryBottomNavItem(
              onTap: () => onTapChange(controller.bookMarkIndex),
              imagePath: Assets.icon.bookmark,
              isActive:
                  controller.currentIndex.value == controller.bookMarkIndex,
              lable: AppTextConstants.bookMarkLable,
              activeLableColor:
                  themeController.primaryColor.value.withOpacity(0.5),
              activeColor: themeController.primaryColor.value,
            ),
            // setting
            LinkeryBottomNavItem(
              onTap: () => onTapChange(controller.settingIndex),
              imagePath: Assets.icon.setting,
              isActive:
                  controller.currentIndex.value == controller.settingIndex,
              lable: AppTextConstants.settingLable,
              activeLableColor:
                  themeController.primaryColor.value.withOpacity(0.5),
              activeColor: themeController.primaryColor.value,
            ),
          ],
        ),
      );
    });
  }
}
