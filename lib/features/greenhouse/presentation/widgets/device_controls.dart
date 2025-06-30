import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart'; 
import 'package:easy_localization/easy_localization.dart'; 
import 'package:happyfarm/core/utils/strings.dart'; 

class DeviceControls extends StatelessWidget {
  final bool fanValue;
  final bool pumpValue;
  final ValueChanged<bool> onFanChanged;
  final ValueChanged<bool> onPumpChanged;

  const DeviceControls({
    super.key,
    required this.fanValue,
    required this.pumpValue,
    required this.onFanChanged,
    required this.onPumpChanged,
  });

  @override
  Widget build(BuildContext context) {
    final devices = [
      {
        "label": StringManager.ventilationFan.tr(), 
        "icon": Icons.air,
        "value": fanValue,
        "onChanged": onFanChanged,
        "subtitle": StringManager.controlsAirCirculation.tr() 
      },
      {
        "label": StringManager.waterPump.tr(), 
        "icon": Icons.water_drop,
        "value": pumpValue,
        "onChanged": onPumpChanged,
        "subtitle": StringManager.controlsWaterFlow.tr() 
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.settings_remote, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text(StringManager.deviceControl.tr(), style: Styles.styleText14BlackColofontJosefinSans), // Localized
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
              value: device['value'] as bool,
              subtitle: device['subtitle'] as String,
              onChanged: device['onChanged'] as ValueChanged<bool>,
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2);
          }).toList(),
        ),
      ],
    );
  }
}