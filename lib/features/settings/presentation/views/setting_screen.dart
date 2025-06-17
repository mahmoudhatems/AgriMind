import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notifications = true;
  bool darkMode = false;

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor: ColorsManager.realWhiteColor,
        title: Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: ColorsManager.textIconColor,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(
            fontSize: 16.sp,
            color: ColorsManager.textIconColorGray,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16.sp,
                color: ColorsManager.textIconColorGray,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(Routes.login);
            },
            child: Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 16.sp,
                color: ColorsManager.errorColor,
                fontWeight: FontWeight.w500,
              ),
            ),
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
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row( mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      color: ColorsManager.textIconColorGray,
                      iconSize: 26.sp,
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Settings',
                      style:Styles.styleNormalText14GrayfontJosefinSans.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.textIconColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 30.h),
                
                // Profile Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.realWhiteColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsManager.blackTextColor.withValues(alpha: 0.05),
                        blurRadius: 15,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: ColorsManager.mainBlueGreen,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Icon(
                          Icons.person,
                          color: ColorsManager.realWhiteColor,
                          size: 28.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mahmoud Hatem',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.textIconColor,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'mahmoud@happyfarm.com',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: ColorsManager.textIconColorGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: ColorsManager.textIconColorGray,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 40.h),
                
                // Settings Groups
                _buildSettingsGroup('Account', [
                  _buildSettingItem(Icons.person_outline, 'Edit Profile', () {}),
                  _buildSettingItem(Icons.lock_outline, 'Change Password', () {}),
                ]),
                
                SizedBox(height: 30.h),
                
                _buildSettingsGroup('Preferences', [
                  _buildSwitchItem(Icons.notifications_none, 'Notifications', notifications, 
                    (value) => setState(() => notifications = value)),
                  _buildSwitchItem(Icons.dark_mode_outlined, 'Dark Mode', darkMode,
                    (value) => setState(() => darkMode = value)),
                  _buildSettingItem(Icons.language, 'Language', () {}, subtitle: 'English'),
                ]),
                
                SizedBox(height: 30.h),
                
                _buildSettingsGroup('About', [
                  _buildSettingItem(Icons.info_outline, 'App Information', () {}, subtitle: 'v1.0.0'),
                ]),
                
                SizedBox(height: 40.h),
                
                // Sign Out Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorsManager.realWhiteColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color:ColorsManager.blackTextColor.withValues(alpha: 0.05),
                        blurRadius: 15,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _signOut,
                      borderRadius: BorderRadius.circular(16.r),
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: ColorsManager.errorColor,
                              size: 22.sp,
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              'Sign Out',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorsManager.errorColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: ColorsManager.textIconColor,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.realWhiteColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.blackTextColor.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              int index = entry.key;
              Widget item = entry.value;
              return Column(
                children: [
                  item,
                  if (index < items.length - 1)
                    Divider(
                      height: 1,
                      color: ColorsManager.textFieldColor,
                      indent: 56.w,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(IconData icon, String title, VoidCallback onTap, {String? subtitle}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              Icon(
                icon,
                color: ColorsManager.mainBlueGreen,
                size: 22.sp,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.textIconColor,
                  ),
                ),
              ),
              if (subtitle != null) ...[
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorsManager.textIconColorGray,
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              Icon(
                Icons.chevron_right,
                color: ColorsManager.textIconColorGray,
                size: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchItem(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorsManager.mainBlueGreen,
            size: 22.sp,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.textIconColor,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: ColorsManager.mainBlueGreen,
            inactiveTrackColor: ColorsManager.textFieldColor,
            inactiveThumbColor: ColorsManager.textIconColorGray,
          ),
        ],
      ),
    );
  }
}
