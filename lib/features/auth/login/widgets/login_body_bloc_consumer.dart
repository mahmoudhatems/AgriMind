import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/show_toast.dart';
import 'package:happyfarm/features/auth/cubits/login_cubits/login_cubit.dart';
import 'package:happyfarm/features/auth/login/widgets/login_body.dart';

class LoginBodyBlocConsumer extends StatelessWidget {
  const LoginBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          GoRouter.of(context).go(Routes.home);
        } else if (state is LoginFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showToast(context, state.error);
          });
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            const LoginScreenBody(),
            if (state is LoginLoading)
              Positioned.fill(
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ColorsManager.mainBlueGreen,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
