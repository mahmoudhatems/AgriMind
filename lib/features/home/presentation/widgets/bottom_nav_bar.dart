import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/custom_app_bar.dart';
import 'package:happyfarm/features/Logs/presentation/views/logs_view.dart';
import 'package:happyfarm/features/home/presentation/views/green_house_view.dart';
import 'package:happyfarm/features/home/presentation/views/home_page.dart';
import 'package:happyfarm/features/settings/presentation/views/setting_screen.dart'; // Your custom app bar

class CustomButtomBar extends StatefulWidget {
  const CustomButtomBar({Key? key}) : super(key: key);

  @override
  State<CustomButtomBar> createState() => _CustomButtomBarState();
}

class _CustomButtomBarState extends State<CustomButtomBar> {
  int _currentIndex = 0;

  // Four pages: Home, Greenhouse, Logs, Options
  final List<Widget> _screens = [
    const HomePage(),
    const GreenhousePage(),
    const LogsPage(),
    const SettingScreen(),
  ];

  /// Determines the app bar title based on the current tab.
  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return "Home";
      case 1:
        return "Greenhouse";
      case 2:
        return "Logs";
      case 3:
        return "Options";
      default:
        return "Happy Farm";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _getAppBarTitle(),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: GNav(
          gap: 4.w,
          backgroundColor: Colors.white,
          color: Colors.grey,
          activeColor: ColorsManager.mainBlueGreen,
          tabBackgroundColor: ColorsManager.mainBlueGreen.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
              style: GnavStyle.google,
            ),
            GButton(
                icon: Icons.local_florist_outlined,
                text: 'Greenhouse',
                style: GnavStyle.google),
            GButton(
                icon: Icons.list_alt_outlined,
                text: 'Logs',
                style: GnavStyle.google),
            GButton(
                icon: Icons.settings_outlined,
                text: 'Options',
                style: GnavStyle.google),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
