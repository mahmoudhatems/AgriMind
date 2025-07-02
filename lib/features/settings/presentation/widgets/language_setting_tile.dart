import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/features/settings/presentation/widgets/language_toggle_switch.dart';

class LanguageSettingTile extends StatelessWidget {
  const LanguageSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          final currentLocale = context.locale;
          final newLocale = currentLocale.languageCode == 'en'
              ? const Locale('ar')
              : const Locale('en');
          context.setLocale(newLocale);
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              Icon(Icons.language, color: ColorsManager.mainBlueGreen, size: 22.sp),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  StringManager.language.tr(),
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 8.w),
              const LanguageToggleSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}