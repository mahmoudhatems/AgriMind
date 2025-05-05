import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/core/widgets/custom_buttom.dart';
import 'package:happyfarm/core/widgets/custom_text_form_field.dart';
import 'package:happyfarm/core/widgets/or_divider.dart';
import 'package:happyfarm/features/auth/login/widgets/donot_have_acc.dart';
import 'package:happyfarm/features/auth/login/widgets/scoial_login.dart';
import 'package:happyfarm/features/auth/onbording/presentation/widgets/app_icon.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          SizedBox(
              child: SvgPicture.asset(
            StringManager.signUpSvg,
            height: 120.h,
          )),
          const SizedBox(height: 24),
          CustomTextFormField(
            hintText: 'Name',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            hintText: 'Password',
            keyboardType: TextInputType.visiblePassword,
            suffexIcon: const Icon(
              Icons.visibility_off,
              color: ColorsManager.textIconColor,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
              text: "Create Account",
              onPressed: () {},
              backgroundColor: ColorsManager.mainBlueGreen,
              textStyle: Styles.styleBoldText18ButomfontJosefinSans
                  .copyWith(color: ColorsManager.realWhiteColor),
              borderColor: ColorsManager.mainBlueGreen,
              borderRadius: BorderRadius.circular(8.r)),
          const SizedBox(height: 16),
           Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ? ',
                    style: Styles.styleText14BlackColofontJosefinSans,
                  ),
                  GestureDetector(
                    onTap: () {
                    GoRouter.of(context).push(Routes.login);
                    },
                    child: Text(
                      'Login',
                      style: Styles.styleText14BlackColofontJosefinSans
                          .copyWith(
                              color: ColorsManager.mainBlueGreen,
                              fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          OrDivider(),
          const SizedBox(height: 16),
          ScoialLogin(),
        ],
      ),
    );
  }
}