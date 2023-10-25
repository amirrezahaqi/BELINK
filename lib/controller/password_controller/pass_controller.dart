import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/app_keys/prefs_keys.dart';
import 'package:new_started/core/constants/eums/link_page_state.dart';
import 'package:new_started/core/widgets/snackbar_widget/custom_snackbar_widget.dart';
import 'package:new_started/view/link_screen/screens/all_link_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/colors/solid_colors.dart';

class PassController extends GetxController {
  final TextEditingController inputPasswordController = TextEditingController();
  final TextEditingController setNewPasswordController =
      TextEditingController();
  RxBool setPassWordObscureTxt = true.obs;
  RxBool setPassWord = false.obs;
  RxBool inputPasswordObscure = true.obs;

  void savePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // فیلد پسورد خالی نباشه
    if (setNewPasswordController.text != '') {
      final String password = setNewPasswordController.text;
      await prefs.setString(PrefsKey.savePasswordKey, password);
      setPassWord.value = true; // عوض کردن حالت صفحه و نمایش دکمه
      log(prefs.getString(PrefsKey.savePasswordKey).toString());
      Get.back();
    }
    // اگر فیلد پسورد خالی باشه
    else {
      customSnackbar(
          title: AppTextConstants.error,
          massage: AppTextConstants.enterPasswordErrorTxt,
          backgroundColor: SolidColors.redColor,
          textColor: SolidColors.scaffoldColor);
    }
  }

  void checkPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedPassword = prefs.getString(PrefsKey.savePasswordKey);
    final String currentPassword = inputPasswordController.text;
    if (savedPassword == null || savedPassword.isEmpty) {
      // رمز عبور قبلی وجود ندارد، بنابراین مقدار ورودی را ذخیره کنید
      prefs.setString(PrefsKey.savePasswordKey, currentPassword);
    } else if (savedPassword == currentPassword) {
      // رمز عبور درست است
      Get.to(AllLinkScreen(linkPageState: LinkPageState.private));
    } else {
      // رمز عبور اشتباه است
      customSnackbar(
          title: AppTextConstants.error,
          massage: AppTextConstants.completedInformationLink,
          backgroundColor: SolidColors.redColor,
          textColor: SolidColors.scaffoldColor);
    }
  }

  checkPassState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(PrefsKey.savePasswordKey) != null) {
      setPassWord.value = true;
    } else {
      setPassWord.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkPassState();
  }
}
