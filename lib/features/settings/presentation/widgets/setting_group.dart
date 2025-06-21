import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

class SettingGroup extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingGroup({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
          child: Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.realWhiteColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(color: ColorsManager.blackTextColor.withValues(alpha: 0.05), blurRadius: 15, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              return Column(
                children: [
                  items[index],
                  if (index < items.length - 1)
                    Divider(height: 1, indent: 56.w, color: ColorsManager.textIconColorGray.withValues(alpha: 0.1)),
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}