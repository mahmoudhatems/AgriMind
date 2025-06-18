import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class SwitchTile extends StatelessWidget {
  final String label;
  final String? subtitle;
  final IconData icon;
  final ValueNotifier<bool> controller;

  const SwitchTile({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: controller,
                builder: (context, isActive, _) {
                  return Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: isActive
                          ? ColorsManager.mainBlueGreen.withValues(alpha: 0.15)
                          : Colors.grey.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 26.sp,
                      color: isActive
                          ? ColorsManager.mainBlueGreen
                          : Colors.grey,
                    ),
                  );
                },
              ),
              SizedBox(width: 14.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Styles.styleText14BlackColofontJosefinSans.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: Colors.black87,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          AdvancedSwitch(
            controller: controller,
            activeColor: ColorsManager.greenColor,
            inactiveColor: ColorsManager.errorColor,
            height: 32.h,
            width: 62.w,
            thumb: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                return Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    value ? Icons.check_rounded : Icons.close_rounded,
                    color: value
                        ? ColorsManager.greenColor
                        : ColorsManager.errorColor,
                    size: 20.sp,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fade().slideY(begin: 0.1);
  }
}
