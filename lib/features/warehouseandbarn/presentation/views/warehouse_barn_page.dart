import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';
import 'package:happyfarm/features/warehouseandbarn/presentation/manager/warehouse_cubit.dart';
import 'package:happyfarm/features/warehouseandbarn/presentation/widgets/zone_section.dart';
import 'package:happyfarm/features/warehouseandbarn/presentation/widgets/zone_controls.dart';

class WarehouseBarnPage extends StatefulWidget {
  const WarehouseBarnPage({super.key});

  @override
  State<WarehouseBarnPage> createState() => _WarehouseBarnPageState();
}

class _WarehouseBarnPageState extends State<WarehouseBarnPage> {
  final _alarm = ValueNotifier(false);
  final _warehouseDoor = ValueNotifier(false);
  final _barnDoor = ValueNotifier(false);
  final _barnFan = ValueNotifier(false);
  int _tipIndex = 0;
  bool _syncedOnce = false;

  final tips = [
    "Keep barn ventilation active during hot days.",
    "Ensure warehouse alarm is tested weekly.",
    "Low humidity can damage stored materials.",
    "Check flame detectors monthly in both zones."
  ];

  @override
  void initState() {
    super.initState();

    _alarm.addListener(() {
      context.read<WarehouseBarnCubit>().toggleDevice(
            zone: "warehouse",
            key: "alarm_active",
            value: _alarm.value,
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

          if (!_syncedOnce) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _alarm.value = warehouse.alarmActive;
              _warehouseDoor.value = warehouse.doorStatus;
              _barnDoor.value = barn.doorStatus;
              _barnFan.value = barn.fanStatus;
              _syncedOnce = true;
            });
          }

          return RefreshIndicator(
            onRefresh: () async {
         
              HapticFeedback.lightImpact();
              await Future.delayed(const Duration(milliseconds: 600));
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                children: [
                  ZoneSection(title: "Warehouse", sensors: [
                    {
                      "label": "Temperature",
                      "value": "${warehouse.temperature}°C",
                      "icon": Icons.thermostat
                    },
                    {
                      "label": "Humidity",
                      "value": "${warehouse.humidity}%",
                      "icon": Icons.water_drop
                    },
                    {
                      "label": "Gas",
                      "value": "${warehouse.gasLevel} ppm",
                      "icon": Icons.gas_meter
                    },
                    {
                      "label": "Motion",
                      "value": warehouse.motionDetected ? "Detected" : "None",
                      "icon": Icons.sensors
                    },
                    {
                      "label": "Flame",
                      "value": warehouse.flameDetected ? "Detected" : "None",
                      "icon": Icons.local_fire_department
                    },
                  ]),
                  SizedBox(height: 20.h),
                  ZoneControls(title: "Warehouse Controls", switches: [
                    {
                      "label": "Alarm",
                      "icon": Icons.notifications_active,
                      "controller": _alarm,
                      "subtitle": "Warehouse alert system"
                    },
                    {
                      "label": "Door",
                      "icon": Icons.door_sliding,
                      "controller": _warehouseDoor,
                      "subtitle": "Main warehouse door"
                    },
                  ]),
                  SizedBox(height: 24.h),
                  ZoneSection(title: "Barn", sensors: [
                    {
                      "label": "Temperature",
                      "value": "${barn.temperature}°C",
                      "icon": Icons.thermostat
                    },
                    {
                      "label": "Humidity",
                      "value": "${barn.humidity}%",
                      "icon": Icons.water_drop
                    },
                    {
                      "label": "Sound",
                      "value": "${barn.soundLevel} dB",
                      "icon": Icons.speaker
                    },
                    {
                      "label": "Flame",
                      "value": barn.flameDetected ? "Detected" : "None",
                      "icon": Icons.local_fire_department
                    },
                  ]),
                  SizedBox(height: 20.h),
                  ZoneControls(title: "Barn Controls", switches: [
                    {
                      "label": "Fan",
                      "icon": Icons.ac_unit,
                      "controller": _barnFan,
                      "subtitle": "Ventilation system"
                    },
                    {
                      "label": "Door",
                      "icon": Icons.door_sliding,
                      "controller": _barnDoor,
                      "subtitle": "Barn entrance"
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
              child: Text(state.message, style: TextStyle(color: Colors.red)));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
