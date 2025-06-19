import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingGroup extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingGroup({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues( alpha:  0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: List.generate(items.length, (i) {
              return Column(
                children: [
                  items[i],
                  if (i != items.length - 1)
                    Divider(indent: 56.w, height: 1, color: Colors.grey.withValues( alpha: 0.1)),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
