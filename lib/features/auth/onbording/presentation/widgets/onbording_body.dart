import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/core/widgets/custom_buttom.dart';
import 'package:happyfarm/features/auth/onbording/presentation/widgets/app_icon.dart';
import 'package:happyfarm/features/auth/onbording/presentation/widgets/carousel_slider.dart';

class OnBordingBody extends StatefulWidget {
  const OnBordingBody({super.key});

  @override
  State<OnBordingBody> createState() => _OnBordingBodyState();
}

class _OnBordingBodyState extends State<OnBordingBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// App Icon
            AppIcon(),
            Column(
              children: [SizedBox(height: 20.h), CustomCarouselSlider()],
            ),

            /// Login Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 60.h),
              child: Column(
                children: [
                  // Facebook Button
                  CustomButton(
                    onPressed: () {
                      GoRouter.of(context).go(Routes.home);
                    },
                    text: 'Continue with Facebook',
                    backgroundColor: ColorsManager.facebookColor,
                    textStyle: Styles.styleBoldText16ButomfontJosefinSans,
                    borderRadius: BorderRadius.circular(8.r),
                    icon: const Icon(Icons.facebook_outlined),
                    iconColor: ColorsManager.realWhiteColor,
                  ),

                  SizedBox(height: 20.h),

                  // Google Button
                  CustomButton(
                    onPressed: () {  GoRouter.of(context).go(Routes.home);},
                    text: 'Continue with Google',

                    backgroundColor: ColorsManager.googleColor,
                    textStyle: Styles.styleBoldText16ButomfontJosefinSans,
                    borderRadius: BorderRadius.circular(8),
                    icon: Image.asset(
                      StringManager.googleIconPath,
                      width: 16.w,
                      height: 16.h,
                    ),
                    // iconColor not needed here
                  ),

                  SizedBox(height: 28.h),
                  // Email Button

                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              ColorsManager.textIconColorGray.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(0, 8),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomButton(
                      onPressed: () {  GoRouter.of(context).go(Routes.register);},
                      text: 'Continue with Email',
                      backgroundColor: ColorsManager.realWhiteColor,
                      textStyle:
                          Styles.styleBoldText16ButomfontJosefinSans.copyWith(
                        color: ColorsManager.textIconColorGray,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      icon:  Icon(Icons.email_outlined,
                        color: ColorsManager.textIconColorGray,
                      ),
                      iconColor: ColorsManager.textIconColorGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
