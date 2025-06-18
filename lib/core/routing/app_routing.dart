
import 'package:go_router/go_router.dart';
import 'package:happyfarm/core/routing/routes.dart';
import 'package:happyfarm/features/auth/login/views/login_screen.dart';
import 'package:happyfarm/features/auth/onbording/presentation/view/onbording_screen.dart';
import 'package:happyfarm/features/auth/register/views/register_screen.dart';
import 'package:happyfarm/features/home/presentation/views/home.dart';
import 'package:happyfarm/features/intro/splash/presentation/views/splash_view.dart';
import 'package:happyfarm/features/settings/presentation/views/setting_screen.dart';
abstract class AppRouting {
  static final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(path: Routes.home, builder: (context, state) => const HomeView()),
   GoRoute(path: Routes.onboarding, builder: (context, state) => const OnBordingScreen ()),
     GoRoute(path: Routes.register, builder: (context, state) => const RegisterScreen()),
    GoRoute(path: Routes.login, builder: (context, state) => const LoginScreen()),
     GoRoute(path: Routes.settings, builder: (context, state) => const SettingScreen()),

  ]);
}
