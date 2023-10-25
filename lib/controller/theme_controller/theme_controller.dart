import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/app_keys/prefs_keys.dart';
import 'package:new_started/core/constants/colors/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  Rx<Color> primaryColor = const Color.fromARGB(255, 134, 146, 255).obs;

  // تغییر تیم به صورت لحظه ای و ذخیره کد های رنگ جدید
  void setNewColorTheme(
      {required int redColor,
      required int greenColor,
      required int blueColor,
      required int opacity}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(PrefsKey.redColorKey, redColor);
    await prefs.setInt(PrefsKey.greenColorKey, greenColor);
    await prefs.setInt(PrefsKey.blueColorKey, blueColor);
    await prefs.setInt(PrefsKey.opacityColorKey, opacity);
    primaryColor.value =
        Color.fromARGB(opacity, redColor, greenColor, blueColor);
  }

  //در صورتی که کاربر رنگ اختصاصی ست کرده باشه زمانی که برنامه داره بالا میاد اون رنگ فراخوانی میشه
  void getCurrentPrimaryColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final redColor = prefs.getInt(PrefsKey.redColorKey);
    final greenColor = prefs.getInt(PrefsKey.greenColorKey);
    final blueColor = prefs.getInt(PrefsKey.blueColorKey);
    final opacity = prefs.getInt(PrefsKey.opacityColorKey);

    if (redColor != null &&
        greenColor != null &&
        blueColor != null &&
        opacity != null) {
      primaryColor.value =
          Color.fromARGB(opacity, redColor, greenColor, blueColor);
    }
  }

  Rx<ThemeData> theme = lightmode().obs;

  RxBool isDarkMode = RxBool(false);

  void changeTheme() async {
    isDarkMode.value = !isDarkMode.value;
    //ذخیره تم
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKey.isDarkModeKey, isDarkMode.value);
    theme.value = isDarkMode.value ? darkmode() : lightmode();
  }

  void initialTheme() async {
    // خواندن تنظیمات تم از SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? storedDarkMode = prefs.getBool('isDarkMode');

    if (storedDarkMode != null) {
      isDarkMode.value = storedDarkMode;
    }

    theme.value = isDarkMode.value ? darkmode() : lightmode();
  }

  @override
  void onInit() {
    initialTheme();
    getCurrentPrimaryColor();
    super.onInit();
  }
}
