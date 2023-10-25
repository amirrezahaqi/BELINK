import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScannerController extends GetxController {
  Barcode? result;
  QRViewController? controller;

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      update();
    });
  }

  Future<void> toggleFlash() async {
    await controller?.toggleFlash();
    update();
  }

  Future<void> flipCamera() async {
    await controller?.flipCamera();
    update();
  }

  Future<bool?>? getFlashStatus() {
    return controller?.getFlashStatus();
  }

  Future<CameraFacing>? getCameraInfo() {
    return controller?.getCameraInfo();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}
