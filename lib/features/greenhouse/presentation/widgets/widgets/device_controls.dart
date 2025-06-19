import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart';

class DeviceControls extends StatelessWidget {
  final ValueNotifier<bool> fanController;
  final ValueNotifier<bool> pumpController;

  const DeviceControls({
    super.key,
    required this.fanController,
    required this.pumpController,
  });

  @override
  Widget build(BuildContext context) {
    final devices = [
      {"label": "Ventilation Fan", "icon": Icons.air, "controller": fanController},
      {"label": "Water Pump", "icon": Icons.water_drop, "controller": pumpController},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.settings_remote, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text("Device Control", style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.center,
          children: devices.map((device) {
            return SwitchTile(
              label: device['label'] as String,
              icon: device['icon'] as IconData,
              controller: device['controller'] as ValueNotifier<bool>,
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2);
          }).toList(),
        ),
      ],
    );
  }
}
