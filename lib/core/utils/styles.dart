import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';

/// Styles class is used to store the text styles used in the app.
abstract class Styles {
  static final styleSemiBoldText20BlackColorfontJosefinSans = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: ColorsManager.textIconColor,
    fontFamily: StringManager.fontJosefinSans,
  );

  static final styleText14BlackColofontJosefinSans = TextStyle(
    color: ColorsManager.textIconColor,
    fontSize: 14.sp,
    fontFamily: StringManager.fontJosefinSans,
  );
  static final styleBoldText34darkBluefontJosefinSans = TextStyle(
      fontFamily: StringManager.fontJosefinSans,
      fontSize: 34.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.darkBlueTextColor);
  static final styleBoldText28darkBluefontJosefinSans = TextStyle(
      fontFamily: StringManager.fontJosefinSans,
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      color: ColorsManager.darkBlueTextColor);
  static final styleSemiBoldText20darkBluefontJosefinSans = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: ColorsManager.darkBlueTextColor,
    fontFamily: StringManager.fontJosefinSans,
  );
  static final styleNormalText14GrayfontJosefinSans = TextStyle(
    color: ColorsManager.textIconColorGray,
    fontSize: 14.sp,
    fontFamily: StringManager.fontJosefinSans,
  );
  static final styleBoldText20GrayfontJosefinSans = TextStyle(
    color: ColorsManager.textIconColorGray,
    fontSize: 20.sp,
    fontFamily: StringManager.fontJosefinSans,
    fontWeight: FontWeight.bold,
  );

  static final stylesemiBoldText18ButomfontJosefinSans = TextStyle(
    color: ColorsManager.textIconColorGray,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: StringManager.fontJosefinSans,
  );
  static final styleBoldText20ButomfontJosefinSans = TextStyle(
    color: ColorsManager.darkBlueTextColor,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    fontFamily: StringManager.fontJosefinSans,
  );
  static final styleBoldText16ButomfontJosefinSans = TextStyle(
    color: ColorsManager.realWhiteColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    fontFamily: StringManager.fontJosefinSans,
  );
}
