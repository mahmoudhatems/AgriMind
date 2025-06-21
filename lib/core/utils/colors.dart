import 'package:flutter/material.dart';
/// ColorsManager class is used to store the colors used in the app.
  abstract class ColorsManager {
static const Color cardBackground = Color(0xFFF4FAFA);
static const Color tileBackground = Color(0xFFEAF8F8);
  static const Color whitegraybackGround = Color(0xFFF9F9F9);
  static const Color backGroundLight = Color(0xFFF6E7C8);
  static const Color whiteColor = Color(0xFFFCF7EC);
  static const Color realWhiteColor = Color(0xFFFFFFFF);
  static const Color mainBlueGreen = Color(0xFF72B912);
  static const Color lightBlueGreen = Color(0xFFB2E1E1);
  static const Color darkBlueTextColor = Color(0xFF1F2A37);
static const Color temperatureColor = Color(0xFFFF6B6B);
  static const Color humidityColor = Color(0xFF4ECDC4);
  static const Color soilMoistureColor = Color(0xFF45B7D1);
  static const Color gasLevelColor = Color(0xFF96CEB4);
  static const Color lightLevelColor = Color(0xFFFFD93D); 
  static const Color phLevelColor = Color(0xFF9A27AF);
  static const Color waterLevelColor = Color(0xFF16BCAB);
  static const Color onlineStatusColor = Color(0xFF4CAF50);
  static const Color onlineStatusColorLight = Color.fromARGB(255, 0, 255, 0);

  static const Color purple = Color(0xFF333E7F);
  static const Color gold = Color(0xFFFBDA72);
  static const Color yellow = Color(0xFFF9A826);
  static const Color textIconColor = Color(0xFF242A30);
  static const Color backGroundMoreLight = Color(0xFFFFFBF7);
  static const Color textIconColorGray = Color(0xFFBDBDBD);
  static const Color textFilledFormColor = Color(0xFFBDBDBD); 
  static const Color facebookColor = Color(0xFF3B5997);
  static const Color googleColor = Color(0xFFDB4437);
  static const Color greenColor = Color(0xFF8DC83E);
  static const Color lightGreenColor = Color(0xFFB2E1B2);
  static const Color lightGreenColor2 = Color(0xFFB2E1B2);
  static const Color primaryGreenColor =  Color(0xFF059862);
  static const Color errorColor = Color(0xFFEA3A3A);
  static const Color textFieldColor = Color(0xFFF9F9F9);
  static const Color blackTextColor = Color(0xFF000000);

  static final Color mainBlueGreenBackGround= mainBlueGreen.withValues(
            alpha: 0.06,
          );
  static const Color toastErrorColor = Color(0xFFFF7F7F);
  static const LinearGradient mixedWhiteEffectGradient = LinearGradient(
    colors: [Color(0xFFBDBDBD), Color(0xFFFFFFFF)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  }