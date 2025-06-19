


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/settings/presentation/manager/settings_cubit.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_group.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_switch_tile.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_tile.dart';
import 'package:happyfarm/features/settings/presentation/widgets/signout_tile.dart';

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();

        return Column(
          children: [
            SettingGroup(
              title: 'Account'.tr(),
              items: [
                SettingTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profile'.tr(),
                  onTap: () {},
                ),
                SettingTile(
                  icon: Icons.lock_outline,
                  title: 'Change Password'.tr(),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 30.h),
            SettingGroup(
              title: 'Preferences'.tr(),
              items: [
                SettingSwitchTile(
                  icon: Icons.notifications_none,
                  title: 'Notifications'.tr(),
                  value: state.notifications,
                  onChanged: cubit.toggleNotifications,
                ),
                SettingSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode'.tr(),
                  value: state.darkMode,
                  onChanged: cubit.toggleDarkMode,
                ),
                SettingTile(
                  icon: Icons.language,
                  title: 'Language'.tr(),
                  subtitle: context.locale.languageCode == 'ar' ? 'العربية' : 'English',
                  onTap: () {
                    final newLocale = context.locale.languageCode == 'ar'
                        ? const Locale('en')
                        : const Locale('ar');
                    cubit.changeLocale(newLocale);
                    context.setLocale(newLocale);
                  },
                ),
              ],
            ),
            SizedBox(height: 30.h),
            SettingGroup(
              title: 'About'.tr(),
              items: [
                SettingTile(
                  icon: Icons.info_outline,
                  title: 'App Information'.tr(),
                  subtitle: 'v1.0.0',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 40.h),
            SignOutTile(
              onTap: () => _showSignOutDialog(context),
            ),
          ],
        );
      },
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor: ColorsManager.realWhiteColor,
        title: Text('Sign Out'.tr(), style: Styles.styleBoldText20GrayfontJosefinSans),
        content: Text(
          'Are you sure you want to sign out?'.tr(),
          style: TextStyle(fontSize: 16.sp, color: ColorsManager.textIconColorGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr(), style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(Routes.login);
            },
            child: Text('Sign Out'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
