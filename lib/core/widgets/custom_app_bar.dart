import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSettingsTap;
  final Widget? customAction;
  final bool showSettingsIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onSettingsTap,
    this.customAction,
    this.showSettingsIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.appBarTheme.backgroundColor,
      elevation: theme.appBarTheme.elevation ?? 0,
      centerTitle: theme.appBarTheme.centerTitle ?? true,
      leading: _buildAppIcon(),
      title: Text(
        title,
        style: theme.appBarTheme.titleTextStyle,
      ),
      actions: _buildActions(context),
    );
  }

  Widget _buildAppIcon() {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.asset(
          StringManager.appIcon,
          width: 32.w,
          height: 32.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final List<Widget> actions = [];

    if (customAction != null) {
      actions.add(customAction!);
    }

    if (showSettingsIcon) {
      actions.add(_buildSettingsButton(context));
    }

    return actions;
  }

  Widget _buildSettingsButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0.r),
      child: InkWell(
        onTap: onSettingsTap ?? () => context.push(Routes.settings),
        borderRadius: BorderRadius.circular(8.r),
        splashColor: ColorsManager.mainBlueGreenBackGround,
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Icon(
            Icons.settings_outlined,
            size: 28.sp,
            color: ColorsManager.mainBlueGreen.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(52.h);
}
