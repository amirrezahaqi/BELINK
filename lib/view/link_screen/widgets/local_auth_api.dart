import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();
  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    try {
      // ignore: deprecated_member_use
      return await _auth.authenticate(
        localizedReason: AppTextConstants.fingerPrintlocalizedReason,
        // useErrorDialogs: true,

        // stickyAuth: true,
      );
    } on PlatformException {
      return false;
    }
  }
}
