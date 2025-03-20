import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/generated/locale_keys.g.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required Animation<Offset> slidingAnimation,
  }) : _slidingAnimation = slidingAnimation;

  final Animation<Offset> _slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _slidingAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: _slidingAnimation, //  SlideTransition
            child: Text(
                textAlign: TextAlign.center,
                LocaleKeys.happyFarm.tr(),
                style: Styles.styleBoldText20GrayfontJosefinSans.copyWith(
                  fontSize: 28,
                )),
          );
        });
  }
}
