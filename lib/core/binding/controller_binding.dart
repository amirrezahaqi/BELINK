import 'package:get/get.dart';
import 'package:new_started/controller/hive_controller/hive_category_controller.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/controller/navigation_controller/bottom_navigation_controller.dart';
import 'package:new_started/controller/notification_controller/notification_controller.dart';
import 'package:new_started/controller/password_controller/pass_controller.dart';
import 'package:new_started/controller/qrcode_controller/qrcodescanner_controler.dart';
import 'package:new_started/controller/theme_controller/theme_controller.dart';
import 'package:new_started/controller/translate/translate_controler.dart';
import 'package:new_started/controller/web_view_controller/web_view_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    // bottom navigation controller
    Get.put<BottomNavigationController>(BottomNavigationController());
    // hive category controller
    Get.put<HiveCategoryController>(HiveCategoryController());
    // hive link controller
    Get.put<HiveLinkController>(HiveLinkController());
    // translate app controller
    Get.put<TranslateController>(TranslateController());

    // qrcode scanner controller
    Get.put<QrCodeScannerController>(QrCodeScannerController());
    // theme controller
    Get.put<ThemeController>(ThemeController());
    // WebView controller
    Get.put<ShowWebViewController>(ShowWebViewController());
    // Notification controller
    Get.put<NotificationController>(NotificationController());
    //passController
    Get.put<PassController>(PassController());
  }
}
