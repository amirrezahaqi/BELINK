import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_started/core/constants/colors/solid_colors.dart';
import 'package:new_started/gen/fonts.gen.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle tagTextStyle = const TextStyle(
      fontFamily: FontFamily.poppinsLatinMedium,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: Colors.white);

  static TextStyle aboutTitleStyle = const TextStyle(
    color: SolidColors.darkGray,
    fontFamily: FontFamily.poppinsLatinRegular,
    fontSize: 15,
  );
  static TextStyle aboutDeveloperStyle = const TextStyle(
      fontFamily: FontFamily.poppinsLatinMedium,
      color: SolidColors.boldDarkGray,
      fontSize: 20);

  static TextStyle aboutTeamNameStyle = const TextStyle(
    color: SolidColors.boldDarkGray,
    fontFamily: FontFamily.poppinsLatinSemiBold,
    fontSize: 25,
  );

  static TextStyle homeToolsTitle = const TextStyle(
      fontSize: 12, fontFamily: FontFamily.poppinsLatinSemiBold);

  static TextStyle articleTitleTextStyle = const TextStyle(
      fontFamily: FontFamily.poppinsLatinSemiBold,
      fontWeight: FontWeight.w700,
      fontSize: 30,
      color: SolidColors.darkGray);

  static TextStyle lastArticleTitleTextStyle = const TextStyle(
      fontFamily: FontFamily.poppinsLatinRegular,
      fontSize: 14,
      color: SolidColors.blackColor);

  static TextStyle articleContentTextStyle = const TextStyle(
      fontFamily: FontFamily.poppinsLatinRegular,
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: SolidColors.darkGray);

  static TextStyle subTitleTextStyle = const TextStyle(
      fontFamily: FontFamily.poppinsLatinSemiBold,
      fontSize: 10,
      color: SolidColors.darkGray);

  static TextStyle domainLinkTextStyle = const TextStyle(
      fontFamily: FontFamily.poppinsLatinRegular,
      fontSize: 14,
      color: SolidColors.darkGray);

  static TextStyle bottomNavLableTextStyle = const TextStyle(
      fontFamily: FontFamily.poppinsLatinRegular,
      fontSize: 14,
      color: SolidColors.deactivateBottomNavColor);

  static TextStyle settingItemStyle = GoogleFonts.notoSans(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: SolidColors.settingGeryText);

  static TextStyle homeTextTitle = const TextStyle(
      fontFamily: FontFamily.poppinsLatinSemiBold,
      color: SolidColors.colorPrimary,
      fontSize: 15);
  static TextStyle homeTextViewAll = const TextStyle(
      fontFamily: FontFamily.poppinsLatinMedium,
      color: SolidColors.darkGray,
      fontSize: 15);

  static TextStyle colorPickerStyle = GoogleFonts.notoSans(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: SolidColors.colorPickerText);

  static TextStyle linkeryBottomTextStyle = GoogleFonts.notoSans(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: SolidColors.scaffoldColor);

  static TextStyle snackBarTitle =
      GoogleFonts.notoSans(fontWeight: FontWeight.w700, fontSize: 16);

  static TextStyle snackBarMassage =
      GoogleFonts.notoSans(fontWeight: FontWeight.w400, fontSize: 14);

  static TextStyle normalText =
      GoogleFonts.notoSans(fontWeight: FontWeight.w700, fontSize: 16);
}
