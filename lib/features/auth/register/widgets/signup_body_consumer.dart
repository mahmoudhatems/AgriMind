import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/features/auth/cubits/signup_cubits/signup_cubit.dart';
import 'package:happyfarm/features/auth/register/widgets/build_snake_bar.dart';
import 'package:happyfarm/features/auth/register/widgets/register_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) => {
        if (state is SignupSuccess)
          {
            GoRouter.of(context).go(Routes.home),
          }
        else if (state is SignupFailure)
          {
            buildSnackBar(context, state.error),
          }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is SignupLoading ? true : false,
            opacity: 0.5,
            child: RegisterScreenBody());
      },
    );
  }
}
