import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/generated/locale_keys.g.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({super.key, required this.slidingAnimation});

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slidingAnimation,
      child: Text(
        LocaleKeys.appName.tr(),
        textAlign: TextAlign.center,
        style: Styles.styleBoldText20GrayfontJosefinSans.copyWith(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: ColorsManager.darkBlueTextColor ,
          letterSpacing: 1.2,
        ),
      ).animate().fadeIn(duration: 1200.ms),
    );
  }
}
