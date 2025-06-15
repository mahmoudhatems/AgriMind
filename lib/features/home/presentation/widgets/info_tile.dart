
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.tileBackground,
        borderRadius: BorderRadius.circular(16.r),
       
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: ColorsManager.mainBlueGreen.withOpacity(0.12),
            child: Icon(icon, color: ColorsManager.mainBlueGreen, size: 20.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: Styles.styleText14BlackColofontJosefinSans.copyWith(
              color: ColorsManager.darkBlueTextColor,
            ),
          ),
          Text(
            value,
            style: Styles.styleBoldText16ButomfontJosefinSans.copyWith(
              color: ColorsManager.mainBlueGreen,
            ),
          ),
        ],
      ),
    );
  }
}
