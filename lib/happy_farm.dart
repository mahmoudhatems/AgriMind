import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/routing/app_routing.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/features/settings/presentation/manager/settings_cubit.dart';

class HappyFarm extends StatelessWidget {
  const HappyFarm({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => SettingsCubit(),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: AppRouting.router,
                locale: state.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
                theme: _lightTheme(),
                darkTheme: _darkTheme(),
              );
            },
          ),
        );
      },
    );
  }

  ThemeData _lightTheme() => ThemeData(
        scaffoldBackgroundColor: ColorsManager.realWhiteColor,
        fontFamily: "Josefin Sans",
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: ColorsManager.whitegraybackGround.withOpacity(0.45),
          titleTextStyle: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Josefin Sans",
            color: ColorsManager.darkBlueTextColor,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsManager.mainBlueGreen,
          primary: ColorsManager.mainBlueGreen,
          secondary: ColorsManager.textFieldColor,
        ),
      );

  ThemeData _darkTheme() => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF1E1E1E),
          titleTextStyle: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            fontFamily: "Josefin Sans",
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: ColorsManager.mainBlueGreen,
          primary: ColorsManager.mainBlueGreen,
          secondary: ColorsManager.textFieldColor,
        ),
      );
}
