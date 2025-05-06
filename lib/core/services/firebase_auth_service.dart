import 'package:firebase_auth/firebase_auth.dart';
import 'package:happyfarm/core/errors/exeptions.dart';

class FirebaseAuthService  {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
       throw CustomException( 'The password provided is too weak.' );
      } else if (e.code == 'email-already-in-use') {
     throw CustomException( "this account alredy exists for that email" );
      } else if (e.code == 'invalid-email') {
        throw CustomException( 'The email address is badly formatted.' );
      } else if (e.code == 'operation-not-allowed') {
        throw CustomException( 'The operation is not allowed.' );
      } else if (e.code == 'user-disabled') {
        throw CustomException( 'The user account has been disabled by an administrator.' );
      } else if (e.code == 'user-not-found') {
        throw CustomException( 'No user found for that email.' );
      } else if (e.code == 'wrong-password') {
        throw CustomException( 'Wrong password provided for that user.' );
      } else {
        throw CustomException( e.message! );
      }
    } catch (e) {
      throw CustomException( e.toString() );  
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException( 'No user found for that email.' );
      } else if (e.code == 'wrong-password') {
        throw CustomException( 'wrong password or email' );
      } else if (e.code == 'invalid-email') {
        throw CustomException( 'The email address is badly formatted.' );
      } else if (e.code == 'operation-not-allowed') {
        throw CustomException( 'The operation is not allowed.' );
      } else if (e.code == 'user-disabled') {
        throw CustomException( 'The user account has been disabled by an administrator.' );
      } else {
        throw CustomException( e.message! );
      }
    } catch (e) {
      throw CustomException( e.toString() );  
    }   
  }


  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw CustomException( e.toString() );  
    }
  }
}
