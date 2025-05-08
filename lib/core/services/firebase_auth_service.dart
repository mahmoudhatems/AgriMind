import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

Future<User> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
}


Future<User> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

  // Once signed in, return the UserCredential
  return   ( await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)).user!;
}

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw CustomException( e.toString() );  
    }
  }
}
