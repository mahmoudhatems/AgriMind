import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/utils/colors.dart';

class BackLeadingAppbar extends StatelessWidget {
  const BackLeadingAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 26.sp,
            color: ColorsManager.textIconColor,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        );
  }
}