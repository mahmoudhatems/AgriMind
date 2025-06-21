import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';

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
        "label": "Temp",
        "value": data.temperature,
        "unit": "°C",
        "color": ColorsManager.temperatureColor,
        "icon": Icons.thermostat,
      },
      {
        "label": "Humidity",
        "value": data.humidity,
        "unit": "%",
        "color": ColorsManager.humidityColor,
        "icon": Icons.water_drop,
      },
      {
        "label": "Soil",
        "value": data.soilMoisture,
        "unit": "%",
        "color": ColorsManager.soilMoistureColor,
        "icon": Icons.grass,
      },
      {
        "label": "Gas",
        "value": data.gasLevel,
        "unit": "ppm",
        "color": ColorsManager.gasLevelColor,
        "icon": Icons.air,
      },
      {
        "label": "Light",
        "value": data.lightLevel ,
        "unit": "%",
        "color": ColorsManager.lightLevelColor,
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
            Text("Environmental Sensors",
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
        color: ColorsManager.realWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: (sensor['color'] as Color).withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.blackTextColor.withValues(alpha: 0.03),
            blurRadius: 6.r,
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
                  color: (sensor['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child:
                    Icon(sensor['icon'], color: sensor['color'], size: 16.sp),
              ),
              Text(sensor['label'],
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
                      color: (sensor['color'] as Color).withValues(alpha: 0.15),
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
