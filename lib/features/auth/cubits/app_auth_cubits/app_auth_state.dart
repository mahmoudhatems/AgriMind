part of 'app_auth_cubit.dart';

@immutable
abstract class AppAuthState {}

class AppAuthInitial extends AppAuthState {}

class AppAuthLoggedIn extends AppAuthState {}

class AppAuthLoggedOut extends AppAuthState {}