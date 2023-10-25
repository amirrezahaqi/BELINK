import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_started/controller/notification_controller/notification_controller.dart';
import 'package:new_started/controller/theme_controller/theme_controller.dart';
import 'package:new_started/controller/translate/translate_controler.dart';
import 'package:new_started/core/binding/controller_binding.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/routes/screens_routes.dart';
import 'package:new_started/view/link_screen/screens/all_link_screen.dart';
import 'package:new_started/view/link_screen/screens/private_login.dart';
import 'package:new_started/view/link_screen/screens/show_category_links.dart';
import 'package:new_started/view/main_screen/screens/main_screen.dart';
import 'package:new_started/view/main_screen/screens/splash.dart';
import 'package:new_started/view/setting_screen/screens/about_screen.dart';
import 'package:new_started/view/web_view_screen/screens/last_read_screen.dart';
import 'package:new_started/view/web_view_screen/screens/show_web_view.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;

import 'core/constants/app_keys/hive_keys.dart';
import 'core/constants/translation/translate.dart';
import 'model/category_model/category_model.dart';
import 'model/link_model/link_model.dart';
import 'model/tag_model/tag_model.dart';

void main() async {
  // hive config
  await Hive.initFlutter();
  Hive.registerAdapter(LinkModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(TagModelAdapter());
  await Hive.openBox<CategoryModel>(HiveKeys.categoryKey);
  await Hive.openBox<TagModel>(HiveKeys.tagKey);
  await Hive.openBox<LinkModel>(HiveKeys.linkKey);
  // send notification config
  final NotificationController notificationController =
      Get.put(NotificationController());
  await notificationController.initNotification();
  tz.initializeTimeZones();

  // change status Bar Color
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: SolidColors.scaffoldColor));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final TranslateController translateController =
      Get.put(TranslateController());
  final ThemeController controller = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController controller = Get.put(ThemeController());
    return Obx(
      () => GetMaterialApp(
        initialBinding: ControllerBinding(),
        debugShowCheckedModeBanner: false,
        locale: Locale(translateController.currentLanguageCode.value),
        title: 'Linkrey',
        translations: Translate(),
        getPages: [
          GetPage(
              name: ScreenRoutes.mainScreenRoute,
              page: () => const MainScreen()),
          GetPage(
              name: ScreenRoutes.articleScreenRoute,
              page: () => const LastReadScreen()),
          GetPage(
              name: ScreenRoutes.aboutScreenRoute,
              page: () => const AboutScreen()),
          GetPage(
              name: ScreenRoutes.allLinkScreenRoute,
              page: () => AllLinkScreen()),
          GetPage(
              name: ScreenRoutes.privateLoginScreenRoute,
              page: () => const PrivateLoginScreen()),
          GetPage(
              name: ScreenRoutes.showCategoryLinksScreenRoute,
              page: () => const ShowCateGoryLinkScreen()),
          GetPage(
              name: ScreenRoutes.showWebViewScreenRoute,
              page: () => const ShowWebViewScreen()),
        ],
        theme: controller.theme.value,
        home: const SplashScreen(),
      ),
    );
  }
}
