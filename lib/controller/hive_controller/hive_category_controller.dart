import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_started/core/constants/app_keys/prefs_keys.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';
import 'package:new_started/model/category_model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_keys/hive_keys.dart';
import '../../core/widgets/snackbar_widget/custom_snackbar_widget.dart';
import '../../gen/assets.gen.dart';

class HiveCategoryController extends GetxController {
  final categoryBox = Hive.box<CategoryModel>(HiveKeys.categoryKey);

  final TextEditingController categoryNameTextController =
      TextEditingController();
  final TextEditingController categorySearchTextController =
      TextEditingController();
  // ایکون اولیه
  RxString currentIcon = Assets.icon.lock.obs;

  // رنگ اولیه
  Rx<Color> iconColor = SolidColors.redColor.obs;
  CategoryModel categoryModel = CategoryModel();

  // دسته بندی انتخاب شده
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;

  // لیست دسته بندی ها
  final RxList<CategoryModel> categoryDefaultList = [
    CategoryModel(
        name: AppTextConstants.videoCategory.tr, icon: Assets.icon.youtube),
    CategoryModel(
        name: AppTextConstants.audioCategory.tr, icon: Assets.icon.headphones),
    CategoryModel(
        name: AppTextConstants.locationCategory, icon: Assets.icon.mapPin),
    CategoryModel(
        name: AppTextConstants.bookCategory, icon: Assets.icon.bookOpen),
    CategoryModel(name: "aperture", icon: Assets.icon.aperture),
    CategoryModel(name: "archive", icon: Assets.icon.archive),
    CategoryModel(name: "coffee", icon: Assets.icon.coffee),
    CategoryModel(name: "atSign", icon: Assets.icon.atSign),
    CategoryModel(name: "speaker", icon: Assets.icon.speaker),
    CategoryModel(name: "box", icon: Assets.icon.box),
    CategoryModel(name: "briefcase", icon: Assets.icon.briefcase),
    CategoryModel(name: "chrome", icon: Assets.icon.chrome),
    CategoryModel(name: "clock", icon: Assets.icon.clock),
    CategoryModel(name: "cpu", icon: Assets.icon.cpu),
    CategoryModel(name: "creditCard", icon: Assets.icon.creditCard),
    CategoryModel(name: "dollarSign", icon: Assets.icon.dollarSign),
    CategoryModel(name: "figma", icon: Assets.icon.figma),
    CategoryModel(name: "eye", icon: Assets.icon.eye),
    CategoryModel(name: "feather", icon: Assets.icon.feather),
    CategoryModel(name: "github", icon: Assets.icon.github),
    CategoryModel(name: "gitPullRequest", icon: Assets.icon.gitPullRequest),
    CategoryModel(name: "gitlab", icon: Assets.icon.gitlab),
    CategoryModel(name: "globe", icon: Assets.icon.globe),
    CategoryModel(name: "linkedin", icon: Assets.icon.linkedin),
    CategoryModel(name: "image", icon: Assets.icon.image),
    CategoryModel(name: "instagram", icon: Assets.icon.instagram),
    CategoryModel(name: "lock", icon: Assets.icon.lock),
    CategoryModel(name: "pocket", icon: Assets.icon.pocket),
    CategoryModel(name: "telegram", icon: Assets.icon.send),
    CategoryModel(name: "shoppingBag", icon: Assets.icon.shoppingBag),
    CategoryModel(name: "slack", icon: Assets.icon.slack),
    CategoryModel(name: "target", icon: Assets.icon.target),
    CategoryModel(name: "twitch", icon: Assets.icon.twitch),
    CategoryModel(name: "truck", icon: Assets.icon.truck),
    CategoryModel(name: "twitter", icon: Assets.icon.twitter),
    CategoryModel(name: "youtube", icon: Assets.icon.youtube),
    CategoryModel(name: "thermometer", icon: Assets.icon.thermometer),
    CategoryModel(name: "tool", icon: Assets.icon.tool),
    CategoryModel(name: "smile", icon: Assets.icon.smile),
    CategoryModel(name: "tv", icon: Assets.icon.tv),
    CategoryModel(name: "watch", icon: Assets.icon.watch),
    CategoryModel(name: "star", icon: Assets.icon.star),
  ].obs;

  // دسته بندی های اولیه برنامه
  final List<CategoryModel> defaultAppCategory = [
    CategoryModel(
        name: AppTextConstants.videoCategory,
        icon: Assets.icon.youtube,
        color: SolidColors.redColor),
    CategoryModel(
        name: AppTextConstants.audioCategory,
        icon: Assets.icon.headphones,
        color: SolidColors.orangeColor),
    CategoryModel(
        name: AppTextConstants.locationCategory,
        icon: Assets.icon.mapPin,
        color: SolidColors.blueColor),
    CategoryModel(
        name: AppTextConstants.bookCategory,
        icon: Assets.icon.bookOpen,
        color: SolidColors.greenCategoryColor),
  ];

  // در صورتی که کاربر برای بار اول وارد اپلیکیشن بشه دسته بندی های پیش فرض رو اضافه میکنه
  addDefaultCategoryToAPP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool(PrefsKey.isFirstKey) ?? true;
    if (isFirst == true) {
      for (var item in defaultAppCategory) {
        categoryBox.add(item);
      }
      prefs.setBool(PrefsKey.isFirstKey, false);
    }
  }

  // اضافه کردن دسته بندی به برنامه توسط کاربر
  addCategory(BuildContext context) {
    categoryModel.name = categoryNameTextController.text;
    categoryModel.icon = currentIcon.value;
    categoryModel.color = iconColor.value;
    if (categoryNameTextController.text.isNotEmpty) {
      final existingCategory = categoryBox.values.firstWhere(
          (category) => category.name == categoryNameTextController.text,
          orElse: () => CategoryModel());
      // در صورتی که دسته بندی قبلا داخل دیتابیس وجود داشته باشه
      if (existingCategory.name != '') {
        customSnackbar(
            title: AppTextConstants.error,
            massage: AppTextConstants.categoryHasAlreadyMassage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: SolidColors.redColor,
            textColor: SolidColors.scaffoldColor);
      }
      // اضافه کردن دسته بندی به دیتابیس
      else {
        categoryBox.add(categoryModel);
        Navigator.pop(context);
      }
    }
    // در صورتی که کاربر نام دسته بندی رو وارد نکرده باشه
    else {
      customSnackbar(
          title: AppTextConstants.error,
          massage: AppTextConstants.setNameForCategoryMassage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: SolidColors.redColor,
          textColor: SolidColors.scaffoldColor);
    }
    categoryModel = CategoryModel();
  }
}
