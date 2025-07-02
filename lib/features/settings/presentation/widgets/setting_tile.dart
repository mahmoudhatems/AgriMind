import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              Icon(icon, color: ColorsManager.mainBlueGreen, size: 22.sp),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
              if (subtitle != null) 
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Text(subtitle!, style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                ),
              Icon(Icons.chevron_right, color: Colors.grey, size: 18.sp),
            ],
          ),
        ),
      ),
    );
  }
}