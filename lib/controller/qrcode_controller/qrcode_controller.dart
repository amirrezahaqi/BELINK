import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:new_started/controller/hive_controller/hive_link_controller.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';
import 'package:new_started/core/widgets/bottom_sheet/create_newlink_bottom_sheet.dart';
import 'package:new_started/model/link_model/link_model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrController extends GetxController {
  QrController(this.context);
  BuildContext context;
  RxString dataString = AppTextConstants.qrCodeDataString.obs;
  QRViewController? qrController;
  RxString result = ''.obs;

  void updateDataString(LinkModel linkModel) {
    dataString.value = linkModel.link;
  }

  void saveQrCode() async {
    // گرفتن تصویر qr code از ویجت QrImage
    final qrImage = await QrPainter(
      emptyColor: SolidColors.scaffoldColor,
      data: dataString.string,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    ).toImage(200);

    // تبدیل تصویر به بایت
    final byteData = await qrImage.toByteData(format: ImageByteFormat.png);
    if (byteData != null) {
      final bytes = byteData.buffer.asUint8List();

      // ذخیره تصویر در گالری
      // ignore: unused_local_variable
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(bytes),
      );
    }
  }

  void qrViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((data) {
      if (data.code != null) {
        final HiveLinkController linkController =
            Get.find<HiveLinkController>();
        linkController.linkTextController.text = data.code!;
        createNewLinkBottomSheet(context);
      }
    });
  }
}
