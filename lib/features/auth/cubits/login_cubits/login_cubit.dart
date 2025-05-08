import 'package:bloc/bloc.dart';
import 'package:happyfarm/features/auth/domain/repos/auth_repo.dart';
import 'package:happyfarm/features/auth/domain/repos/entites/user_entity.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(LoginFailure(failure.errmessage)),
      (UserEntity) => emit(LoginSuccess(UserEntity)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(LoginFailure(failure.errmessage)),
      (UserEntity) => emit(LoginSuccess(UserEntity)),
    );
  }
  Future<void> signInWithFacebook() async {
    emit(LoginLoading());
    final result = await authRepo.signInWithFacebook();
    result.fold(
      (failure) => emit(LoginFailure(failure.errmessage)),
      (UserEntity) => emit(LoginSuccess(UserEntity)),
    );
  }
}
