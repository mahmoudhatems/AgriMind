import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GaugeSensorCard extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final IconData icon;
  final Color color;

  const GaugeSensorCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorsManager.realWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(color: ColorsManager.blackTextColor.withValues(alpha: 0.02), blurRadius: 8, offset: Offset(0, 2)),
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
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: color, size: 16.sp),
              ),
              Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: ColorsManager.blackTextColor.withValues(alpha: 0.87))),
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
                      color: color.withValues(alpha: 0.15),
                    ),
                    pointers: [
                      RangePointer(
                        value: value.clamp(0, 100),
                        width: 0.22,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: color,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: Text(
                          "${value.toStringAsFixed(1)}$unit",
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ColorsManager.blackTextColor.withValues(alpha: 0.87)),
                        ),
                        positionFactor: 0.0,
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
    ).animate().scale(delay: 300.ms);
  }
}
