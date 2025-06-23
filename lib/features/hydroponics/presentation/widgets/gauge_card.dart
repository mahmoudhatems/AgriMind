// lib/features/hydroponics/presentation/widgets/gauge_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:happyfarm/core/utils/colors.dart'; // Ensure ColorsManager is imported

class GaugeSensorCard extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final IconData icon;
  final Color color; // This color will now be dynamically passed for PH and other sensors

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
    // Determine the maximum value for the gauge based on the sensor type
    double gaugeMaxValue = 100; // Default max for humidity, water level
    String valueFormat = '1'; // Default to 1 decimal place

    if (label == "PH Level") {
      gaugeMaxValue = 14; // PH scale is 0-14
      valueFormat = '2'; // PH typically requires 2 decimal places for precision
    } else if (label == "Temp") {
      gaugeMaxValue = 40; // Assuming typical max temp for hydroponics, adjust as needed
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        // Use the dynamically passed `color` with opacity for the border
        border: Border.all(color: color.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
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
                  // Use the dynamically passed `color` with opacity for the icon background
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: color, size: 16.sp), // Icon uses the dynamic color
              ),
              // Label text remains a standard dark color for contrast/readability across different sensor colors.
              Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
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
                    maximum: gaugeMaxValue, // Dynamic max value based on sensor type
                    showTicks: false,
                    showLabels: false,
                    axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      thicknessUnit: GaugeSizeUnit.factor,
                      color: color.withOpacity(0.15), // Gauge background line uses dynamic color
                    ),
                    pointers: [
                      RangePointer(
                        value: value.clamp(0, gaugeMaxValue), // Clamp value within gauge's min/max
                        width: 0.22,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: color, // Gauge pointer uses dynamic color
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: Text(
                          "${value.toStringAsFixed(int.parse(valueFormat))}$unit", // Dynamic decimal places
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500, // Slightly bolder
                            color: color, // **This text now uses the dynamic color!**
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