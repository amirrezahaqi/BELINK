import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/controller/qrcode_controller/qrcode_controller.dart';
import 'package:new_started/controller/translate/translate_controler.dart';
import 'package:new_started/core/constants/Texts/text_constant.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/gen/assets.gen.dart';
import 'package:new_started/model/link_model/link_model.dart';
import 'package:new_started/view/link_screen/widgets/qrcode_generator.dart';

import 'more_bottom_sheet_item.dart';

Future<dynamic> moreBottomSheet(BuildContext context, LinkModel linkModel) {
  final HiveLinkController hiveLinkController = Get.find<HiveLinkController>();
  // final QrController qrCodeController = Get.find<QrController>();
  final QrController qrCodeController = Get.put(QrController(context));
  final TranslateController translateController =
      Get.find<TranslateController>();

  final Size size = MediaQuery.of(context).size;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return Container(
        height: size.height / 3,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: Dimens.large),
            //setReadReminder
            MoreBottomSheetItem(
              title: AppTextConstants.setReadReminder,
              iconPath: Assets.icon.clock,
              onTap: () {
                Get.back();
                hiveLinkController.setReadReminder(
                    context: context,
                    locale: translateController.currentLanguageCode.value,
                    link: linkModel);
              },
            ),
            //generateQr
            MoreBottomSheetItem(
              title: AppTextConstants.generateQr,
              iconPath: Assets.icon.qrcode,
              onTap: () {
                // لینک مدل پاس داده شده، ابجکتیه که روی دکمه more کلیک شده
                qrCodeController.updateDataString(linkModel);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GenerateScreen(),
                ));
              },
            ),
            // edit
            MoreBottomSheetItem(
              title: AppTextConstants.editTxt,
              iconPath: Assets.icon.edit,
              onTap: () {
                hiveLinkController.updateLink(context, linkModel);
              },
            ),
            //delete
            MoreBottomSheetItem(
              title: AppTextConstants.deleteTxt,
              iconPath: Assets.icon.delete,
              onTap: () {
                hiveLinkController.deleteLink(linkModel);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: Dimens.medium - 2),
          ],
        ),
      );
    },
  );
}
