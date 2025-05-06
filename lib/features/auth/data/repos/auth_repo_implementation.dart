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
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
