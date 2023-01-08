import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {

  SplashCubit() : super(SplashInitial());
  Future<void> verifyAuthentication() async {
    emit(CheckingAuthentication());
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        emit(UnAuthenticated());
      } else {
        print('User is signed in!');
        emit(Authenticated());
      }
    });
  }
}
