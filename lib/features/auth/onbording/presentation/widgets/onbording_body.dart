import 'package:escape_parent_padding/escapable_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/features/auth/onbording/presentation/widgets/app_icon.dart';
import 'package:happyfarm/features/auth/onbording/presentation/widgets/carousel_slider.dart';
import 'package:happyfarm/features/auth/onbording/presentation/widgets/get_started_button.dart';

class OnBordingBody extends StatelessWidget {
  const OnBordingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              AppIcon(),
              SizedBox(height: 30.h),
              EscapablePadding.lite(
                  height: 360.h, child: CustomCarouselSlider()),
              SizedBox(height: 120.h),
              GetStartedButton(),
            ],
          ),
        ),
      ),
    );
  }
}
