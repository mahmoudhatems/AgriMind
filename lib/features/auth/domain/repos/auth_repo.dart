import 'package:happyfarm/features/auth/domain/repos/entites/user_entity.dart';

abstract class AuthRepo {
 Future<UserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });


  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<bool> isLoggedIn();
}
