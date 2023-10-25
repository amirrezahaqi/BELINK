import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/theme_controller/theme_controller.dart';
import 'package:new_started/controller/translate/translate_controler.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/widgets/color_picker/color_picker_custom_dialog.dart';
import 'package:new_started/gen/assets.gen.dart';
import 'package:new_started/view/setting_screen/widget/setting_item_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeController controller = Get.find<ThemeController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Assets.images.beelink.image(width: 300),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Version 0.0", style: TextStyle(fontSize: 15)),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    AppTextConstants.thankyou.tr,
                    style: AppTextStyle.aboutTitleStyle.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width / 1.3,
                    child: Text(AppTextConstants.lunyxDescription.tr,
                        textAlign: TextAlign.justify,
                        style: AppTextStyle.aboutTitleStyle),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: size.width / 1.19,
                    child: SettingItem(
                      onTap: () {
                        final ThemeController controller =
                            Get.find<ThemeController>();
                        linkeryColorPicker(
                          context: context,
                          pickerColor: controller.primaryColor.value,
                          onChange: (newColor) {
                            // دریافت کد های رنگ جدید
                            final newRedColor = newColor.red;
                            final newGreenColor = newColor.green;
                            final newBlueColor = newColor.blue;
                            final newOpacityColor = newColor.alpha;
                            // تغییر تم برنامه
                            controller.setNewColorTheme(
                                redColor: newRedColor,
                                greenColor: newGreenColor,
                                blueColor: newBlueColor,
                                opacity: newOpacityColor);
                          },
                        );
                      },
                      title: AppTextConstants.changeTheme.tr,
                    ),
                  ),
                  SizedBox(
                    width: size.width / 1.19,
                    child: SettingItem(
                      onTap: () {
                        buildLanguageDialog(context);
                      },
                      title: AppTextConstants.changeLanguage.tr,
                    ),
                  ),
                  SizedBox(
                    width: size.width / 1.19,
                    child: SettingItem(
                      onTap: () {
                        //تغییر دارک مود و لایت مود

                        controller.changeTheme();
                      },
                      title: AppTextConstants.darkMode.tr,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(AppTextConstants.createdBy.tr,
                      style: AppTextStyle.aboutTitleStyle),
                  Text(AppTextConstants.lunyxAgency.tr,
                      style: AppTextStyle.aboutTeamNameStyle),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: size.width / 1.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              myLaunchUrl(String url) async {
                                var uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri);
                                }
                              }

                              myLaunchUrl("https://instagram.com/amirrezahaqi");
                            },
                            icon: SvgPicture.asset(
                              Assets.icon
                                  .instagram, // ignore: deprecated_member_use
                              color: SolidColors.darkGray,
                            )),
                        IconButton(
                            onPressed: () {
                              myLaunchUrl(String url) async {
                                var uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri);
                                }
                              }

                              myLaunchUrl(
                                  "https://www.linkedin.com/in/amirreza-haqi/");
                            },
                            icon: SvgPicture.asset(
                              Assets.icon
                                  .linkedin, // ignore: deprecated_member_use
                              color: SolidColors.darkGray,
                            )),
                        IconButton(
                            onPressed: () {
                              myLaunchUrl(String url) async {
                                var uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri);
                                }
                              }

                              myLaunchUrl("https://twitter.com/amirrezahaqi");
                            },
                            icon: SvgPicture.asset(
                              Assets.icon
                                  .twitter, // ignore: deprecated_member_use
                              color: SolidColors.darkGray,
                            )),
                        IconButton(
                            onPressed: () {
                              myLaunchUrl(String url) async {
                                var uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri);
                                }
                              }

                              myLaunchUrl("https://github.com/amirrezahaqi");
                            },
                            icon: SvgPicture.asset(
                              Assets
                                  .icon.github, // ignore: deprecated_member_use
                              color: SolidColors.darkGray,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//دیالوگ مربوط تغییر زبان برنامه

buildLanguageDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (builder) {
        final TranslateController translateController =
            Get.find<TranslateController>();
        return AlertDialog(
          title: Text(AppTextConstants.changeLanguage.tr),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.small),
                    child: Text(AppTextConstants.en.tr),
                  ),
                  onTap: () {
                    translateController.changeLanguage("en");
                    Get.back();
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.small),
                    child: Text(AppTextConstants.fa.tr),
                  ),
                  onTap: () {
                    translateController.changeLanguage("fa");
                    Get.back();
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.small),
                    child: Text(AppTextConstants.ar.tr),
                  ),
                  onTap: () {
                    translateController.changeLanguage("ar");
                    Get.back();
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.small),
                    child: Text(AppTextConstants.ch.tr),
                  ),
                  onTap: () {
                    translateController.changeLanguage("ch");
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      });
}
