import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter/services.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/glass_card.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';

class GreenhouseScreen extends StatefulWidget {
  const GreenhouseScreen({super.key});

  @override
  State<GreenhouseScreen> createState() => _GreenhouseScreenState();
}

class _GreenhouseScreenState extends State<GreenhouseScreen>
    with TickerProviderStateMixin {
  double temperature = 29.6;
  double humidity = 54.7;
  double soilMoisture = 0;
  int gasLevel = 1892;
  int lightLevel = 0;

  final _fanSwitchController = ValueNotifier<bool>(false);
  final _pumpSwitchController = ValueNotifier<bool>(false);
  final _lightSwitchController = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _fanSwitchController.addListener(() => _handleSwitchFeedback());
    _pumpSwitchController.addListener(() => _handleSwitchFeedback());
    _lightSwitchController.addListener(() {
      _handleSwitchFeedback();
      setState(() {
        lightLevel = _lightSwitchController.value ? 100 : 0;
      });
    });
  }

  void _handleSwitchFeedback() {
    HapticFeedback.lightImpact();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.realWhiteColor,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
  
              GlassCard(
                title: "Environment & Sensors",
                icon: Icons.eco_outlined,
                children: [
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    alignment: WrapAlignment.center,
                    children: [
                      InfoTile(
                        icon: Icons.speed,
                        label: "Gas",
                        value: "$gasLevel ppm",
                      ),
                      InfoTile(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        value: "$humidity%",
                      ),
                      InfoTile(
                        icon: Icons.thermostat,
                        label: "Temp",
                        value: "$temperature°C",
                      ),
                      InfoTile(
                        icon: Icons.grass,
                        label: "Soil",
                        value: "$soilMoisture%",
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 24.h),
              GlassCard(
                title: "Device Control",
                icon: Icons.settings_remote,
                children: [
                  _buildDeviceTile(
                    label: "Fan",
                    isActive: _fanSwitchController.value,
                    iconData: Icons.air,
                    switchController: _fanSwitchController,
                  ),
                  SizedBox(height: 16.h),
                  _buildDeviceTile(
                    label: "Pump",
                    isActive: _pumpSwitchController.value,
                    iconData: Icons.water_drop,
                    switchController: _pumpSwitchController,
                  ),
                  SizedBox(height: 16.h),
                  _buildDeviceTile(
                    label: "Light",
                    isActive: _lightSwitchController.value,
                    iconData: Icons.light_mode,
                    switchController: _lightSwitchController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceTile({
    required String label,
    required bool isActive,
    required IconData iconData,
    required ValueNotifier<bool> switchController,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      margin: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isActive
            ? ColorsManager.mainBlueGreenBackGround
            : ColorsManager.textIconColorGray.withValues( alpha:  0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: isActive
                      ? ColorsManager.mainBlueGreen.withOpacity(0.15)
                      : Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  size: 22.sp,
                  color:
                      isActive ? ColorsManager.mainBlueGreen : Colors.grey,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                label,
                style: Styles.styleText14BlackColofontJosefinSans.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          AdvancedSwitch(
            controller: switchController,
            activeColor: ColorsManager.greenColor,
            inactiveColor: ColorsManager.errorColor,
            height: 30.h,
            width: 60.w,
            thumb: ValueListenableBuilder(
              valueListenable: switchController,
              builder: (context, value, child) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    value ? Icons.check_rounded : Icons.close_rounded,
                    color: value
                        ? ColorsManager.greenColor
                        : ColorsManager.errorColor,
                    size: 20.sp,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
