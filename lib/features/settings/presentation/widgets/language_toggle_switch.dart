import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';

class LanguageToggleSwitch extends StatelessWidget {
  const LanguageToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isEnglish = context.locale.languageCode == 'en';

    return GestureDetector(
      onTap: () {
        final currentLocale = context.locale;
        final newLocale = currentLocale.languageCode == 'en'
            ? const Locale('ar')
            : const Locale('en');
        context.setLocale(newLocale);
      },
      child: Container(
        width: 80.w,
        height: 35.h,
        decoration: BoxDecoration(
          color: isEnglish ? ColorsManager.mainBlueGreen : ColorsManager.textIconColorGray.withValues ( alpha: 0.5),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:   0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: isEnglish ? Alignment.centerLeft : Alignment.centerRight,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: Container(
                width: 40.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: ColorsManager.realWhiteColor,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(  alpha:  0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  isEnglish ? 'EN' : 'AR',
                  style: TextStyle(
                    color: ColorsManager.darkBlueTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: isEnglish ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  isEnglish ? 'AR' : 'EN',
                  style: TextStyle(
                    color: ColorsManager.realWhiteColor.withValues( alpha:  0.8),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}