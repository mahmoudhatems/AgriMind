import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class TipCard extends StatelessWidget {
  final String text;

  const TipCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorsManager.realWhiteColor,
      boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.amber.shade600, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: Styles.styleText14BlackColofontJosefinSans.copyWith(height: 1.6, fontSize: 13.sp),
            ),
          )
        ],
      ),
    ).animate().fade(duration: 600.ms).slideY(begin: 0.2);
  }
}
