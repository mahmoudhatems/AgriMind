import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/build_status_card.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart';
import 'package:happyfarm/features/home/presentation/widgets/tip_card.dart';
import '../widgets/info_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _gateSwitchController = ValueNotifier<bool>(false);

  
  int _tipIndex = 0;

  @override
  void initState() {
    super.initState();
    _gateSwitchController.addListener(() => HapticFeedback.lightImpact());
    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  void _rotateTip() {
    if (!mounted) return;
   setState(() => _tipIndex = ((_tipIndex + 1) % StringManager.homeTips.length).toInt());

    Future.delayed(const Duration(seconds: 6), _rotateTip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whitegraybackGround.withOpacity(0.45),
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
              BuildStatusCard(),
               SizedBox(height: 20.h),
              _buildSensorGrid(),
             SizedBox(height: 20.h),
              _buildParkingSection(),
              SizedBox(height: 20.h),
            TipCard(text: StringManager.homeTips[_tipIndex], key: ValueKey(_tipIndex)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.home_outlined,
            color: ColorsManager.mainBlueGreen, size: 26.sp),
        SizedBox(width: 8.w),
        AnimatedTextKit(
          isRepeatingAnimation: false,
          totalRepeatCount: 1,
          animatedTexts: [
            TypewriterAnimatedText(
              StringManager.welcomeText,
              speed: const Duration(milliseconds: 70),
              textStyle: Styles.styleBoldText20GrayfontJosefinSans
                  .copyWith(fontSize: 22.sp),
            ),
          ],
        ),
      ],
    ).animate().fade().slideX(begin: -0.1);
  }

  Widget _buildSensorGrid() {
    final sensorItems = [
      {"icon": Icons.local_fire_department, "label": "Flame", "value": "No"},
      {"icon": Icons.speed, "label": "Gas", "value": "436 ppm"},
      {"icon": Icons.water_drop, "label": "Humidity", "value": "49%"},
      {"icon": Icons.thermostat, "label": "Temp", "value": "23.2°C"},
      {"icon": Icons.visibility, "label": "Motion", "value": "None"},
      {"icon": Icons.window, "label": "Window", "value": "Closed"},
    ];
    return Container(
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
            children: sensorItems.map((item) {
              return InfoTile(
                icon: item['icon'] as IconData,
                label: item['label'] as String,
                value: item['value'] as String,
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildParkingSection() {
    return Container(
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
            children: const [
              InfoTile(
                  icon: Icons.directions_car, label: "Available", value: "5"),
              InfoTile(icon: Icons.block, label: "Occupied", value: "0"),
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
      ),
    );
  }
}
