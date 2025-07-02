import 'package:easy_localization/easy_localization.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/strings.dart';
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
    setState(() => _tipIndex = (_tipIndex + 1) % StringManager.warehouseandbarnTips.length);
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
                  ZoneSection(title: StringManager.warehouse.tr(), sensors: [ 
                    {
                      "label": StringManager.temperature.tr(),
                      "value": "${warehouse.temperature}°C",
                      "icon": Icons.thermostat
                    },
                    {
                      "label": StringManager.humidity.tr(),
                      "value": "${warehouse.humidity}%",
                      "icon": Icons.water_drop
                    },
                    {
                      "label": StringManager.gas.tr(),
                      "value": "${warehouse.gasLevel} ppm",
                      "icon": Icons.gas_meter
                    },
                    {
                      "label": StringManager.motion.tr(),
                      "value": warehouse.motionDetected ? StringManager.detected.tr() : StringManager.none.tr(),
                      "icon": Icons.sensors
                    },
                    {
                      "label": StringManager.flame.tr(),
                      "value": warehouse.flameDetected ? StringManager.detected.tr() : StringManager.none.tr(),
                      "icon": Icons.local_fire_department
                    },
                  ]),
                  SizedBox(height: 20.h),
                  ZoneControls(title: StringManager.warehouseControls.tr(), switches: [ 
                    {
                      "label": StringManager.alarm.tr(),
                      "icon": Icons.notifications_active,
                      "controller": _alarm,
                      "subtitle": StringManager.warehouseAlertSystem.tr()
                    },
                    {
                      "label": StringManager.door.tr(),
                      "icon": Icons.door_sliding,
                      "controller": _warehouseDoor,
                      "subtitle": StringManager.mainWarehouseDoor.tr()
                    },
                  ]),
                  SizedBox(height: 24.h),
                  ZoneSection(title: StringManager.barn.tr(), sensors: [ 
                    {
                      "label": StringManager.temperature.tr(),
                      "value": "${barn.temperature}°C",
                      "icon": Icons.thermostat
                    },
                    {
                      "label": StringManager.humidity.tr(),
                      "value": "${barn.humidity}%",
                      "icon": Icons.water_drop
                    },
                    {
                      "label": StringManager.sound.tr(),
                      "value": "${barn.soundLevel} dB",
                      "icon": Icons.speaker
                    },
                    {
                      "label": StringManager.flame.tr(),
                      "value": barn.flameDetected ? StringManager.detected.tr() : StringManager.none.tr(),
                      "icon": Icons.local_fire_department
                    },
                  ]),
                  SizedBox(height: 20.h),
                  ZoneControls(title: StringManager.barnControls.tr(), switches: [
                    {
                      "label": StringManager.fan.tr(),
                      "icon": Icons.ac_unit,
                      "controller": _barnFan,
                      "subtitle": StringManager.ventilationSystem.tr()
                    },
                    {
                      "label": StringManager.door.tr(),
                      "icon": Icons.door_sliding,
                      "controller": _barnDoor,
                      "subtitle": StringManager.barnEntrance.tr()
                    },
                  ]),
                  SizedBox(height: 20.h),
                  TipCard(
                    text: StringManager.warehouseandbarnTips[_tipIndex].tr(), 
                    key: ValueKey(_tipIndex),
                  ),
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