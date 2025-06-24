import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/widgets/show_toast.dart';
import 'package:happyfarm/features/auth/cubits/signup_cubits/signup_cubit.dart';
import 'package:happyfarm/features/auth/cubits/login_cubits/login_cubit.dart';
import 'package:happyfarm/features/auth/register/widgets/register_body.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              GoRouter.of(context).go(Routes.home);
            } else if (state is SignupFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showToast(context, state.error);
              });
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              GoRouter.of(context).go(Routes.home);
            } else if (state is LoginFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showToast(context, state.error);
              });
            }
          },
        ),
      ],
      child: Stack(
        children: [
          const RegisterScreenBody(),
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              if (state is SignupLoading) {
                return const _LoadingOverlay();
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return const _LoadingOverlay();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.white.withValues(alpha:  0.8),
        child: Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorsManager.mainBlueGreen),
          ),
        ),
      ),
    );
  }
}
