import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/features/settings/presentation/manager/settings_cubit.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_group.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_switch_tile.dart';
import 'package:happyfarm/features/settings/presentation/widgets/setting_tile.dart';
import 'package:happyfarm/features/settings/presentation/widgets/signout_tile.dart';
import 'package:happyfarm/features/settings/presentation/widgets/language_setting_tile.dart';

// العودة إلى StatelessWidget
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: Scaffold(
        backgroundColor: ColorsManager.whitegraybackGround,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            // استخدام Builder لضمان تحديث الـ context الذي تستخدمه النصوص المترجمة
            child: Builder(
              builder: (innerContext) { // استخدام innerContext هنا
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(innerContext), // تمرير innerContext
                    SizedBox(height: 40.h),
                    _buildSettingsBody(innerContext), // تمرير innerContext
                  ],
                );
              },
            ),
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
          color: ColorsManager.darkBlueTextColor,
          onPressed: () => context.pop(),
        ),
        SizedBox(width: 10.w),
        Text(
          StringManager.settings.tr(), //     الآن
          style: Styles.styleNormalText14GrayfontJosefinSans.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: ColorsManager.textIconColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsBody(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();

        return Column(
          children: [
            /// --- Account Section ---
            SettingGroup(
              title: StringManager.account.tr(),
              items: [
                SettingTile(
                  icon: Icons.person_outline,
                  title: StringManager.editProfile.tr(),
                  onTap: () {},
                ),
                SettingTile(
                  icon: Icons.lock_outline,
                  title: StringManager.changePassword.tr(),
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 30.h),

            /// --- Preferences Section ---
            SettingGroup(
              title: StringManager.preferences.tr(),
              items: [
                SettingSwitchTile(
                  icon: Icons.notifications_none,
                  title: StringManager.notifications.tr(),
                  value: state.notifications,
                  onChanged: cubit.toggleNotifications,
                ),
                SettingSwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: StringManager.darkMode.tr(),
                  value: state.darkMode,
                  onChanged: cubit.toggleDarkMode,
                ),
                // LanguageSettingTile هي المسؤولة عن تغيير اللغة بنفسها
                const LanguageSettingTile(),
              ],
            ),
            SizedBox(height: 30.h),

            /// --- About Section ---
            SettingGroup(
              title: StringManager.about.tr(),
              items: [
                SettingTile(
                  icon: Icons.info_outline,
                  title: StringManager.appInformation.tr(),
                  subtitle: 'v1.0.0',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 40.h),

            /// --- Sign Out ---
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor: ColorsManager.realWhiteColor,
        title: Text(StringManager.signOutDialogTitle.tr(),
            style: Styles.styleBoldText20GrayfontJosefinSans),
        content: Text(
          StringManager.signOutDialogContent.tr(),
          style: TextStyle(
              fontSize: 16.sp, color: ColorsManager.textIconColorGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(StringManager.cancel.tr(),
                style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(Routes.login);
            },
            child: Text(StringManager.signOut.tr(),
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}