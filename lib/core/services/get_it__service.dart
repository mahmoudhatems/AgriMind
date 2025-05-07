import 'package:get_it/get_it.dart';
import 'package:happyfarm/core/services/firebase_auth_service.dart';
import 'package:happyfarm/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:happyfarm/features/auth/domain/repos/auth_repo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // Register FirebaseAuthService as a singleton
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<AuthRepo>(
      AuthRepoImplementation(getIt<FirebaseAuthService>()));
}
