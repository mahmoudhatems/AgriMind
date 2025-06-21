import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

void showToast(BuildContext context, String message, {Color? color}) {
  Flushbar(
    message: message,
    duration: const Duration(seconds: 3),
    backgroundColor: color ?? ColorsManager.realWhiteColor.withValues(alpha: 0.1), // Light error background
    flushbarPosition: FlushbarPosition.BOTTOM,
    icon: const Icon(
      Icons.error_outline,
      color: ColorsManager.errorColor,
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    borderRadius: BorderRadius.circular(12),
    boxShadows:  [
      BoxShadow(
        color: ColorsManager.blackTextColor.withValues(alpha: 0.26),
        blurRadius: 6.0.r,
        offset: Offset(0, 3),
      ),
    ],
    messageColor: ColorsManager.blackTextColor.withValues(alpha: 0.87),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  )..show(context);
}
