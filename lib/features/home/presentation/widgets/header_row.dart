import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/features/home/presentation/widgets/welcome_text_animated.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.home_outlined, color: ColorsManager.mainBlueGreen, size: 26.sp),
        SizedBox(width: 8.w),
        const WelcomeText(),
      ],
    ).animate().fade().slideX(begin: -0.1);
  }
}
