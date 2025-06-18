import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/core/services/get_it__service.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/app_bar.dart';
import 'package:happyfarm/features/auth/cubits/login_cubits/login_cubit.dart';
import 'package:happyfarm/features/auth/domain/repos/auth_repo.dart';
import 'package:happyfarm/features/auth/login/widgets/login_body_bloc_consumer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        backgroundColor: ColorsManager.realWhiteColor,
        appBar: buildAppBar(
          title: "Login",
          context: context,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              /// Register Buttons
             LoginBodyBlocConsumer()
            ]
          ),
        ),
      ),
    );
  }
}
