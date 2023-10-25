import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';
import 'package:new_started/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width / 2,
                child: Image.asset(
                  Assets.images.beelinkicon.path,
                  scale: 3,
                ),
              ),
              Text(AppTextConstants.createdBy.tr,
                  style: AppTextStyle.aboutTitleStyle),
              Text(AppTextConstants.lunyxAgency.tr,
                  style: AppTextStyle.aboutTeamNameStyle),
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
                width: size.width / 1.3,
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
                          Assets
                              .icon.instagram, // ignore: deprecated_member_use
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
                          Assets.icon.linkedin, // ignore: deprecated_member_use
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
                          Assets.icon.twitter, // ignore: deprecated_member_use
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
                          Assets.icon.github, // ignore: deprecated_member_use
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

                        myLaunchUrl("https://amirrezahaqi.ir");
                      },
                      icon: SvgPicture.asset(
                        Assets.icon.smile,
                        // ignore: deprecated_member_use
                        color: SolidColors.darkGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
