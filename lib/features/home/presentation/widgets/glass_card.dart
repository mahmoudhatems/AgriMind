
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class GlassCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const GlassCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: ColorsManager.mainBlueGreen),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: Styles.styleSemiBoldText20darkBluefontJosefinSans,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...children,
        ],
      ),
    );
  }
}
