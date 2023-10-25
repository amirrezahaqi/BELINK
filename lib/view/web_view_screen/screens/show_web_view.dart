import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/web_view_controller/web_view_controller.dart';
import 'package:new_started/model/link_model/link_model.dart';
import 'package:new_started/view/web_view_screen/widgets/app_bar/web_view_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowWebViewScreen extends StatefulWidget {
  const ShowWebViewScreen({Key? key}) : super(key: key);

  @override
  State<ShowWebViewScreen> createState() => _ShowWebViewScreenState();
}

class _ShowWebViewScreenState extends State<ShowWebViewScreen> {
  late LinkModel? linkModel;
  final ShowWebViewController webViewController =
      Get.find<ShowWebViewController>();

  @override
  void initState() {
    linkModel = Get.arguments;
    webViewController.initialWebViewController(linkModel!.link, linkModel!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: WebViewAppBar(link: linkModel!, size: size),
        body: WebViewWidget(
          controller: webViewController.mainWebViewController,
        ));
  }
}
/*
IndexedStack(
        index: linkModel!.htmlTag.isEmpty ? 0 : 1,
        children: [
          // نمایش انلاین صفحه
          SizedBox(
            width: size.width,
            height: size.height,
            child: WebViewWidget(
              controller: webViewController.controller,
            ),
          ),
          // نمایش افلاین صفحه
          SingleChildScrollView(
            child: HtmlWidget(
              linkModel!.htmlTag,
              customStylesBuilder: (element) {
                if (element.localName == 'a') {
                  return {'text-decoration': 'rtl'};
                } else if (element.localName == 'header' ||
                    element.localName == 'footer' ||
                    element.className == 'breadcrumb-box' ||
                    element.className == 'posts-head' ||
                    element.className == 'comments-box') {
                  return {'display': 'none'};
                }
                return null;
              },
            ),
          ),
        ],
      ),
 */