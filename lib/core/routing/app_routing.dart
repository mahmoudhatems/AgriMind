
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/features/auth/presentation/login/view/login_screen.dart';
import 'package:happyfarm/features/home/presentation/views/home_view.dart';
import 'package:happyfarm/features/intro/select_language/select_lang.dart';
import 'package:happyfarm/features/intro/splash/presentation/views/splash_view.dart';


abstract class AppRouting {
  static final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(path: Routes.home, builder: (context, state) => const HomeView()),
   // GoRoute(path: Routes.selectLanguageScreen, builder: (context, state) => const SelectLanguageScreen ()),
   GoRoute(path: Routes.login, builder: (context, state) => const LoginScreen ()),
  ]);
}
