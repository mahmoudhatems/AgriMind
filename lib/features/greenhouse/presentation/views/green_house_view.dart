import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GreenhouseScreen extends StatefulWidget {
  const GreenhouseScreen({super.key});

  @override
  State<GreenhouseScreen> createState() => _GreenhouseScreenState();
}

class _GreenhouseScreenState extends State<GreenhouseScreen> {
  final _fanSwitchController = ValueNotifier<bool>(false);
  final _pumpSwitchController = ValueNotifier<bool>(false);
  final _lightSwitchController = ValueNotifier<bool>(false);

  final double temperature = 29.6;
  final double humidity = 54.7;
  final double soilMoisture = 34.5;
  final double gasLevel = 43.6;
  final double motion = 12.4;

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
    setState(() => _tipIndex = (_tipIndex + 1) % StringManager.homeTips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  Widget build(BuildContext context) {
    return  RefreshIndicator(
        onRefresh: () async {
          HapticFeedback.lightImpact();
          await Future.delayed(const Duration(milliseconds: 800));
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              _buildSensorSection(),
              SizedBox(height: 20.h),
              _buildDeviceControlSection(),
              SizedBox(height: 20.h),
              TipCard(text: StringManager.homeTips[_tipIndex], key: ValueKey(_tipIndex)),
            ],
          ),
        ),
      );
    
  }

 

  Widget _buildSensorSection() {
    final sensors = [
      {"label": "Temp", "value": temperature, "unit": "°C", "color": const Color(0xFFFF6B6B), "icon": Icons.thermostat},
      {"label": "Humidity", "value": humidity, "unit": "%", "color": const Color(0xFF4ECDC4), "icon": Icons.water_drop},
      {"label": "Soil", "value": soilMoisture, "unit": "%", "color": const Color(0xFF45B7D1), "icon": Icons.grass},
      {"label": "Gas", "value": gasLevel, "unit": "ppm", "color": const Color(0xFF96CEB4), "icon": Icons.air},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sensors, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text("Environmental Sensors", style:  Styles.styleText14BlackColofontJosefinSans),
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
          children: sensors.map((sensor) => _buildSensorCard(sensor)).toList(),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms);
  }

  Widget _buildSensorCard(Map<String, dynamic> sensor) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: (sensor['color'] as Color).withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: Offset(0, 2)),
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
                  color: (sensor['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(sensor['icon'], color: sensor['color'], size: 16.sp),
              ),
              Text(sensor['label'], style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
            ],
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: SizedBox(
              width: 90.r,
              height: 90.r,
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
                      color: (sensor['color'] as Color).withOpacity(0.15),
                    ),
                    pointers: [
                      RangePointer(
                        value: (sensor['value'] as double).clamp(0, 100),
                        width: 0.23,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: sensor['color'],
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: Text(
                          "${(sensor['value'] as double).toStringAsFixed(1)}${sensor['unit']}",
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                        positionFactor: 0.1,
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

  Widget _buildDeviceControlSection() {
    final devices = [
      {"label": "Ventilation Fan", "icon": Icons.air, "controller": _fanSwitchController, "color": const Color(0xFF4ECDC4)},
      {"label": "Water Pump", "icon": Icons.water_drop, "controller": _pumpSwitchController, "color": const Color(0xFF45B7D1)},
      {"label": "LED Lighting", "icon": Icons.light_mode, "controller": _lightSwitchController, "color": const Color(0xFFFECEA8)},
    ];

    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.settings_remote, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text("Device Control", style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.center,
          children:  [
            ...devices.map((device) => _buildDeviceControl(device)).toList(),
          ],
        ),
        
      ],
    );
  }



 




 Widget _buildDeviceControl(Map<String, dynamic> device) {
  return SwitchTile(
    label: device['label'],
    icon: device['icon'],
    controller: device['controller'], // ✅ تمرير الكونترولر
  ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3);
}

}