import 'package:dartz/dartz.dart';
import 'package:happyfarm/core/errors/failures.dart';
import 'package:happyfarm/features/auth/domain/repos/entites/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

}
