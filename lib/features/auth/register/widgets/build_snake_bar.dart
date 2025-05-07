import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

void buildSnackBar(
  BuildContext context,
  String message, {
  Color? backgroundColor,
  Color? textColor,
  Duration duration = const Duration(seconds: 2),
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  // Close any existing SnackBars
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontSize: 14.sp,
          color: textColor ?? ColorsManager.errorColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: backgroundColor ?? ColorsManager.backGroundMoreLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.1,
        vertical: 10.h,
      ),
      duration: duration,
    ),
  );
}
