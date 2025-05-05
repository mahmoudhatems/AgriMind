

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class DonotHaveAcc extends StatelessWidget {
  const DonotHaveAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ? ',
                    style: Styles.styleText14BlackColofontJosefinSans,
                  ),
                  GestureDetector(
                    onTap: () {
                    GoRouter.of(context).push(Routes.register);
                    },
                    child: Text(
                      'Register',
                      style: Styles.styleText14BlackColofontJosefinSans
                          .copyWith(
                              color: ColorsManager.mainBlueGreen,
                              fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
  }
}