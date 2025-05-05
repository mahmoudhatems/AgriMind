import 'package:flutter/material.dart';
import 'package:happyfarm/core/utils/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text( textAlign: TextAlign.center,
        "Welcome to Happy Farm Home Page ",
        style: Styles.titlesemiBoldText24ButomfontJosefinSans,
      ),
    );
  }
}