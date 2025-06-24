import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/core/services/get_it__service.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/app_bar.dart';
import 'package:happyfarm/features/auth/cubits/signup_cubits/signup_cubit.dart';
import 'package:happyfarm/features/auth/cubits/login_cubits/login_cubit.dart';
import 'package:happyfarm/features/auth/domain/repos/auth_repo.dart';
import 'package:happyfarm/features/auth/register/widgets/signup_body_consumer.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupCubit>(
          create: (_) => SignupCubit(getIt<AuthRepo>()),
        ),
        BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(getIt<AuthRepo>()),
        ),
      ],
      child: Scaffold(
        backgroundColor: ColorsManager.realWhiteColor,
        appBar: buildAppBar(
          title: "Register",
          context: context,
        ),
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SignupViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
