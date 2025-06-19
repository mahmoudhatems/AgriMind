import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

class SettingSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Icon(icon, size: 22.sp, color: ColorsManager.mainBlueGreen),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: ColorsManager.mainBlueGreen,
          ),
        ],
      ),
    );
  }
}
