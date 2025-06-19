import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/info_tile.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart';

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
          value: gateStatus,
          onChanged: onGateToggle,
        ),
      ],
    );
  }
}
