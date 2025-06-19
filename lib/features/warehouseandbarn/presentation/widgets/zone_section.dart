import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';

class ZoneSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> sensors;

  const ZoneSection({super.key, required this.title, required this.sensors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warehouse, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text(title, style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.start,
          children: sensors
              .map((sensor) => InfoTile(
                    icon: sensor['icon'],
                    label: sensor['label'],
                    value: sensor['value'],
                  ))
              .toList(),
        ),
      ],
    );
  }
}
