

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

void buildSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, 
          style: TextStyle(
        fontSize: 14.sp,
        color: ColorsManager.errorColor,
        fontWeight: FontWeight.w500,
      )),
      backgroundColor: ColorsManager.backGroundMoreLight,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      duration: const Duration(seconds: 2),
    ),
  );
}
