import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GreenhouseScreen extends StatefulWidget {
  const GreenhouseScreen({super.key});

  @override
  State<GreenhouseScreen> createState() => _GreenhouseScreenState();
}

class _GreenhouseScreenState extends State<GreenhouseScreen> {
  double temperature = 29.6;
  double humidity = 54.7;
  double soilMoisture = 34.5;
  double gasLevel = 43.6;
  double motion = 12.4;

  final _fanSwitchController = ValueNotifier<bool>(false);
  final _pumpSwitchController = ValueNotifier<bool>(false);
  final _lightSwitchController = ValueNotifier<bool>(false);

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
    _fanSwitchController.addListener(() => HapticFeedback.lightImpact());
    _pumpSwitchController.addListener(() => HapticFeedback.lightImpact());
    _lightSwitchController.addListener(() => HapticFeedback.lightImpact());
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
      backgroundColor: ColorsManager.realWhiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            _buildSensorSection(),
            SizedBox(height: 24.h),
            _buildDeviceSection(),
            SizedBox(height: 24.h),
            _buildTipsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorSection() {
    return Container(
      width: double.infinity,
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
              Icon(Icons.sensors, color: ColorsManager.mainBlueGreen, size: 20.sp),
              SizedBox(width: 8.w),
              Text("Environment & Sensors", style: Styles.styleText14BlackColofontJosefinSans),
            ],
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 16.w,
            runSpacing: 16.h,
            alignment: WrapAlignment.center,
            children: [
              _buildGauge("Temp", temperature, "°C", Colors.orange),
              _buildGauge("Humidity", humidity, "%", Colors.blue),
              _buildGauge("Soil", soilMoisture, "%", Colors.green),
              _buildGauge("Gas", gasLevel, "ppm", Colors.red),
              _buildGauge("Motion", motion, "%", Colors.teal),
            ],
          ),
        ],
      ),
    ).animate().fade().slideY(begin: 0.1);
  }

  Widget _buildGauge(String title, double value, String unit, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 24.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(title, style: Styles.styleText14BlackColofontJosefinSans),
          SizedBox(height: 12.h),
          SizedBox(
            height: 140.r,
            width: 140.r,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  showTicks: false,
                  showLabels: false,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.15,
                    thicknessUnit: GaugeSizeUnit.factor,
                    color: color.withOpacity(0.15),
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: value.clamp(0, 100),
                      width: 0.15,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: color,
                      cornerStyle: CornerStyle.bothCurve,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text("${value.toStringAsFixed(1)}$unit",
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      positionFactor: 0.1,
                      angle: 90,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade().scale();
  }

  Widget _buildDeviceSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.settings_remote, color: ColorsManager.mainBlueGreen, size: 20.sp),
              SizedBox(width: 8.w),
              Text("Device Control", style: Styles.styleText14BlackColofontJosefinSans),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDeviceTile("Fan", _fanSwitchController, Icons.air),
          SizedBox(height: 16.h),
          _buildDeviceTile("Pump", _pumpSwitchController, Icons.water_drop),
          SizedBox(height: 16.h),
          _buildDeviceTile("Light", _lightSwitchController, Icons.light_mode),
        ],
      ),
    ).animate().fade().slideY(begin: 0.1);
  }

  Widget _buildDeviceTile(String label, ValueNotifier<bool> controller, IconData icon) {
    final isActive = controller.value;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: isActive ? ColorsManager.mainBlueGreenBackGround : Colors.grey.withAlpha(10),
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
                child: Icon(icon, size: 26.sp, color: isActive ? ColorsManager.mainBlueGreen : Colors.grey),
              ),
              SizedBox(width: 14.w),
              Text(
                label,
                style: Styles.styleText14BlackColofontJosefinSans.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          AdvancedSwitch(
            controller: controller,
            activeColor: ColorsManager.greenColor,
            inactiveColor: ColorsManager.errorColor,
            height: 32.h,
            width: 62.w,
            thumb: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    value ? Icons.check_rounded : Icons.close_rounded,
                    color: value ? ColorsManager.greenColor : ColorsManager.errorColor,
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
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.amber.shade600, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _tips[_tipIndex],
                key: ValueKey(_tipIndex),
                style: Styles.styleText14BlackColofontJosefinSans.copyWith(height: 1.6, fontSize: 13.sp),
              ),
            ),
          )
        ],
      ),
    ).animate().fade(duration: 600.ms).slideY(begin: 0.2);
  }
}