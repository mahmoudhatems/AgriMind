import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:happyfarm/core/services/get_it__service.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/custom_app_bar.dart';
import 'package:happyfarm/features/greenhouse/presentation/manager/greenhouse_cubit.dart';
import 'package:happyfarm/features/home/presentation/manager/home_cubit.dart';
import 'package:happyfarm/features/hydroponics/presentation/manager/hydroponics_cubit.dart';
import 'package:happyfarm/features/hydroponics/presentation/views/hydroponics_page.dart';
import 'package:happyfarm/features/greenhouse/presentation/views/green_house_view.dart';
import 'package:happyfarm/features/home/presentation/views/home_screen.dart';
import 'package:happyfarm/features/warehouseandbarn/presentation/manager/warehouse_cubit.dart';
import 'package:happyfarm/features/warehouseandbarn/presentation/views/warehouse_barn_page.dart';

class CustomButtomBar extends StatefulWidget {
  const CustomButtomBar({Key? key}) : super(key: key);

  @override
  State<CustomButtomBar> createState() => _CustomButtomBarState();
}

class _CustomButtomBarState extends State<CustomButtomBar> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      BlocProvider(
        create: (_) => HomeCubit(getIt())..fetchHomeData(),
        child: const HomeScreen(),
      ),
      BlocProvider(
        create: (context) =>
            GreenhouseCubit(getIt())..fetchGreenhouseData(context),
        child: const GreenhouseScreen(),
      ),
      BlocProvider(
        create: (context) => HydroponicsCubit(getIt())..fetchHydroData(context),
        child: const HydroponicsPage(),
      ),
      BlocProvider(
        create: (context) => getIt<WarehouseBarnCubit>(param1: context),
        child: const WarehouseBarnPage(),
      ),
    ];
  }

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
          haptic: true,
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

