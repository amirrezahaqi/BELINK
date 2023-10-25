import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/password_controller/pass_controller.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/widgets/app_bottom/app_bottom_widget.dart';
import 'package:new_started/core/widgets/app_text_field/app_text_field.dart';

Future<dynamic> setNewPassWordBottomSheet(
    BuildContext context, Size size, PassController passController) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.medium),
            topRight: Radius.circular(Dimens.medium))),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.fromLTRB(Dimens.medium, Dimens.medium,
            Dimens.medium, MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          width: size.width,
          height: size.height * 0.3,
          child: Column(
            children: [
              Text(AppTextConstants.pleaseEnterYourPasswordTxt.tr,
                  style: AppTextStyle.normalText),
              SizedBox(height: size.height * 0.04),
              // فیلد وارد کردن پسورد جدید
              Obx(
                () => LinkeryTextField(
                  controller: passController.setNewPasswordController,
                  width: size.width * 0.7,
                  obscure: passController.setPassWordObscureTxt.value,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        passController.setPassWordObscureTxt.value =
                            !passController.setPassWordObscureTxt.value;
                      },
                      child: Icon(passController.setPassWordObscureTxt.value
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined)),
                  hintText: AppTextConstants.password,
                  inputType: TextInputType.visiblePassword,
                ),
              ),
              SizedBox(height: size.height * 0.06),
              // دکمه ذخیره پسورد
              LinkeryBottom(
                width: size.width,
                height: size.height * 0.06,
                text: AppTextConstants.save.tr,
                onPress: passController.savePassword,
              ),
            ],
          ),
        ),
      );
    },
  );
}
