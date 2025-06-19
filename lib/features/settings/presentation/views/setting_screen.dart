import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/settings/presentation/widgets/profile_card.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_group.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_switch_tile.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_tile.dart';
import 'package:happyfarm/features/settings/presentation/widgets/signout_tile.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notifications = true;
  bool darkMode = false;

  void _signOutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor: ColorsManager.realWhiteColor,
        title: Text('Sign Out', style: Styles.styleBoldText20GrayfontJosefinSans),
        content: Text('Are you sure you want to sign out?',
            style: TextStyle(fontSize: 16.sp, color: ColorsManager.textIconColorGray)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(Routes.login);
            },
            child: Text('Sign Out', style: TextStyle(fontSize: 16.sp, color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
              _buildHeader(),
              SizedBox(height: 30.h),
              const ProfileCard(),
              SizedBox(height: 40.h),
              SettingGroup(
                title: 'Account',
                items: [
                  SettingTile(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {},
                  ),
                  SettingTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              SettingGroup(
                title: 'Preferences',
                items: [
                  SettingSwitchTile(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    value: notifications,
                    onChanged: (val) => setState(() => notifications = val),
                  ),
                  SettingSwitchTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'Dark Mode',
                    value: darkMode,
                    onChanged: (val) => setState(() => darkMode = val),
                  ),
                  SettingTile(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              SettingGroup(
                title: 'About',
                items: [
                  SettingTile(
                    icon: Icons.info_outline,
                    title: 'App Information',
                    subtitle: 'v1.0.0',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              SignOutTile(onTap: _signOutDialog),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
          'Settings',
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
