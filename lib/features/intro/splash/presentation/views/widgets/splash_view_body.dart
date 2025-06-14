import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/features/intro/splash/presentation/views/widgets/sliding_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController; 
  late Animation<Offset> _slidingAnimation;
  @override
  void initState() {
    super.initState();
    initSlidingAnimated();
    navigateFlow();
  }

  void initSlidingAnimated() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _animationController.forward();
  }

  Future<void> navigateFlow() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

    // شرط خاص بأندرويد قديم (اختياري)
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt < 31) {
        _goBasedOnSeenOnboarding(seenOnboarding, user, prefs);
        return;
      }
    }

    // تأخير علشان الأنيميشن
    await Future.delayed(const Duration(seconds: 3));
    _goBasedOnSeenOnboarding(seenOnboarding, user, prefs);
  }

  void _goBasedOnSeenOnboarding(
    bool seenOnboarding,
    User? user,
    SharedPreferences prefs,
  ) async {
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 229, 246, 241),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              StringManager.appIcon,
              width: 200.w,
              height: 200.h,
            ),
            SizedBox(height: 10.h),
            SlidingText(slidingAnimation: _slidingAnimation)
          ],
        ),
      ),
    );
  }
}
