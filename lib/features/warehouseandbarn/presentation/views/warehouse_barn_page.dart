import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';
import 'package:happyfarm/features/warehouseandbarn/presentation/manager/warehouse_cubit.dart';

class WarehouseBarnPage extends StatefulWidget {
  const WarehouseBarnPage({super.key});

  @override
  State<WarehouseBarnPage> createState() => _WarehouseBarnPageState();
}

class _WarehouseBarnPageState extends State<WarehouseBarnPage> {
  final _alarmSwitch = ValueNotifier<bool>(false);
  final _warehouseDoor = ValueNotifier<bool>(false);
  final _barnDoor = ValueNotifier<bool>(false);
  final _barnFan = ValueNotifier<bool>(false);

  int _tipIndex = 0;

  final tips = [
    "Keep barn ventilation active during hot days.",
    "Ensure warehouse alarm is tested weekly.",
    "Low humidity can damage stored materials.",
    "Check flame detectors monthly in both zones."
  ];

  @override
  void initState() {
    super.initState();

    context.read<WarehouseBarnCubit>().fetchData();

    _alarmSwitch.addListener(() {
      context.read<WarehouseBarnCubit>().toggleDevice(
            zone: "warehouse",
            key: "alarm_active",
            value: _alarmSwitch.value,
          );
      HapticFeedback.lightImpact();
    });

    _warehouseDoor.addListener(() {
      context.read<WarehouseBarnCubit>().toggleDevice(
            zone: "warehouse",
            key: "door_status",
            value: _warehouseDoor.value,
          );
      HapticFeedback.lightImpact();
    });

    _barnDoor.addListener(() {
      context.read<WarehouseBarnCubit>().toggleDevice(
            zone: "barn",
            key: "door_status",
            value: _barnDoor.value,
          );
      HapticFeedback.lightImpact();
    });

    _barnFan.addListener(() {
      context.read<WarehouseBarnCubit>().toggleDevice(
            zone: "barn",
            key: "fan_status",
            value: _barnFan.value,
          );
      HapticFeedback.lightImpact();
    });

    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  void _rotateTip() {
    if (!mounted) return;
    setState(() => _tipIndex = (_tipIndex + 1) % tips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WarehouseBarnCubit, WarehouseBarnState>(
      builder: (context, state) {
        if (state is WarehouseBarnLoaded) {
          final warehouse = state.data.warehouse;
          final barn = state.data.barn;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_alarmSwitch.value != warehouse.alarmActive) {
              _alarmSwitch.value = warehouse.alarmActive;
            }
            if (_warehouseDoor.value != warehouse.doorStatus) {
              _warehouseDoor.value = warehouse.doorStatus;
            }
            if (_barnDoor.value != barn.doorStatus) {
              _barnDoor.value = barn.doorStatus;
            }
            if (_barnFan.value != barn.fanStatus) {
              _barnFan.value = barn.fanStatus;
            }
          });

          return RefreshIndicator(
            onRefresh: () async {
              context.read<WarehouseBarnCubit>().fetchData();
              HapticFeedback.lightImpact();
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  _buildSection("Warehouse", [
                    _buildInfo("Temperature", "${warehouse.temperature}°C", Icons.thermostat),
                    _buildInfo("Humidity", "${warehouse.humidity}%", Icons.water_drop),
                    _buildInfo("Gas", "${warehouse.gasLevel} ppm", Icons.gas_meter),
                    _buildInfo("Motion", warehouse.motionDetected ? "Detected" : "None", Icons.sensors),
                    _buildInfo("Flame", warehouse.flameDetected ? "Detected" : "None", Icons.local_fire_department),
                  ]),
                  SizedBox(height: 20.h),
                  _buildControls("Warehouse Controls", [
                    {
                      "label": "Alarm",
                      "icon": Icons.notifications_active,
                      "controller": _alarmSwitch
                    },
                    {
                      "label": "Door",
                      "icon": Icons.door_sliding,
                      "controller": _warehouseDoor
                    },
                  ]),
                  SizedBox(height: 24.h),
                  _buildSection("Barn", [
                    _buildInfo("Temperature", "${barn.temperature}°C", Icons.thermostat),
                    _buildInfo("Humidity", "${barn.humidity}%", Icons.water_drop),
                    _buildInfo("Sound", "${barn.soundLevel} dB", Icons.speaker),
                    _buildInfo("Flame", barn.flameDetected ? "Detected" : "None", Icons.local_fire_department),
                  ]),
                  SizedBox(height: 20.h),
                  _buildControls("Barn Controls", [
                    {
                      "label": "Fan",
                      "icon": Icons.ac_unit,
                      "controller": _barnFan
                    },
                    {
                      "label": "Door",
                      "icon": Icons.door_sliding,
                      "controller": _barnDoor
                    },
                  ]),
                  SizedBox(height: 20.h),
                  TipCard(text: tips[_tipIndex], key: ValueKey(_tipIndex)),
                ],
              ),
            ),
          );
        } else if (state is WarehouseBarnError) {
          return Center(
            child: Text(state.message, style: TextStyle(color: Colors.red)),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSection(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warehouse, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text(title, style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          alignment: WrapAlignment.start,
          children: tiles,
        ),
      ],
    );
  }

  Widget _buildInfo(String label, String value, IconData icon) {
    return InfoTile(icon: icon, label: label, value: value);
  }

  Widget _buildControls(String title, List<Map<String, dynamic>> controls) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.settings, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text(title, style: Styles.styleText14BlackColofontJosefinSans),
          ],
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: controls
              .map((device) => SwitchTile(
                    label: device['label'],
                    icon: device['icon'],
                    controller: device['controller'],
                  ))
              .toList(),
        )
      ],
    );
  }
}
