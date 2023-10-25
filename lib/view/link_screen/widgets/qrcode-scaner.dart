// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/controller/qrcode_controller/qrcode_controller.dart';
import 'package:new_started/controller/qrcode_controller/qrcodescanner_controler.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/core/constants/dimens/dimens.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanner extends GetView<QrCodeScannerController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QrCodeScanner({super.key});

  @override
  Widget build(BuildContext context) {
    final QrController qrController = Get.put(QrController(context));
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: QRView(
            key: qrKey,
            onQRViewCreated: qrController.qrViewCreated,
            overlay: QrScannerOverlayShape(
                borderRadius: Dimens.large,
                borderColor: SolidColors.redColor,
                cutOutSize: Dimens.large * 12),
          ))
        ],
      ),
    );
  }
}
