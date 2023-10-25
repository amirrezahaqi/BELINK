import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';

class LinkeryTextField extends StatelessWidget {
  const LinkeryTextField({
    super.key,
    this.width = double.infinity,
    this.hintText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconColor = SolidColors.grayColor,
    this.inputType = TextInputType.text,
    required this.controller,
    this.obscure = false,
  });

  final double width;
  final String hintText;
  final TextInputType inputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final Color suffixIconColor;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        obscureText: obscure,
        decoration: InputDecoration(
          suffixIconColor: suffixIconColor,
          hintText: hintText.tr,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: SolidColors.grayColor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: SolidColors.grayColor, width: 1)),
        ),
      ),
    );
  }
}
