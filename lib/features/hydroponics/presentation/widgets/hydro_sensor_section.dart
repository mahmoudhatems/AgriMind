import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/hydroponics/presentation/widgets/gauge_card.dart';
import 'package:easy_localization/easy_localization.dart'; // Import for .tr()
import 'package:happyfarm/core/utils/strings.dart'; // Import StringManager

class HydroSensorSection extends StatelessWidget {
  final dynamic data; // Assuming data has .humidity, .temperature, .phLevel, .waterLevel properties

  const HydroSensorSection({super.key, required this.data});

  /// Determines a color from the PH spectrum based on the PH value (0-14).
  /// This function simulates the real PH scale colors (red, orange, yellow, green, blue, violet).
  Color _getPhSpectrumColor(double phValue) {
    // Clamp the PH value to be within 0-14 to prevent out-of-range errors.
    final clampedPh = phValue.clamp(0.0, 14.0);

    // Define key colors along the PH scale.
    // These are approximate and can be fine-tuned based on your preference.
    // We'll use a simple linear interpolation between these key points.
    if (clampedPh <= 2.0) { // Deep red for very acidic
      return Color.lerp(Colors.red[900], Colors.red, clampedPh / 2.0) ?? Colors.red;
    } else if (clampedPh <= 4.0) { // Red to Orange
      return Color.lerp(Colors.red, Colors.orange, (clampedPh - 2.0) / 2.0) ?? Colors.orange;
    } else if (clampedPh <= 6.0) { // Orange to Yellow/Lime
      return Color.lerp(Colors.orange, Colors.lime, (clampedPh - 4.0) / 2.0) ?? Colors.lime;
    } else if (clampedPh <= 7.0) { // Yellow/Lime to Green (neutral point)
      return Color.lerp(Colors.lime, Colors.green, (clampedPh - 6.0) / 1.0) ?? Colors.green;
    } else if (clampedPh <= 8.0) { // Green to Teal/Cyan (slightly alkaline)
      return Color.lerp(Colors.green, Colors.teal, (clampedPh - 7.0) / 1.0) ?? Colors.teal;
    } else if (clampedPh <= 10.0) { // Teal/Cyan to Blue
      return Color.lerp(Colors.teal, Colors.blue, (clampedPh - 8.0) / 2.0) ?? Colors.blue;
    } else if (clampedPh <= 12.0) { // Blue to Indigo
      return Color.lerp(Colors.blue, Colors.indigo, (clampedPh - 10.0) / 2.0) ?? Colors.indigo;
    } else { // Indigo to Violet/Purple for very alkaline
      return Color.lerp(Colors.indigo, Colors.purple[800], (clampedPh - 12.0) / 2.0) ?? Colors.purple[800] ?? Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color phDynamicColor = _getPhSpectrumColor(data.phLevel);

    final sensors = [
      {
        "label": StringManager.humidity.tr(), 
        "value": data.humidity,
        "unit": "%",
        "color": Colors.blue, 
        "icon": Icons.water_drop
      },
      {
        "label": StringManager.temp.tr(), 
        "value": data.temperature,
        "unit": "°C",
        "color": Colors.orange,
        "icon": Icons.thermostat
      },
      {
        "label": StringManager.phLevel.tr(), 
        "value": data.phLevel,
        "unit": "",
        "color": phDynamicColor,
        "icon": Icons.science
      },
      {
        "label": StringManager.water.tr(), 
        "value": data.waterLevel,
        "unit": "%",
        "color": Colors.teal,
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
            Text(StringManager.hydroponicsSensors.tr(), style: Styles.styleText14BlackColofontJosefinSans), 
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
              label: sensor['label'] as String,
              value: (sensor['value'] as num).toDouble(),
              unit: sensor['unit'] as String,
              icon: sensor['icon'] as IconData,
              color: sensor['color'] as Color,
            );
          }).toList(),
        ),
      ],
    );
  }
}