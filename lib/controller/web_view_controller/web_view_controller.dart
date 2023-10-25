import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:new_started/core/api_service/dio_service.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/app_keys/prefs_keys.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/widgets/snackbar_widget/custom_snackbar_widget.dart';
import 'package:new_started/model/link_model/link_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowWebViewController extends GetxController {
  final WebViewController mainWebViewController = WebViewController();
  final WebViewController lastReadWebViewController = WebViewController();
  final DioService dioService = DioService();
  RxString lastReadTag = "".obs;

  // لینک رو دریافت و درخواست رو ارسال میکنه
  initialWebViewController(String url, LinkModel link) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    mainWebViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(SolidColors.scaffoldColor)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          const SpinKitThreeBounce(
            color: SolidColors.blackColor,
            size: 30,
          );
        },
        // زمانی که صفحه داره لود میشه
        onPageStarted: (url) {},
        // زمانی که صفحه به صورت کامل لود بشه تگ های صفحه تو هایو ذخیره میشن
        onPageFinished: (url) async {
          final response = await dioService.getMethod(url);
          if (response.statusCode == 200) {
            var doc = parse(response.data);
            // ذخیره تگ ها به داخل دیتابیس
            link.htmlTag =
                doc.getElementsByTagName("body").toList()[0].outerHtml;
            link.save();
            lastReadTag.value = doc.outerHtml;
            await preferences.setString(PrefsKey.lastReadKey,
                doc.getElementsByTagName("body").toList()[0].outerHtml);
          }
        },
        // زمانی که لینک لود نشه و به ارور بخوره
        onWebResourceError: (error) {
          customSnackbar(
              title: AppTextConstants.error,
              massage: error.description,
              backgroundColor: SolidColors.redColor,
              textColor: SolidColors.scaffoldColor);
        },
      ));

    // در صورتی که تگ ها کش شده باشن صفحه افلاین و در غیر این صورت صفحه آنلاین نمایش داده میشه
    if (link.htmlTag.isEmpty) {
      mainWebViewController.loadRequest(Uri.parse(url));
    } else {
      mainWebViewController.loadHtmlString(link.htmlTag);
    }
  }

  //نمایش افلاین اخرین صفحه ذخیره شده
  showLastReadeOffline() async {
    lastReadWebViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(SolidColors.scaffoldColor)
      ..setUserAgent(AppTextConstants.boxCategory)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          const SpinKitThreeBounce(
            color: SolidColors.blackColor,
            size: 30,
          );
        },
        // زمانی که صفحه داره لود میشه
        onPageStarted: (url) {},
        // زمانی که صفحه به صورت کامل لود بشه تگ های صفحه تو هایو ذخیره میشن
        onPageFinished: (url) async {},
        // زمانی که لینک لود نشه و به ارور بخوره
        onWebResourceError: (error) {
          customSnackbar(
              title: AppTextConstants.error,
              massage: error.description,
              backgroundColor: SolidColors.redColor,
              textColor: SolidColors.scaffoldColor);
        },
      ));
    lastReadWebViewController.loadHtmlString(lastReadTag.value);
  }

  // مقدار دهی اولیه تگ های اخرین صفحه بازدید شده
  setLastReadTag() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString(PrefsKey.lastReadKey) != null) {
      lastReadTag.value = preferences.getString(PrefsKey.lastReadKey)!;
    }
  }

  @override
  void onInit() {
    super.onInit();
    setLastReadTag();
  }
}
