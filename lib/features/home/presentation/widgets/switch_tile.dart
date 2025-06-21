import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

class SwitchTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? subtitle;

  const SwitchTile({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = value ? ColorsManager.mainBlueGreen : ColorsManager.textIconColorGray;
    final bgColor = value
        ? ColorsManager.mainBlueGreen.withValues( alpha:  0.15)
        : ColorsManager.textIconColorGray.withValues( alpha:  0.1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: ColorsManager.realWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.blackTextColor.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(fontSize: 11.sp, color: ColorsManager.textIconColorGray),
                  ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (newVal) {
              HapticFeedback.lightImpact();
              onChanged(newVal);
            },
            activeColor: ColorsManager.mainBlueGreen,
          ),
        ],
      ),
    );
  }
}
