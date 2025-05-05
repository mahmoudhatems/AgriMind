import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/features/intro/splash/presentation/views/widgets/sliding_text.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController; //
  late Animation<Offset> _slidingAnimation;
  @override
  void initState() {
    super.initState();
    initSlidingAnimated();

    navigateToHome();
  }

  void navigateToHome() async {
    await Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      // ignore: use_build_context_synchronously
      GoRouter.of(context).pushReplacement(Routes.onboarding);
    });
  }

  void initSlidingAnimated() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.fastLinearToSlowEaseIn));
    _animationController.forward();
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
