import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/web_view_controller/web_view_controller.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/eums/link_page_state.dart';
import 'package:new_started/view/link_screen/widgets/empty_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../link_screen/screens/all_link_screen.dart';

class LastReadScreen extends StatefulWidget {
  const LastReadScreen({Key? key}) : super(key: key);

  @override
  State<LastReadScreen> createState() => _LastReadScreenState();
}

class _LastReadScreenState extends State<LastReadScreen> {
  final ShowWebViewController webViewController =
      Get.find<ShowWebViewController>();
  @override
  void initState() {
    super.initState();
    webViewController.showLastReadeOffline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => webViewController.lastReadTag.value == ''
            ? EmptyState(
                content: AppTextConstants.notViewWebPage,
                btnText: AppTextConstants.allLinkTitle,
                onBtnTap: () =>
                    Get.to(AllLinkScreen(linkPageState: LinkPageState.all)))
            : WebViewWidget(
                controller: webViewController.lastReadWebViewController),
      ),
    );
  }
}


/// کد های دیزاین اولیه
/*
Scaffold(
      appBar: WebViewAppBar(size: size, link: LinkModel()),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // main article poster
              Container(
                margin: const EdgeInsets.only(top: Dimens.small),
                width: size.width,
                height: size.height * 0.32,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset(Assets.images.poster.path).image,
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.small),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.more_vert),
                      // Tag
                      TagItem(
                        textColor: SolidColors.scaffoldColor,
                        width: size.width * 0.14,
                        height: size.height * 0.03,
                        text: AppTextConstants.sports,
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  // listen icon
                  IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      iconSize: 32,
                      constraints: const BoxConstraints(),
                      icon: const Icon(CupertinoIcons.play_circle,
                          color: SolidColors.colorPrimary)),
                  SizedBox(width: size.width * 0.02),
                  Text(AppTextConstants.listen.tr,
                      style: AppTextStyle.articleContentTextStyle
                          .apply(color: SolidColors.colorPrimary)),
                  SizedBox(width: size.width * 0.12),
                  IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      iconSize: 32,
                      constraints: const BoxConstraints(),
                      icon: SvgPicture.asset(Assets.icon.scrol)),
                  SizedBox(width: size.width * 0.02),
                  Text(AppTextConstants.autoScroll.tr,
                      style: AppTextStyle.articleContentTextStyle
                          .apply(color: SolidColors.colorPrimary))
                ],
              ),
              SizedBox(height: size.height * 0.02),
              // title and content post
              Text(AppTextConstants.postTitle.tr,
                  style: AppTextStyle.articleTitleTextStyle),
              SizedBox(height: size.height * 0.01),
              Text(AppTextConstants.longLorem.tr,
                  style: AppTextStyle.articleContentTextStyle),

              SizedBox(height: size.height * 0.06),
              // more article list
              SizedBox(
                height: size.height * 0.19,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // وقتی مدل مقاله ایجاد شد باید مدل مقاله رو بهش پاس بدیم تا اطلاعات رو بر اساس اون نمایش بدیم
                    return MoreArticleWidget(size: size);
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02)
            ],
          ),
        ),
      ),
    );
 */
