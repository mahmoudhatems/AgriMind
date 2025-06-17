import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 30.sp, color: ColorsManager.mainBlueGreen),
          SizedBox(height: 8.h),
          Text(label, style: Styles.styleText14BlackColofontJosefinSans.copyWith(fontSize: 14.sp)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.black87)),
        ],
      ),
    );
  }
}
