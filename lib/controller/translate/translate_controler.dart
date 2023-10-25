import 'dart:ui';

import 'package:get/get.dart';
import 'package:new_started/core/constants/app_keys/prefs_keys.dart';
import 'package:new_started/core/constants/eums/app_direction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslateController extends GetxController {
  RxString currentLanguageCode = 'en'.obs;
  Rx<AppDirection> directionality = AppDirection.ltr.obs;

  @override
  void onInit() {
    super.onInit();
    getLocale();
  }

  Future<void> changeLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var locale = Locale(language);
    Get.updateLocale(locale);
    prefs.setString(PrefsKey.appLanguageKey, language);
    currentLanguageCode.value = language;
    getDirection();
  }

  getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(PrefsKey.appLanguageKey);
    if (languageCode != null) {
      currentLanguageCode.value = languageCode;
      getDirection();
      Get.updateLocale(Locale(languageCode));
    }
  }

  getDirection() {
    if (currentLanguageCode.value == "en" ||
        currentLanguageCode.value == "ch") {
      directionality.value = AppDirection.ltr;
    } else {
      directionality.value = AppDirection.rtl;
    }
  }
}
