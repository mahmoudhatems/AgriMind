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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Icon(icon, size: 22.sp, color: ColorsManager.mainBlueGreen),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(title,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
            ),
            if (subtitle != null)
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Text(subtitle!,
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
              ),
            Icon(Icons.chevron_right, size: 20.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
