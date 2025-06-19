import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/routing/app_routing.dart';
import 'package:happyfarm/core/utils/colors.dart';

class HappyFarm extends StatelessWidget {
  const HappyFarm({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true, // ✅ دي مهمة
      splitScreenMode: true, // ✅ اختيارية لو فيه دعم لتعدد النوافذ
      builder: (context, child) {
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: AppRouting.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsManager.realWhiteColor,
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: ColorsManager.darkBlueTextColor,
                fontFamily: "Josefin Sans",
              ),
              backgroundColor: ColorsManager.whitegraybackGround.withValues(alpha: 0.45),
              elevation: 0,
              centerTitle: true,
            ),
            fontFamily: "Josefin Sans",
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorsManager.mainBlueGreen,
              primary: ColorsManager.mainBlueGreen,
              secondary: ColorsManager.textFieldColor,
            ),
          ),
        );
      },
    );
  }
}
