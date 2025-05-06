import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/core/services/custom_bloc_observer.dart';
import 'package:happyfarm/core/services/get_it__service.dart';
import 'package:happyfarm/happy_farm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

///  Easy Localization
/// dart run easy_localization:generate -S assets/translations
/// dart run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations

void main() async {
  Bloc.observer = CustomBlocObserver(); // Initialize Bloc observer
  setupGetIt(); // Initialize GetIt service locator
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      child: HappyFarm(),
    ),
  );
}
