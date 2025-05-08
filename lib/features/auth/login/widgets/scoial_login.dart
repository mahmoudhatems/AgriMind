import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/core/widgets/custom_buttom.dart';
import 'package:happyfarm/features/auth/cubits/login_cubits/login_cubit.dart';

class ScoialLogin extends StatelessWidget {
  const ScoialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onPressed: () {
            context.read<LoginCubit>().signInWithFacebook();
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
          onPressed: () {
            context.read<LoginCubit>().signInWithGoogle();
          },
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
      ],
    );
  }
}
