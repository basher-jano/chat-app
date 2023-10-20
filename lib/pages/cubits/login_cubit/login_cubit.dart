import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> LoginUser({required email, required password}) async {
    emit(LoginLoading());

    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      var exeptionMessage = HundlingError(e);
      emit(LoginFailure(exeptionMessage: exeptionMessage));
    }
  }

  String HundlingError(
    FirebaseAuthException e,
  ) {
    if (e.code == 'wrong-password') {
      return 'You have entered wrong password, please try again';
    } else if (e.code == 'user-not-found') {
      return 'There is no exist account for this email';
    } else if (e.code == 'invalid-email') {
      return 'The email is invalid.';
    } else if (e.code == 'network-request-failed') {
      return 'Check your internet connection!';
    }
    return 'no_exeption';
  }
}
