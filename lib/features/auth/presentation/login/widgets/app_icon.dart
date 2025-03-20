import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/strings.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Image.asset(
                StringManager.appIcon,
                width: 35.w,
                height: 35.h,
                errorBuilder:
                    (context, error, stackTrace) => // Added error handling
                        const Icon(Icons.agriculture_outlined),
              ),
            );
  }
}