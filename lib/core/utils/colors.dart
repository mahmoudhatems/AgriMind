import 'package:flutter/material.dart';
/// ColorsManager class is used to store the colors used in the app.
  abstract class ColorsManager {
  static const Color backGroundLight = Color(0xFFF6E7C8);
  static const Color whiteColor = Color(0xFFFCF7EC);
  static const Color realWhiteColor = Color(0xFFFFFFFF);
  static const Color mainGreen = Color(0xFF069494);
  static const Color darkBlueTextColor = Color(0xFF1F2A37);
  static const Color purple = Color(0xFF333E7F);
  static const Color gold = Color(0xFFFBDA72);
  static const Color yellow = Color(0xFFF9A826);
  static const Color textIconColor = Color(0xFF242A30);
  static const Color backGroundMoreLight = Color(0xFFFFFBF7);
  static const Color textIconColorGray = Color(0xFFBDBDBD);
  static const Color facebookColor = Color(0xFF3B5997);
  static const Color googleColor = Color(0xFFDB4437);
  static const Color greenColor = Color(0xFF8DC83E);


  static const LinearGradient mixedWhiteEffectGradient = LinearGradient(
    colors: [Color(0xFFBDBDBD), Color(0xFFFFFFFF)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  }