import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/qrcode_controller/qrcode_controller.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';
import 'package:new_started/core/widgets/app_bottom/app_bottom_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateScreen extends GetView<QrController> {
  GenerateScreen({Key? key}) : super(key: key);

  final QrController qrCodeController = Get.find<QrController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrCodeController.dataString.value,
              backgroundColor: SolidColors.whiteColor,
              padding: const EdgeInsets.all(Dimens.large * 2),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.large),
              child: LinkeryBottom(
                text: AppTextConstants.save,
                onPress: qrCodeController.saveQrCode,
              ),
            )
          ],
        ),
      ),
    );
  }
}
