import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    double gaugeMaxValue = 100;
    String valueFormat = '1';

    if (label == "PH Level") {
      gaugeMaxValue = 14;
      valueFormat = '2';
    } else if (label == "Temp") {
      gaugeMaxValue = 40;
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2)),
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
              Text(label,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
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
                    maximum:
                        gaugeMaxValue, 
                    showTicks: false,
                    showLabels: false,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      thicknessUnit: GaugeSizeUnit.factor,
                      color: color.withValues(
                          alpha:
                              0.15), 
                    ),
                    pointers: [
                      RangePointer(
                        value: value.clamp(0,
                            gaugeMaxValue), 
                        width: 0.22,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: color, 
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: Text(
                          "${value.toStringAsFixed(int.parse(valueFormat))}$unit", 
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500, 
                            color:
                                color, 
                          ),
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
