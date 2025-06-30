import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/home/presentation/widgets/switch_tile.dart'; 
import 'package:easy_localization/easy_localization.dart'; 
import 'package:happyfarm/core/utils/strings.dart';  

class HydroDeviceControls extends StatelessWidget {
  final ValueNotifier<bool> pumpController;

  const HydroDeviceControls({super.key, required this.pumpController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.settings_remote, color: ColorsManager.mainBlueGreen, size: 20.sp),
            SizedBox(width: 8.w),
            Text(StringManager.deviceControl.tr(), style: Styles.styleText14BlackColofontJosefinSans), // Localized
          ],
        ),
        SizedBox(height: 16.h),
        ValueListenableBuilder<bool>(
          valueListenable: pumpController,
          builder: (context, value, _) {
            return SwitchTile(
              label: StringManager.waterPump.tr(), // Localized
              subtitle: StringManager.controlsWaterFlow.tr(), // Localized
              icon: Icons.water_drop,
              value: value,
              onChanged: (val) => pumpController.value = val,
            );
          },
        ),
      ],
    );
  }
}