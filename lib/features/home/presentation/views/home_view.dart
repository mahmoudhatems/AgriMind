import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:happyfarm/generated/locale_keys.g.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Happy Farm'),
      ),
      body: Text(LocaleKeys.happyFarm.tr()),
    );
  }
}