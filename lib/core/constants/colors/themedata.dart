import 'package:flutter/material.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/gen/fonts.gen.dart';

ThemeData lightmode() {
  return ThemeData(
      cardColor: SolidColors.scaffoldColor,
      textTheme: const TextTheme(),
      scaffoldBackgroundColor: SolidColors.scaffoldColor,
      fontFamily: FontFamily.poppinsLatinMedium,
      brightness: Brightness.light,
      // elevatedButtonTheme:  const ElevatedButtonThemeData(
      //     style: ButtonStyle(backgroundColor: SolidColors.scaffoldColor)),
      inputDecorationTheme:
          const InputDecorationTheme(fillColor: SolidColors.scaffoldColor),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: SolidColors.scaffoldColor),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: SolidColors.scaffoldColor),
      primaryColor: SolidColors.colorPrimary,
      iconTheme: const IconThemeData(color: SolidColors.darkGray),
      appBarTheme:
          const AppBarTheme(backgroundColor: SolidColors.scaffoldColor));
}

ThemeData darkmode() {
  return ThemeData(
      cardColor: SolidColors.blackColor,
      textTheme: const TextTheme(),
      scaffoldBackgroundColor: SolidColors.blackColor,
      fontFamily: FontFamily.poppinsLatinMedium,
      brightness: Brightness.dark,
      // elevatedButtonTheme:  const ElevatedButtonThemeData(
      //     style: ButtonStyle(backgroundColor: SolidColors.scaffoldColor)),
      inputDecorationTheme:
          const InputDecorationTheme(fillColor: SolidColors.blackColor),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: SolidColors.blackColor),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: SolidColors.blackColor),
      primaryColor: SolidColors.colorPrimary,
      iconTheme: const IconThemeData(color: SolidColors.scaffoldColor),
      appBarTheme: const AppBarTheme(backgroundColor: SolidColors.blackColor));
}
