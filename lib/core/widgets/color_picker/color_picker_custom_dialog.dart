import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/texts/text_constant.dart';
import 'package:new_started/core/widgets/app_bottom/app_bottom_widget.dart';

Future<dynamic> linkeryColorPicker(
    {required BuildContext context,
    required Function(Color) onChange,
    required Color pickerColor}) {
  return showDialog(
    context: context,
    builder: (context) {
      final Size size = MediaQuery.of(context).size;
      return AlertDialog(
        content: SizedBox(
          height: 530,
          child: Column(
            children: [
              //color picker
              ColorPicker(pickerColor: pickerColor, onColorChanged: onChange),

              LinkeryBottom(
                onPress: () => Get.back(),
                height: size.height * 0.06,
                text: AppTextConstants.changeColor.tr,
              )
            ],
          ),
        ),
      );
    },
  );
}
