import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';

class SensorGrid extends StatelessWidget {
  final Map<String, dynamic> homeData;

  const SensorGrid({super.key, required this.homeData});

  @override
  Widget build(BuildContext context) {
    final sensors = [
      {
        "icon": Icons.local_fire_department,
        "label": "Flame",
        "value": (homeData['flame_detected'] == true) ? "Yes" : "No",
      },
      {
        "icon": Icons.speed,
        "label": "Gas",
        "value": "${homeData['gas_level'] ?? "--"} ppm"
      },
      {
        "icon": Icons.water_drop,
        "label": "Humidity",
        "value": "${homeData['humidity'] ?? "--"}%"
      },
      {
        "icon": Icons.thermostat,
        "label": "Temp",
        "value": "${homeData['temperature'] ?? "--"}°C"
      },
      {
        "icon": Icons.visibility,
        "label": "Motion",
        "value": (homeData['motion_detected'] == true) ? "Detected" : "None"
      },
      {
        "icon": Icons.window,
        "label": "Window",
        "value": (homeData['window_status'] == true) ? "Open" : "Closed"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sensors, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text("Environment & Sensors", style: Styles.styleText14BlackColofontJosefinSans),
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
