import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

Widget BuildStatusCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorsManager.mainBlueGreen, ColorsManager.mainBlueGreen.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.mainBlueGreen.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.greenAccent.withOpacity(0.5), blurRadius: 6, spreadRadius: 1)],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text("System Online", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 8.h),
                Text("All systems operational", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Text("Last updated: ${DateTime.now().toString().substring(11, 16)}", 
                     style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11.sp)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: ColorsManager.realWhiteColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.dashboard, color: ColorsManager.realWhiteColor, size: 24.sp),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3);
  }