import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/custom_app_bar.dart';
import 'package:happyfarm/features/hydroponics/presentation/views/hydroponics_page.dart';
import 'package:happyfarm/features/logs/presentation/views/logs_view.dart';
import 'package:happyfarm/features/home/presentation/views/green_house_view.dart';
import 'package:happyfarm/features/home/presentation/views/home_screen.dart';
import 'package:happyfarm/features/settings/presentation/views/setting_screen.dart';
import 'package:happyfarm/features/warehouse/presentation/views/warehouse_barn_page.dart'; // Your custom app bar

class CustomButtomBar extends StatefulWidget {
  const CustomButtomBar({Key? key}) : super(key: key);

  @override
  State<CustomButtomBar> createState() => _CustomButtomBarState();
}

class _CustomButtomBarState extends State<CustomButtomBar> {
  int _currentIndex = 0;

  // Four pages: Home, Greenhouse, Logs, Options
  final List<Widget> _screens = [
    const HomeScreen(),
    const GreenhousePage(),
    const HydroponicsPage(),
    const WarehouseBarnPage(),
  ];

  /// Determines the app bar title based on the current tab.
  String _getAppBarTitle() {
    switch (_currentIndex) {
      case 0:
        return "Home";
      case 1:
        return "Greenhouse";
      case 2:
        return "Hydroponics";
      case 3:
        return "Warehouse & Barn";
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
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        child: GNav(
          gap: 4.w,
          haptic: true, // haptic feedback
          backgroundColor: Colors.transparent,
          color: ColorsManager.textIconColorGray,
          activeColor: ColorsManager.mainBlueGreen,
          curve: Curves.easeInToLinear,
           duration: Duration(milliseconds: 300),
          tabBackgroundColor: ColorsManager.mainBlueGreenBackGround,
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
                icon: Icons.water_drop_outlined,
                text: 'Hydroponics',
                style: GnavStyle.google),
            GButton(
                icon: Icons.warehouse_outlined,
                text: 'Warehouse & Barn',
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
