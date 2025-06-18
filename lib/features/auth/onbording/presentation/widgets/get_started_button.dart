

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';
import 'package:happyfarm/core/widgets/custom_buttom.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:
                ColorsManager.textIconColorGray.withValues( alpha:   0.5),
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomButton(
        iconPosition: IconPosition.right,
        onPressed: () {
          GoRouter.of(context).push(Routes.login);
        },
        text: 'Get Started',
        backgroundColor: ColorsManager.realWhiteColor,
        textStyle:
            Styles.styleBoldText16ButomfontJosefinSans.copyWith(
          color: ColorsManager.textIconColor,
          fontSize: 18.sp,
        ),
        borderRadius: BorderRadius.circular(8),
        icon: Icon(
          Icons.arrow_forward_ios_outlined,
          color: ColorsManager.textIconColor,
        ),
        iconColor: ColorsManager.textIconColor,
      ),
    );
  }
}
