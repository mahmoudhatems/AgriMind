import 'package:easy_localization/easy_localization.dart'; 
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/core/services/notification_service.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/features/home/presentation/widgets/header_row.dart';
import 'package:happyfarm/features/home/presentation/widgets/sensor_grid.dart';
import 'package:happyfarm/features/home/presentation/widgets/parking_section.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';
import 'package:happyfarm/features/home/presentation/widgets/build_status_card.dart';
import 'package:happyfarm/features/settings/presentation/manager/settings_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _gateSwitchController = ValueNotifier<bool>(false);
  int _tipIndex = 0;

  Map<String, dynamic> homeData = {};
  Map<String, dynamic> parkingData = {};
  Map<String, dynamic> systemData = {};

  final _homeRef = FirebaseDatabase.instance.ref('home');
  final _parkingRef = FirebaseDatabase.instance.ref('parking');
  final _systemRef = FirebaseDatabase.instance.ref('system');

  bool _lastFlameAlert = false;
  bool _lastMotionAlert = false;

  @override
  void initState() {
    super.initState();
    _listenToHome();
    _listenToParking();
    _listenToSystem();

    _gateSwitchController.addListener(() {
      FirebaseDatabase.instance.ref("parking").update({
        "gate_status": _gateSwitchController.value,
      });
      HapticFeedback.lightImpact();
    });

    _rotateTip();
  }

  void _listenToHome() {
    _homeRef.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      setState(() => homeData = data);

      final bool isFlameDetected = data['flame_detected'] == true;
      final bool isMotionDetected = data['motion_detected'] == true;

      final notiEnabled = context.read<SettingsCubit>().state.notifications;

      if (notiEnabled) {
        if (isFlameDetected && !_lastFlameAlert) {
          _lastFlameAlert = true;
          NotificationService.showLocalNotification(
            id: 10,
            title: StringManager.flameAlertTitle.tr(),
            body: StringManager.flameAlertBody.tr(),
          );
        } else if (!isFlameDetected) {
          _lastFlameAlert = false;
        }

        if (isMotionDetected && !_lastMotionAlert) {
          _lastMotionAlert = true;
          NotificationService.showLocalNotification(
            id: 11,
            title: StringManager.motionAlertTitle.tr(),
            body: StringManager.motionAlertBody.tr(),
          );
        } else if (!isMotionDetected) {
          _lastMotionAlert = false;
        }
      }
    });
  }

  void _listenToParking() {
    _parkingRef.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      setState(() {
        parkingData = data;
        _gateSwitchController.value = data['gate_status'] ?? false;
      });
    });
  }

  void _listenToSystem() {
    _systemRef.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      setState(() => systemData = data);
    });
  }

  void _rotateTip() {
    if (!mounted) return;
    setState(() => _tipIndex = (_tipIndex + 1) % StringManager.homeTips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final updatedAt = systemData['updated_at'] != null
        ? _formatTime(
              DateTime.fromMillisecondsSinceEpoch(systemData['updated_at']))
        : _formatTime(DateTime.now());

    return Scaffold(
      backgroundColor: ColorsManager.whitegraybackGround.withAlpha(45), 
      body: RefreshIndicator(
        onRefresh: () async {
          HapticFeedback.lightImpact();
          await Future.delayed(const Duration(milliseconds: 800));
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderRow(), 
              SizedBox(height: 20.h),
                StatusCard(
                zoneName: "Zone 1",
                status: systemData['zone1_status'] ?? "Unknown",
                lastUpdate: "$updatedAt ",
              ),
              SizedBox(height: 20.h),
              SensorGrid(homeData: homeData), 
              SizedBox(height: 20.h),
              ParkingSection(     
                parkingData: parkingData,
                gateStatus: _gateSwitchController.value,
                onGateToggle: (val) {
                  FirebaseDatabase.instance.ref("parking").update({
                    "gate_status": val,
                  });
                  _gateSwitchController.value = val;
                  HapticFeedback.lightImpact();
                },
              ),
              SizedBox(height: 20.h),
              TipCard(
                  text: StringManager.homeTips[_tipIndex].tr(),
                  key: ValueKey(_tipIndex)), 
            ],
          ),
        ),
      ),
    );
  }
}