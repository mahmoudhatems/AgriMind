import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/core/widgets/custom_buttom.dart';
import 'package:happyfarm/core/widgets/custom_password_text_field.dart';
import 'package:happyfarm/core/widgets/custom_text_form_field.dart';
import 'package:happyfarm/core/widgets/or_divider.dart';
import 'package:happyfarm/features/auth/cubits/signup_cubits/signup_cubit.dart';
import 'package:happyfarm/features/auth/login/widgets/scoial_login.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

 late String email, password, name ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,

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
              onSaved: (value) {
                name = value!;
              },
              hintText: 'Name',
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: 'Email',
              onSaved: (value) {
                email = value!;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            PasswordCustomTextFormField(
              onSaved: (value) {
                password = value!;
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
                text: "Create Account",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<SignupCubit>().createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                          name: name,
                        );
                    setState(() {
                      _autovalidateMode = AutovalidateMode.disabled;
                    });

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
      ),
    );
  }
}

