import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart';

class ZoneControls extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> switches;

  const ZoneControls({super.key, required this.title, required this.switches});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.settings, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text(title, style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: switches.map((device) {
            final ValueNotifier<bool> controller = device['controller'];
            return ValueListenableBuilder<bool>(
              valueListenable: controller,
              builder: (context, value, _) {
                return SwitchTile(
                  label: device['label'],
                  icon: device['icon'],
                  value: value,
                  onChanged: (val) => controller.value = val,
                );
              },
            );
          }).toList(),
        )
      ],
    );
  }
}
