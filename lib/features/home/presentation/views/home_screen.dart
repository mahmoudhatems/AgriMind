import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _gateSwitchController = ValueNotifier<bool>(false);
  final List<String> _tips = [
    "Keep barn temperature stable for better animal comfort.",
    "Check sensor calibration weekly to avoid false alerts.",
    "Automate irrigation during early morning hours.",
    "Clean barn windows regularly to maintain lighting.",
    "Keep pests away by monitoring motion sensors near feed storage."
  ];
  int _tipIndex = 0;

  @override
  void initState() {
    super.initState();
    _gateSwitchController.addListener(() => HapticFeedback.lightImpact());
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  void _rotateTip() {
    if (!mounted) return;
    setState(() => _tipIndex = (_tipIndex + 1) % _tips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whitegraybackGround.withValues(alpha: 0.45),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.home_outlined,
                    color: ColorsManager.mainBlueGreen, size: 26.sp),
                SizedBox(width: 8.w),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Welcome to Happy Farm',
                      speed: const Duration(milliseconds: 70),
                      textStyle: Styles.styleBoldText20GrayfontJosefinSans
                          .copyWith(fontSize: 22.sp),
                    ),
                  ],
                ),
              ],
            ).animate().fade().slideX(begin: -0.1),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.sensors,
                          color: ColorsManager.mainBlueGreen, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text("Environment & Sensors",
                          style: Styles.styleText14BlackColofontJosefinSans),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 16.w,
                    runSpacing: 16.h,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildSensorTile(
                          Icons.local_fire_department, "Flame", "No"),
                      _buildSensorTile(Icons.speed, "Gas", "436 ppm"),
                      _buildSensorTile(Icons.water_drop, "Humidity", "49%"),
                      _buildSensorTile(Icons.thermostat, "Temp", "23.2°C"),
                      _buildSensorTile(Icons.visibility, "Motion", "None"),
                      _buildSensorTile(Icons.window, "Window", "Closed"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_parking_outlined,
                          color: ColorsManager.mainBlueGreen, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text("Parking Control",
                          style: Styles.styleText14BlackColofontJosefinSans),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 16.w,
                    runSpacing: 16.h,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildSensorTile(Icons.directions_car, "Available", "5"),
                      _buildSensorTile(Icons.block, "Occupied", "0"),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildDeviceTile(
                      "Gate", _gateSwitchController, Icons.sensor_door_outlined,
                      subtitle: "Main entrance gate"),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            _buildTipsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorTile(IconData icon, String label, String value) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 30.sp, color: ColorsManager.mainBlueGreen),
          SizedBox(height: 8.h),
          Text(label,
              style: Styles.styleText14BlackColofontJosefinSans
                  .copyWith(fontSize: 14.sp)),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildDeviceTile(
      String label, ValueNotifier<bool> switchController, IconData iconData,
      {String? subtitle}) {
    final isActive = switchController.value;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: isActive
            ? ColorsManager.mainBlueGreenBackGround
            : Colors.grey.withAlpha(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: isActive
                      ? ColorsManager.mainBlueGreen.withOpacity(0.15)
                      : Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData,
                    size: 26.sp,
                    color:
                        isActive ? ColorsManager.mainBlueGreen : Colors.grey),
              ),
              SizedBox(width: 14.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Styles.styleText14BlackColofontJosefinSans.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: Colors.black87,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey),
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
            height: 32.h,
            width: 62.w,
            thumb: ValueListenableBuilder(
              valueListenable: switchController,
              builder: (context, value, child) {
                return Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
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
    ).animate().fade().scale();
  }

  Widget _buildTipsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline,
              color: Colors.amber.shade600, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _tips[_tipIndex],
                key: ValueKey(_tipIndex),
                style: Styles.styleText14BlackColofontJosefinSans
                    .copyWith(height: 1.6, fontSize: 13.sp),
              ),
            ),
          )
        ],
      ),
    ).animate().fade(duration: 600.ms).slideY(begin: 0.2);
  }
}
