import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/core/widgets/custom_buttom.dart';
import 'package:happyfarm/core/widgets/custom_password_text_field.dart';
import 'package:happyfarm/core/widgets/custom_text_form_field.dart';
import 'package:happyfarm/core/widgets/or_divider.dart';
import 'package:happyfarm/features/auth/cubits/login_cubits/login_cubit.dart';
import 'package:happyfarm/features/auth/login/widgets/donot_have_acc.dart';
import 'package:happyfarm/features/auth/login/widgets/scoial_login.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  late String email, password;

  late AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        autovalidateMode: _autovalidateMode,
       
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
                child: SvgPicture.asset(
              StringManager.loginSvg,
              height: 120.h,
            )),
            const SizedBox(height: 24),
            CustomTextFormField(
              onSaved: (value) {
                email = value!;
              },
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            PasswordCustomTextFormField(
              onSaved: (value) {
                password = value!;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forget Password?',
                  style: Styles.styleText14BlackColofontJosefinSans,
                ),
              ),
            ),
            const SizedBox(height: 14),
            CustomButton(
                text: "Login",
                onPressed: () {

                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                     context.read<LoginCubit>().signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                backgroundColor: ColorsManager.mainBlueGreen,
                textStyle: Styles.styleBoldText18ButomfontJosefinSans
                    .copyWith(color: ColorsManager.realWhiteColor),
                borderColor: ColorsManager.mainBlueGreen,
                borderRadius: BorderRadius.circular(8.r)),
            const SizedBox(height: 16),
            DonotHaveAcc(),
            const SizedBox(height: 16),
            OrDivider(),
            const SizedBox(height: 16),
            ScoialLogin(),
          ],
        ),
      ),
    );
  }
}
