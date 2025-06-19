import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.realWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: ColorsManager.mainBlueGreen,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Icon(Icons.person, color: Colors.white, size: 28.sp),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mahmoud Hatem", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 4.h),
              Text("mahmoud@happyfarm.com", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
            ],
          ),
          Spacer(),
          Icon(Icons.chevron_right, color: Colors.grey, size: 20.sp)
        ],
      ),
    );
  }
}