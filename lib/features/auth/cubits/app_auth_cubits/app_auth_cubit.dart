import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'app_auth_state.dart';

class AppAuthCubit extends Cubit<AppAuthState> {
  AppAuthCubit() : super(AppAuthInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
 void checkUserLoggedIn() {
    final user = _auth.currentUser;
    if (user != null) {
      emit(AppAuthLoggedIn());
    } else {
      emit(AppAuthLoggedOut());
    }
  }

  void logout() async {
    await _auth.signOut();
    emit(AppAuthLoggedOut());
  }

}
