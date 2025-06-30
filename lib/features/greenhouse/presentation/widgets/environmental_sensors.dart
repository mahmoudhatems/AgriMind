import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';
import 'package:easy_localization/easy_localization.dart'; 
import 'package:happyfarm/core/utils/strings.dart'; 

class SensorSection extends StatelessWidget {
  final GreenhouseEntity data;

  const SensorSection({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final sensors = [
      {
        "label": StringManager.temp.tr(), 
        "value": data.temperature,
        "unit": "°C",
        "color": const Color(0xFFFF6B6B),
        "icon": Icons.thermostat,
      },
      {
        "label": StringManager.humidity.tr(), 
        "value": data.humidity,
        "unit": "%",
        "color": const Color(0xFF4ECDC4),
        "icon": Icons.water_drop,
      },
      {
        "label": StringManager.soil.tr(), 
        "value": data.soilMoisture,
        "unit": "%",
        "color": const Color(0xFF45B7D1),
        "icon": Icons.grass,
      },
      {
        "label": StringManager.gas.tr(), 
        "value": data.gasLevel,
        "unit": "ppm",
        "color": const Color(0xFF96CEB4),
        "icon": Icons.air,
      },
      {
        "label": StringManager.light.tr(), 
        "value": data.lightLevel,
        "unit": "%",
        "color": const Color(0xFFFFD93D),
        "icon": Icons.light_mode,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sensors,
                color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text(StringManager.environmentalSensors.tr(), 
                style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 16.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.1,
          children: sensors.map((sensor) => _buildSensorCard(sensor)).toList(),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildSensorCard(Map<String, dynamic> sensor) {
    final value = (sensor['value'] as num).toDouble();
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: (sensor['color'] as Color).withValues( alpha: 0.1)), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues( alpha:   0.03), 
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: (sensor['color'] as Color).withValues(alpha:   0.1), 
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child:
                    Icon(sensor['icon'], color: sensor['color'], size: 16.sp),
              ),
              Text(sensor['label'] as String, 
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: 90.r,
              height: 98.h,
              child: SfRadialGauge(
                axes: [
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showTicks: false,
                    showLabels: false,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      thicknessUnit: GaugeSizeUnit.factor,
                      color: (sensor['color'] as Color).withValues( alpha:  0.15), 
                    ),
                    pointers: [
                      RangePointer(
                        value: value.clamp(0, 100),
                        width: 0.22,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: sensor['color'],
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: Text(
                          "${value.toStringAsFixed(1)}${sensor['unit']}",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                        positionFactor: 0,
                        angle: 90,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 500.ms);
  }
}