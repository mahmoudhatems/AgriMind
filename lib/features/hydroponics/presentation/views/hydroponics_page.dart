import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class HydroponicsPage extends StatefulWidget {
  const HydroponicsPage({super.key});

  @override
  State<HydroponicsPage> createState() => _HydroponicsPageState();
}

class _HydroponicsPageState extends State<HydroponicsPage> {
  double humidity = 61.3;
  double phLevel = 7.0;
  bool pumpStatus = false;
  double temperature = 29.3;
  int waterLevel = 23;

  final _pumpSwitchController = ValueNotifier<bool>(false);
  final List<String> _tips = [
    "Ensure the pH level stays between 5.5 - 6.5 for optimal plant health.",
    "Clean and check pump filters weekly to avoid clogs.",
    "Keep water temperature between 18°C - 24°C.",
    "Low water level may damage roots, refill when below 25%.",
    "Use sensors to automate nutrient control and lighting."
  ];
  int _tipIndex = 0;

  @override
  void initState() {
    super.initState();
    _pumpSwitchController.value = pumpStatus;
    _pumpSwitchController.addListener(() {
      setState(() {
        pumpStatus = _pumpSwitchController.value;
      });
    });
    Timer.periodic(const Duration(seconds: 6), (timer) {
      if (mounted) {
        setState(() {
          _tipIndex = (_tipIndex + 1) % _tips.length;
        });
      }
    });
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
          
            SizedBox(height: 24.h),

            _buildGaugeGrid(
              humidity: humidity,
              temperature: temperature,
              phLevel: phLevel,
              waterLevel: waterLevel.toDouble(),
            ),

            SizedBox(height: 32.h),
            _buildSwitchTile(),
            SizedBox(height: 24.h),
            _buildAlerts(),

            SizedBox(height: 24.h),
            Container(
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
            ).animate().fade(duration: 600.ms).slideY(begin: 0.2),
          ],
        ),
      ),
    );
  }

  Widget _buildAlerts() {
    List<Map<String, dynamic>> alerts = [];
    if (humidity > 60) alerts.add({"text": "High Humidity: $humidity%", "color": Colors.orange});
    if (temperature > 30) alerts.add({"text": "High Temperature: $temperature°C", "color": Colors.deepOrange});
    if (waterLevel < 20) alerts.add({"text": "Low Water Level: $waterLevel%", "color": Colors.redAccent});

    if (alerts.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade100, Colors.red.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 20.sp),
              SizedBox(width: 8.w),
              Text("System Alerts", style: TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8.h),
          ...alerts.map((e) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: e["color"], size: 18.sp),
                    SizedBox(width: 8.w),
                    Expanded(child: Text(e["text"], style: TextStyle(color: e["color"], fontSize: 13.sp)))
                  ],
                ),
              ))
        ],
      ),
    ).animate().fade().slideY();
  }

  Widget _buildSwitchTile() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: pumpStatus ? ColorsManager.mainBlueGreenBackGround : Colors.grey.withOpacity(0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: pumpStatus
                      ? ColorsManager.greenColor.withOpacity(0.15)
                      : ColorsManager.errorColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.water_drop,
                    color: pumpStatus ? ColorsManager.greenColor : ColorsManager.errorColor, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                pumpStatus ? "Pump: ON" : "Pump: OFF",
                style: Styles.styleText14BlackColofontJosefinSans.copyWith(
                  fontWeight: FontWeight.w600,
                  color: pumpStatus ? ColorsManager.greenColor : ColorsManager.errorColor,
                ),
              ),
            ],
          ),
          AdvancedSwitch(
            controller: _pumpSwitchController,
            activeColor: ColorsManager.greenColor,
            inactiveColor: ColorsManager.errorColor,
            height: 30.h,
            width: 60.w,
            thumb: ValueListenableBuilder(
              valueListenable: _pumpSwitchController,
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
          )
        ],
      ),
    ).animate().fade().scale();
  }

  Widget _buildGaugeGrid({
    required double humidity,
    required double temperature,
    required double phLevel,
    required double waterLevel,
  }) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 16.h,
      alignment: WrapAlignment.center,
      children: [
        _buildGaugeCard("Humidity", humidity, "%", Colors.blue),
        _buildGaugeCard("Temp", temperature, "°C", Colors.orange),
        _buildGaugeCard("pH Level", phLevel, "", Colors.purple),
        _buildGaugeCard("Water Level", waterLevel, "%", Colors.teal),
      ],
    );
  }

  Widget _buildGaugeCard(String title, double value, String unit, Color color) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Text(title, style: Styles.styleText14BlackColofontJosefinSans),
          SizedBox(height: 8.h),
          SizedBox(
            height: 120.r,
            width: 120.r,
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
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${value.toStringAsFixed(1)}$unit",
                              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                        ],
                      ),
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
}
