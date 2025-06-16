import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/data_row.dart';
import 'package:happyfarm/features/home/presentation/widgets/glass_card.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';

class GreenhouseScreen extends StatelessWidget {
  const GreenhouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Static dummy data for UI demo
    final double temperature = 29.6;
    final double humidity = 54.7;
    final double soilMoisture = 0;
    final int gasLevel = 1892;
    final int lightLevel = 0;
    final bool fanStatus = false;
    final bool pumpStatus = false;

    return Container(
      color: ColorsManager.realWhiteColor,
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.fromSTEB(8.w, 8.h, 8.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassCard(
              title: "Environment & Sensors",
              icon: Icons.eco_outlined,
              children: [
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: [
                    InfoTile(
                      icon: Icons.speed,
                      label: "Gas",
                      value: "$gasLevel ppm",
                    ).animate().fade().scale(delay: 100.ms),
                    InfoTile(
                      icon: Icons.wb_sunny_outlined,
                      label: "Light",
                      value: "$lightLevel lux",
                    ).animate().fade().scale(delay: 200.ms),
                    InfoTile(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: "$humidity%",
                    ).animate().fade().scale(delay: 300.ms),
                    InfoTile(
                      icon: Icons.thermostat,
                      label: "Temp",
                      value: "$temperature°C",
                    ).animate().fade().scale(delay: 400.ms),
                    InfoTile(
                      icon: Icons.grass,
                      label: "Soil",
                      value: "$soilMoisture%",
                    ).animate().fade().scale(delay: 500.ms),
                  ],
                )
              ],
            ).animate().fade(duration: 600.ms).slideY(begin: 0.1),
            SizedBox(height: 24.h),
            GlassCard(
              title: "Device Status",
              icon: Icons.settings_input_component_outlined,
              children: [
                DataRowWidget(label: "Fan", value: fanStatus ? "ON" : "OFF"),
                DataRowWidget(label: "Pump", value: pumpStatus ? "ON" : "OFF"),
              ],
            )
                .animate()
                .fade(duration: 600.ms)
                .slideY(begin: 0.1, delay: 400.ms),
          ],
        ),
      ),
    );
  }
}
