import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart';
import 'package:easy_localization/easy_localization.dart'; // Import for .tr()
import 'package:happyfarm/core/utils/strings.dart'; // Import StringManager

class ParkingSection extends StatelessWidget {
  final Map<String, dynamic> parkingData;
  final bool gateStatus;
  final ValueChanged<bool> onGateToggle;

  const ParkingSection({
    super.key,
    required this.parkingData,
    required this.gateStatus,
    required this.onGateToggle,
  });

  @override
  Widget build(BuildContext context) {
    final available = parkingData['available_spaces']?.toString() ?? '--';
    final occupied = parkingData['occupied_spaces']?.toString() ?? '--';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.local_parking_outlined,
                color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text(StringManager.parkingControl.tr(), // Localized
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
                label: StringManager.available.tr(), // Localized
                value: available),
            InfoTile(icon: Icons.block, label: StringManager.occupied.tr(), value: occupied), // Localized
          ],
        ),
        SizedBox(height: 16.h),
        SwitchTile(
          icon: Icons.sensor_door_outlined,
          label: StringManager.gate.tr(), // Localized
          subtitle: StringManager.openEntranceGate.tr(), // Localized
          value: gateStatus,
          onChanged: onGateToggle,
        ),
      ],
    );
  }
}