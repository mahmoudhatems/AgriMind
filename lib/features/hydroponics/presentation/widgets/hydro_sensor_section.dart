import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/hydroponics/presentation/widgets/gauge_card.dart';

class HydroSensorSection extends StatelessWidget {
  final dynamic data;

  const HydroSensorSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final sensors = [
      {
        "label": "Humidity",
        "value": data.humidity,
        "unit": "%",
        "color": ColorsManager.humidityColor,
        "icon": Icons.water_drop
      },
      {
        "label": "Temp",
        "value": data.temperature,
        "unit": "°C",
        "color": ColorsManager.temperatureColor,
        "icon": Icons.thermostat
      },
      {
        "label": "pH Level",
        "value": data.phLevel * 10,
        "unit": "",
        "color": ColorsManager.phLevelColor,
        "icon": Icons.science
      },
      {
        "label": "Water",
        "value": data.waterLevel,
        "unit": "%",
        "color": ColorsManager.waterLevelColor,
        "icon": Icons.opacity
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sensors, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text("Hydroponics Sensors", style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 20.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.1,
          children: sensors.map((sensor) {
            return GaugeSensorCard(
              label: sensor['label'],
              value: (sensor['value'] as num).toDouble(),
              unit: sensor['unit'],
              icon: sensor['icon'],
              color: sensor['color'],
            );
          }).toList(),
        ),
      ],
    );
  }
}
