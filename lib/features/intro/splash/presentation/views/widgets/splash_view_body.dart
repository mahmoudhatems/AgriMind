import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/features/intro/splash/presentation/views/widgets/animated_gradiant_background.dart';
import 'package:happyfarm/features/intro/splash/presentation/views/widgets/sliding_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slidingAnimation;

late AnimationController _gradientController;
late Animation<Alignment> _animatedAlign;


  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    initGradientAnimation();
    navigateFlow();
  }

  void initSlidingAnimation() {
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    _slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _slideController.forward();
  }
  void initGradientAnimation() {
  _gradientController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 8),
  )..repeat(reverse: true);

  _animatedAlign = Tween<Alignment>(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  ).animate(CurvedAnimation(
    parent: _gradientController,
    curve: Curves.easeInOut,
  ));
}


  Future<void> navigateFlow() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt < 31) {
        _goBasedOnSeenOnboarding(seenOnboarding, user, prefs);
        return;
      }
    }

    await Future.delayed(const Duration(seconds: 3));
    _goBasedOnSeenOnboarding(seenOnboarding, user, prefs);
  }

  void _goBasedOnSeenOnboarding(
      bool seenOnboarding, User? user, SharedPreferences prefs) async {
    if (!seenOnboarding) {
      await prefs.setBool('seen_onboarding', true);
      context.go(Routes.onboarding);
    } else {
      if (user != null) {
        context.go(Routes.home);
      } else {
        context.go(Routes.login);
      }
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return AnimatedGradientBackground(
  animatedAlignment: _animatedAlign,
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          StringManager.appIcon,
          width: 200.w,
          height: 200.h,
        ).animate().fadeIn(duration: 700.ms).scale(begin: const Offset(0.9, 0.9)),
        SizedBox(height: 20.h),
        SlidingText(slidingAnimation: _slidingAnimation),
      ],
    ),
  ),
);


  }
}
