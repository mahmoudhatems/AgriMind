import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/core/services/get_it__service.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/app_bar.dart';
import 'package:happyfarm/features/auth/cubits/signup_cubits/signup_cubit.dart';
import 'package:happyfarm/features/auth/domain/repos/auth_repo.dart';
import 'package:happyfarm/features/auth/register/widgets/register_body.dart';
import 'package:happyfarm/features/auth/register/widgets/signup_body_consumer.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<AuthRepo>()),
      child: Scaffold(
        backgroundColor: ColorsManager.realWhiteColor,
        appBar: buildAppBar(
          title: "Register",
          context: context,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              /// Register Buttons
              SignupViewBodyBlocConsumer(),
            ],
          ),
        ),
      ),
    );
  }
}
