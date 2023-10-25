import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/password_controller/pass_controller.dart';
import 'package:new_started/controller/theme_controller/theme_controller.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/widgets/app_bottom/app_bottom_widget.dart';
import 'package:new_started/core/widgets/app_text_field/app_text_field.dart';
import 'package:new_started/core/widgets/bottom_sheet/set_new_password_bottom_sheet.dart';

class PrivateLoginScreen extends StatelessWidget {
  const PrivateLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final PassController passController = Get.find<PassController>();
    final ThemeController themeController = Get.find<ThemeController>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Dimens.medium),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // وارد کردن پسورد
              Obx(
                () => LinkeryTextField(
                  controller: passController.inputPasswordController,
                  width: size.width * 0.7,
                  hintText: AppTextConstants.password,
                  obscure: passController.inputPasswordObscure.value,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        passController.inputPasswordObscure.value =
                            !passController.inputPasswordObscure.value;
                      },
                      child: Icon(passController.inputPasswordObscure.value
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined)),
                ),
              ),
              const SizedBox(height: Dimens.large),
              // در صورتی که کاربر پسورد داشته باشه
              if (passController.setPassWord.value) ...[
                LinkeryBottom(
                  width: size.width * 0.7,
                  height: size.height * 0.05,
                  text: AppTextConstants.loginWithPasswordTxt.tr,
                  onPress: passController.checkPassword,
                ),
              ]
              // در صورتی که کاربر پسوردی ست نکرده باشه
              else ...[
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppTextConstants.youNotPassWordMassageTxt.tr,
                          style: AppTextStyle.normalText),
                      TextButton(
                          onPressed: () => setNewPassWordBottomSheet(
                              context, size, passController),
                          child: Text(AppTextConstants.setPasswordTxt.tr,
                              style: AppTextStyle.normalText.apply(
                                  color: themeController.primaryColor.value))),
                    ],
                  ),
                )
              ],

              // const SizedBox(height: Dimens.medium),
              // buildAuthenticate(context),
              // SizedBox(
              //   height: size.height * 0.02,
              // ),
              // Text(
              //   AppTextConstants.fingerPrint.tr,
              //   style: AppTextStyle.subTitleTextStyle
              //       .apply(fontSizeFactor: 2, color: SolidColors.grayIconColor),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
