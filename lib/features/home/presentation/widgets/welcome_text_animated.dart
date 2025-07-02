import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({super.key});

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  Key _textKey = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  void _restartAnimation() {
    setState(() {
      _textKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _restartAnimation,
      child: AnimatedTextKit(
        key: _textKey,
        isRepeatingAnimation: false,
        totalRepeatCount: 1,
        displayFullTextOnTap: true,
        animatedTexts: [
          TypewriterAnimatedText(
            StringManager.welcomeText.tr(),
            speed: const Duration(milliseconds: 90),
            textStyle: Styles.styleBoldText20GrayfontJosefinSans.copyWith(
                fontSize: 22.sp, color: ColorsManager.darkBlueTextColor),
          ),
        ],
      ),
    );
  }
}
