import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:happyfarm/core/errors/exeptions.dart';
import 'package:happyfarm/core/errors/failures.dart';
import 'package:happyfarm/core/services/firebase_auth_service.dart';
import 'package:happyfarm/features/auth/data/models/user_model.dart';

import 'package:happyfarm/features/auth/domain/repos/auth_repo.dart';
import 'package:happyfarm/features/auth/domain/repos/entites/user_entity.dart';

class AuthRepoImplementation extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  AuthRepoImplementation(this.firebaseAuthService);

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(
        UserModel.fromFirebaseUser(user),
      );
    } on CustomException catch (e) {
      log('CustomException in createUserWithEmailAndPassword: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in createUserWithEmailAndPassword: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(
        UserModel.fromFirebaseUser(user),
      );
    } on CustomException catch (e) {
      log('CustomException in signInWithEmailAndPassword: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in signInWithEmailAndPassword: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle()async {
    try {
      final user = await firebaseAuthService.signInWithGoogle();
      return Right(
        UserModel.fromFirebaseUser(user),
      );
    } on CustomException catch (e) {
      log('CustomException in signInWithGoogle: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in signInWithGoogle: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }
  
   
}
