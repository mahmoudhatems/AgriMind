import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/settings/presentation/widgets/profile_card.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_screen_body.dart';
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whitegraybackGround,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: 30.h),
              const ProfileCard(),
              SizedBox(height: 40.h),
              SettingsBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 26.sp,
          color: ColorsManager.textIconColorGray,
          onPressed: () => context.pop(),
        ),
        SizedBox(width: 10.w),
        Text(
          'Settings'.tr(),
          style: Styles.styleNormalText14GrayfontJosefinSans.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: ColorsManager.textIconColor,
          ),
        ),
      ],
    );
  }
}
