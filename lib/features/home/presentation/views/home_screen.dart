import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/build_status_card.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';
import 'package:happyfarm/features/home/presentation/widgets/welcome_text_animated.dart';
import '../widgets/info_tile.dart';

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

    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  void _listenToHome() {
    _homeRef.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      setState(() {
        homeData = data;
      });
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
      setState(() {
        systemData = data;
      });
    });
  }

  void _rotateTip() {
    if (!mounted) return;
    setState(() => _tipIndex = (_tipIndex + 1) % StringManager.homeTips.length);
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  Widget build(BuildContext context) {
  final updatedAt = systemData['updated_at'] != null
    ? _formatTime(DateTime.fromMillisecondsSinceEpoch(systemData['updated_at']))
    : _formatTime(DateTime.now());

    return Scaffold(
      backgroundColor: ColorsManager.whitegraybackGround.withValues( alpha:  0.45),
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
              _buildHeader(),
              SizedBox(height: 20.h),
              StatusCard(
                zoneName: "Zone 1",
                status: systemData['zone1_status'] ?? "Unknown",
                lastUpdate: "$updatedAt ",
              ),
              SizedBox(height: 20.h),
              _buildSensorGrid(),
              SizedBox(height: 20.h),
              _buildParkingSection(),
              SizedBox(height: 20.h),
              TipCard(
                  text: StringManager.homeTips[_tipIndex],
                  key: ValueKey(_tipIndex)),
            ],
          ),
        ),
      ),
    );
  }
Widget _buildHeader() {
  return Row(
    children: [
      Icon(Icons.home_outlined, color: ColorsManager.mainBlueGreen, size: 26.sp),
      SizedBox(width: 8.w),
      const WelcomeText(),
    ],
  ).animate().fade().slideX(begin: -0.1);
}

  Widget _buildSensorGrid() {
    final sensors = [
      {
        "icon": Icons.local_fire_department,
        "label": "Flame",
        "value": (homeData['flame_detected'] == true) ? "Yes" : "No",
      },
      {
        "icon": Icons.speed,
        "label": "Gas",
        "value": "${homeData['gas_level'] ?? "--"} ppm"
      },
      {
        "icon": Icons.water_drop,
        "label": "Humidity",
        "value": "${homeData['humidity'] ?? "--"}%"
      },
      {
        "icon": Icons.thermostat,
        "label": "Temp",
        "value": "${homeData['temperature'] ?? "--"}°C"
      },
      {
        "icon": Icons.visibility,
        "label": "Motion",
        "value": (homeData['motion_detected'] == true) ? "Detected" : "None"
      },
      {
        "icon": Icons.window,
        "label": "Window",
        "value": (homeData['window_status'] == true) ? "Open" : "Closed"
      },
    ];

    return Column(
      children: [
        Row(
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
          children: sensors.map((sensor) {
            return InfoTile(
              icon: sensor['icon'] as IconData,
              label: sensor['label'] as String,
              value: sensor['value'] as String,
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildParkingSection() {
    final available = parkingData['available_spaces']?.toString() ?? '--';
    final occupied = parkingData['occupied_spaces']?.toString() ?? '--';

    return Column(
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
            InfoTile(
                icon: Icons.directions_car,
                label: "Available",
                value: available),
            InfoTile(icon: Icons.block, label: "Occupied", value: occupied),
          ],
        ),
        SizedBox(height: 16.h),
        SwitchTile(
          icon: Icons.sensor_door_outlined,
          label: "Gate",
          subtitle: "Main entrance gate",
          controller: _gateSwitchController,
        ),
      ],
    );
  }

String _formatTime(DateTime dateTime) {
  final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $period';
}

}
