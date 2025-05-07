import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/core/widgets/custom_buttom.dart';
import 'package:happyfarm/features/auth/login/widgets/scoial_login.dart';
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
              children: [SizedBox(height: 50.h), CustomCarouselSlider()],
            ),

            /// Login Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 60.h),
              child: Column(
                children: [
                  SizedBox(height: 100.h),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              ColorsManager.textIconColorGray.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomButton(
                      iconPosition: IconPosition.right,
                      onPressed: () {
                        GoRouter.of(context).push(Routes.login);
                      },
                      text: 'Get Started',
                      backgroundColor: ColorsManager.realWhiteColor,
                      textStyle:
                          Styles.styleBoldText16ButomfontJosefinSans.copyWith(
                        color: ColorsManager.textIconColor,
                        fontSize: 18.sp,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: ColorsManager.textIconColor,
                      ),
                      iconColor: ColorsManager.textIconColor,
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
