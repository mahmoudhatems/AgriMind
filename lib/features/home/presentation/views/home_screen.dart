import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:happyfarm/features/home/presentation/widgets/data_row.dart';
import 'package:happyfarm/features/home/presentation/widgets/glass_card.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGateOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.realWhiteColor,
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.fromSTEB(8.w, 8.h, 8.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome to Happy Farm 👋',
                  textStyle: Styles.styleBoldText20GrayfontJosefinSans,
                  speed: const Duration(milliseconds: 80),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 300),
              displayFullTextOnTap: true,
            ),
            SizedBox(height: 24.h),

            // Environment & Sensors Card with Animation
            GlassCard(
              title: "Environment & Sensors",
              icon: Icons.sensors_outlined,
              children: [
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const InfoTile(
                            icon: Icons.local_fire_department,
                            label: "Flame",
                            value: "No")
                        .animate()
                        .fade()
                        .scale(delay: 0.ms),
                    const InfoTile(
                            icon: Icons.speed, label: "Gas", value: "436 ppm")
                        .animate()
                        .fade()
                        .scale(delay: 100.ms),
                    const InfoTile(
                            icon: Icons.water_drop,
                            label: "Humidity",
                            value: "49%")
                        .animate()
                        .fade()
                        .scale(delay: 200.ms),
                    const InfoTile(
                            icon: Icons.thermostat,
                            label: "Temp",
                            value: "23.2°C")
                        .animate()
                        .fade()
                        .scale(delay: 300.ms),
                    const InfoTile(
                            icon: Icons.visibility,
                            label: "Motion",
                            value: "None")
                        .animate()
                        .fade()
                        .scale(delay: 400.ms),
                    const InfoTile(
                            icon: Icons.window,
                            label: "Window",
                            value: "Closed")
                        .animate()
                        .fade()
                        .scale(delay: 500.ms),
                  ],
                )
              ],
            )
                .animate()
                .fade(duration: 600.ms)
                .slideY(begin: 0.1, duration: 600.ms),
            // Parking Card with Animation
            GlassCard(
              title: "Parking Control",
              icon: Icons.local_parking_outlined,
              children: [
                 DataRowWidget(label: "Available", value: "5"),
                 DataRowWidget(label: "Occupied", value: "0"),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Gate Status",
                        style: Styles.styleText14BlackColofontJosefinSans),
                    FlutterSwitch(
                      width: 60.w,
                      height: 28.h,
                      value: isGateOpen,
                      activeText: "Open",
                      inactiveText: "Closed",
                      showOnOff: true,
                      activeColor: ColorsManager.greenColor,
                      inactiveColor: ColorsManager.errorColor,
                      onToggle: (val) {
                        setState(() {
                          isGateOpen = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            )
                .animate()
                .fade(duration: 600.ms)
                .slideY(begin: 0.1, duration: 600.ms, delay: 400.ms),
          ],
        ),
      ),
    );
  }
}

