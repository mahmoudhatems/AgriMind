import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter/services.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:happyfarm/features/home/presentation/widgets/glass_card.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _gateSwitchController = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _gateSwitchController.addListener(() => HapticFeedback.lightImpact());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.realWhiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
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
                      value: "No",
                    ).animate().fade().scale(delay: 0.ms),
                    const InfoTile(
                      icon: Icons.speed,
                      label: "Gas",
                      value: "436 ppm",
                    ).animate().fade().scale(delay: 100.ms),
                    const InfoTile(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: "49%",
                    ).animate().fade().scale(delay: 200.ms),
                    const InfoTile(
                      icon: Icons.thermostat,
                      label: "Temp",
                      value: "23.2°C",
                    ).animate().fade().scale(delay: 300.ms),
                    const InfoTile(
                      icon: Icons.visibility,
                      label: "Motion",
                      value: "None",
                    ).animate().fade().scale(delay: 400.ms),
                    const InfoTile(
                      icon: Icons.window,
                      label: "Window",
                      value: "Closed",
                    ).animate().fade().scale(delay: 500.ms),
                  ],
                )
              ],
            ).animate().fade(duration: 600.ms).slideY(begin: 0.1),
            SizedBox(height: 24.h),
            GlassCard(
              title: "Parking Control",
              icon: Icons.local_parking_outlined,
              children: [
                Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  alignment: WrapAlignment.center,
                  children: [
                    const InfoTile(
                      icon: Icons.directions_car,
                      label: "Available",
                      value: "5",
                    ),
                    const InfoTile(
                      icon: Icons.block,
                      label: "Occupied",
                      value: "0",
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildDeviceTile(
                  label: "Gate",
                  isActive: _gateSwitchController.value,
                  iconData: Icons.sensor_door_outlined,
                  subtitle: "Main entrance gate",
                  switchController: _gateSwitchController,
                ),
              ],
            ).animate().fade(duration: 600.ms).slideY(begin: 0.1, delay: 400.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceTile({
    required String label,
    required bool isActive,
    required IconData iconData,
    required ValueNotifier<bool> switchController,
    String? subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isActive
            ? ColorsManager.mainBlueGreenBackGround
            : ColorsManager.textIconColorGray.withAlpha(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: isActive
                      ? ColorsManager.mainBlueGreen.withOpacity(0.15)
                      : Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  size: 22.sp,
                  color: isActive ? ColorsManager.mainBlueGreen : Colors.grey,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Styles.styleText14BlackColofontJosefinSans.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      color: Colors.black87,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          AdvancedSwitch(
            controller: switchController,
            activeColor: ColorsManager.greenColor,
            inactiveColor: ColorsManager.errorColor,
            height: 30.h,
            width: 60.w,
            thumb: ValueListenableBuilder(
              valueListenable: switchController,
              builder: (context, value, child) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    value ? Icons.check_rounded : Icons.close_rounded,
                    color: value
                        ? ColorsManager.greenColor
                        : ColorsManager.errorColor,
                    size: 20.sp,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}