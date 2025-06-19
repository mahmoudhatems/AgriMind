import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/features/greenhouse/domain/entites/greenhouse_entity.dart';
import 'package:happyfarm/features/greenhouse/presentation/manager/greenhouse_cubit.dart';
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

  int _tipIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<GreenhouseCubit>().fetchGreenhouseData();

    _fanSwitchController.addListener(() {
      context.read<GreenhouseCubit>().toggleFan(_fanSwitchController.value);
      HapticFeedback.lightImpact();
    });
    _pumpSwitchController.addListener(() {
      context.read<GreenhouseCubit>().togglePump(_pumpSwitchController.value);
      HapticFeedback.lightImpact();
    });
    _lightSwitchController.addListener(() {
      context.read<GreenhouseCubit>().toggleLight(_lightSwitchController.value);
      HapticFeedback.lightImpact();
    });

    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  void _rotateTip() {
    if (!mounted) return;
    setState(() => _tipIndex = (_tipIndex + 1) % StringManager.homeTips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GreenhouseCubit, GreenhouseState>(
      builder: (context, state) {
        if (state is GreenhouseLoaded) {
          final GreenhouseEntity data = state.data;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _fanSwitchController.value = data.fanStatus;
            _pumpSwitchController.value = data.pumpStatus;
            _lightSwitchController.value = data.lightStatus;
          });

          return RefreshIndicator(
            onRefresh: () async {
              context.read<GreenhouseCubit>().fetchGreenhouseData();
              HapticFeedback.lightImpact();
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  _buildSensorSection(data),
                  SizedBox(height: 20.h),
                  _buildDeviceControlSection(),
                  SizedBox(height: 20.h),
                  TipCard(text: StringManager.homeTips[_tipIndex], key: ValueKey(_tipIndex)),
                ],
              ),
            ),
          );
        } else if (state is GreenhouseError) {
          return Center(
            child: Text(state.message, style: TextStyle(color: Colors.red, fontSize: 16.sp)),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSensorSection(GreenhouseEntity data) {
    final sensors = [
      {"label": "Temp", "value": data.temperature, "unit": "°C", "color": const Color(0xFFFF6B6B), "icon": Icons.thermostat},
      {"label": "Humidity", "value": data.humidity, "unit": "%", "color": const Color(0xFF4ECDC4), "icon": Icons.water_drop},
      {"label": "Soil", "value": data.soilMoisture, "unit": "%", "color": const Color(0xFF45B7D1), "icon": Icons.grass},
      {"label": "Gas", "value": data.gasLevel, "unit": "ppm", "color": const Color(0xFF96CEB4), "icon": Icons.air},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sensors, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text("Environmental Sensors", style: Styles.styleText14BlackColofontJosefinSans),
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
        border: Border.all(color: (sensor['color'] as Color).withValues(alpha:  0.1)),
        boxShadow: [
          BoxShadow(color: ColorsManager.blackTextColor.withValues( alpha:   0.02), blurRadius: 8, offset: Offset(0, 2)),
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
                  color: (sensor['color'] as Color).withValues(alpha: 0.1),
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
                      color: (sensor['color'] as Color).withValues(alpha: 0.15),
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
      {"label": "Ventilation Fan", "icon": Icons.air, "controller": _fanSwitchController},
      {"label": "Water Pump", "icon": Icons.water_drop, "controller": _pumpSwitchController},
      {"label": "LED Lighting", "icon": Icons.light_mode, "controller": _lightSwitchController},
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
          children: devices.map((device) => _buildDeviceControl(device)).toList(),
        ),
      ],
    );
  }

  Widget _buildDeviceControl(Map<String, dynamic> device) {
    return SwitchTile(
      label: device['label'],
      icon: device['icon'],
      controller: device['controller'],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3);
  }
}
