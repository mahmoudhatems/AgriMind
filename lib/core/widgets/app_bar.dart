
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

AppBar buildAppBar({
  required String title,required  BuildContext context
}) {
  return AppBar(
    title: Text(
      title,
      style: Styles.titlesemiBoldText24DarkfontJosefinSans,
    ),
    centerTitle: true,
    backgroundColor: ColorsManager.realWhiteColor,
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_outlined),
        onPressed: () {
        GoRouter.of(context).pop();
        
        }),
  );
}
