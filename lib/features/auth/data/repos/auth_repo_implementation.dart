 import 'package:dartz/dartz.dart';
import 'package:happyfarm/core/errors/failures.dart';
import 'package:happyfarm/features/auth/domain/repos/auth_repo.dart';
import 'package:happyfarm/features/auth/domain/repos/entites/user_entity.dart';

class AuthRepoImplementation  extends AuthRepo  {
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }
}