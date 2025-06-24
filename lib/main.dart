import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyfarm/core/services/custom_bloc_observer.dart';
import 'package:happyfarm/core/services/get_it__service.dart';
import 'package:happyfarm/core/services/notification_service.dart';
import 'package:happyfarm/features/settings/presentation/manager/settings_cubit.dart';
import 'package:happyfarm/happy_farm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';

///  Easy Localization
/// dart run easy_localization:generate -S assets/translations
/// dart run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await NotificationService.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupGetIt();

  Bloc.observer = CustomBlocObserver();
if (Platform.isAndroid) {
  final result = await Permission.notification.request();
  if (!result.isGranted) {
    print("Permission Denied");
  }
}

  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      child:  BlocProvider(
        create: (_) => SettingsCubit(),
        child: const HappyFarm(),
      ) 
    ),
  );
}
