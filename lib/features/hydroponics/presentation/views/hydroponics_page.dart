import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';
import 'package:happyfarm/features/hydroponics/presentation/widgets/gauge_card.dart';

class HydroponicsPage extends StatefulWidget {
  const HydroponicsPage({super.key});

  @override
  State<HydroponicsPage> createState() => _HydroponicsPageState();
}

class _HydroponicsPageState extends State<HydroponicsPage> {
  final _pumpSwitchController = ValueNotifier<bool>(false);

  final double temperature = 29.3;
  final double humidity = 61.3;
  final double phLevel = 7.0;
  final double waterLevel = 23.0;

  int _tipIndex = 0;

  final List<String> _tips = [
    "Ensure the pH level stays between 5.5 - 6.5 for optimal plant health.",
    "Clean and check pump filters weekly to avoid clogs.",
    "Keep water temperature between 18°C - 24°C.",
    "Low water level may damage roots, refill when below 25%.",
    "Use sensors to automate nutrient control and lighting.",
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  void _rotateTip() {
    if (!mounted) return;
    setState(() => _tipIndex = (_tipIndex + 1) % _tips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.lightImpact();
        await Future.delayed(const Duration(milliseconds: 600));
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          children: [
            _buildSensorSection(),
            SizedBox(height: 20.h),
            _buildDeviceControlSection(),
            SizedBox(height: 20.h),
            TipCard(text: _tips[_tipIndex], key: ValueKey(_tipIndex)),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorSection() {
    final sensors = [
      {
        "label": "Humidity",
        "value": humidity,
        "unit": "%",
        "color": Colors.blue,
        "icon": Icons.water_drop
      },
      {
        "label": "Temp",
        "value": temperature,
        "unit": "°C",
        "color": Colors.orange,
        "icon": Icons.thermostat
      },
      {
        "label": "pH Level",
        "value": phLevel * 10,
        "unit": "",
        "color": Colors.purple,
        "icon": Icons.science
      },
      {
        "label": "Water",
        "value": waterLevel,
        "unit": "%",
        "color": Colors.teal,
        "icon": Icons.opacity
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
            Text("Hydroponics Sensors",
                style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 20.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.1,
          children: sensors.map((sensor) {
            return GaugeSensorCard(
              label: sensor['label'] as String,
              value: (sensor['value'] as num).toDouble(),
              unit: sensor['unit'] as String,
              icon: sensor['icon'] as IconData,
              color: sensor['color'] as Color,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDeviceControlSection() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.settings_remote,
                color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text("Device Control",
                style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 16.h),
        SwitchTile(
          label: "Water Pump",
          icon: Icons.water_drop,
          controller: _pumpSwitchController,
        ),
      ],
    );
  }
}
