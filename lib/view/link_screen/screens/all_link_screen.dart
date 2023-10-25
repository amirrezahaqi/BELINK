// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/eums/link_page_state.dart';
import 'package:new_started/core/constants/routes/screens_routes.dart';
import 'package:new_started/core/constants/text_style/text_styles.dart';
import 'package:new_started/core/widgets/bottom_sheet/create_newlink_bottom_sheet.dart';
import 'package:new_started/model/link_model/link_model.dart';
import 'package:new_started/view/link_screen/widgets/empty_state.dart';
import 'package:new_started/view/link_screen/widgets/link_item_widget.dart';

class AllLinkScreen extends StatelessWidget {
  AllLinkScreen({Key? key, this.linkPageState = LinkPageState.all})
      : super(key: key);
  late LinkPageState linkPageState;

  @override
  Widget build(BuildContext context) {
    // مشخص کردن عنوان صفحه جهت نمایش به کاربر بر اساس وضعیت
    final String pageTitle;
    switch (linkPageState) {
      case LinkPageState.bookMark:
        pageTitle = AppTextConstants.bookMarkLinkTitle.tr;
        break;
      case LinkPageState.all:
        pageTitle = AppTextConstants.allLinkTitle.tr;
        break;
      case LinkPageState.private:
        pageTitle = AppTextConstants.privateLinks.tr;
        break;
      default:
        {
          pageTitle = AppTextConstants.allLinkTitle.tr;
        }
    }

    final HiveLinkController hiveLinkController =
        Get.find<HiveLinkController>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: hiveLinkController.linkBox.listenable(),
          builder: (context, box, child) {
            // لود کردن دیتا بر اساس حالت های مختلف
            List<LinkModel> data;
            switch (linkPageState) {
              case LinkPageState.bookMark:
                data = box.values
                    .where((element) => element.isBookMark == true)
                    .toList();
                break;
              case LinkPageState.all:
                data = box.values
                    .where((element) => element.isPrivate == false)
                    .toList();
                break;
              case LinkPageState.private:
                data = box.values
                    .where((element) => element.isPrivate == true)
                    .toList();
                break;
              default:
                {
                  data = box.values.toList();
                }
            }
            if (data.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimens.medium),
                    child: Text(pageTitle,
                        style: AppTextStyle.articleContentTextStyle.apply(
                            color: SolidColors.colorPrimary,
                            fontSizeFactor: 1.2)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return LinkItem(
                          linkModel: data[index],
                          size: size,
                          verticalMargin: 10,
                          onTap: () => Get.toNamed(
                              ScreenRoutes.showWebViewScreenRoute,
                              arguments: data[index]),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                  child: EmptyState(
                btnText: linkPageState == LinkPageState.bookMark
                    ? AppTextConstants.allLinkTitle
                    : AppTextConstants.addNew,
                // اگر هیچ لینکی bookmark نشده بود
                content: linkPageState == LinkPageState.all
                    ? AppTextConstants.emptyNoBookMarkStateTxt
                    :
                    // در صورتی که هیچ لینکی اضافه نشده باشه
                    linkPageState == LinkPageState.all
                        ? AppTextConstants.emptyStateTxt
                        :
                        // در صورتی که لینک خصوصی وجود نداشته باشه
                        AppTextConstants.emptyPrivateStateTxt,
                onBtnTap: () {
                  // در صورتی که صفحه بوک مارک خالی باشه به صفحه کل لینک ها میره تا بوک مارک کنه و غیر این صورت باتک شیت لینک جدید باز میشه
                  if (linkPageState == LinkPageState.bookMark) {
                    Get.toNamed(ScreenRoutes.allLinkScreenRoute);
                  } else {
                    createNewLinkBottomSheet(context);
                  }
                },
              ));
            }
          },
        ),
      ),
    );
  }
}
