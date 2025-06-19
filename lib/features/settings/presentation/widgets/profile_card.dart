import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.realWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: ColorsManager.mainBlueGreen,
            child: Icon(Icons.person, color: Colors.white, size: 28.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mahmoud Hatem',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Text(
                  'mahmoud@happyfarm.com',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey, size: 20.sp),
        ],
      ),
    );
  }
}
