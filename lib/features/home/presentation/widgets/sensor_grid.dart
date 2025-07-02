import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';
import 'package:easy_localization/easy_localization.dart'; // Import for .tr()
import 'package:happyfarm/core/utils/strings.dart'; // Import StringManager

class SensorGrid extends StatelessWidget {
  final Map<String, dynamic> homeData;

  const SensorGrid({super.key, required this.homeData});

  @override
  Widget build(BuildContext context) {
    final sensors = [
      {
        "icon": Icons.local_fire_department,
        "label": StringManager.flame.tr(), // Localized
        "value": (homeData['flame_detected'] == true) ? StringManager.yes.tr() : StringManager.no.tr(), // Localized
      },
      {
        "icon": Icons.speed,
        "label": StringManager.gas.tr(), // Localized
        "value": "${homeData['gas_level'] ?? "--"} ppm"
      },
      {
        "icon": Icons.water_drop,
        "label": StringManager.humidity.tr(), // Localized
        "value": "${homeData['humidity'] ?? "--"}%"
      },
      {
        "icon": Icons.thermostat,
        "label": StringManager.temp.tr(), // Localized
        "value": "${homeData['temperature'] ?? "--"}°C"
      },
      {
        "icon": Icons.visibility,
        "label": StringManager.motion.tr(), // Localized
        "value": (homeData['motion_detected'] == true) ? StringManager.detected.tr() : StringManager.none.tr(), // Localized
      },
      {
        "icon": Icons.window,
        "label": StringManager.window.tr(), // Localized
        "value": (homeData['window_status'] == true) ? StringManager.open.tr() : StringManager.closed.tr(), // Localized
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sensors, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text(StringManager.environmentSensors.tr(), style: Styles.styleText14BlackColofontJosefinSans), 
          ],
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.center,
          children: sensors.map((sensor) {
            return InfoTile(
              icon: sensor['icon'] as IconData,
              label: sensor['label'] as String,
              value: sensor['value'] as String,
            );
          }).toList(),
        )
      ],
    );
  }
}