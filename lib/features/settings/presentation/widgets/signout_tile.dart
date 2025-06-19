import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

class SignOutTile extends StatelessWidget {
  final VoidCallback onTap;
  const SignOutTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.realWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Icon(Icons.logout, color: ColorsManager.errorColor, size: 22.sp),
                SizedBox(width: 16.w),
                Text('Sign Out', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorsManager.errorColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}