import 'package:flutter/material.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/app_bar.dart';
import 'package:happyfarm/features/auth/register/widgets/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.realWhiteColor,
      appBar:buildAppBar(
        title: "Register",
        context: context,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            /// Register Buttons
            RegisterScreenBody(),
          ],
        ),
      ),
    );
  }
}
