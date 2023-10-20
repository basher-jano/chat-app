import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> RegisterUser({required email, required password}) async {
    emit(RegisterLoading());

    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      var exeptionMessage = HundlingError(e);
      emit(RegisterFailure(exeptionMessage: exeptionMessage));
    }
  }

  String HundlingError(
    FirebaseAuthException e,
  ) {
    if (e.code == 'weak-password') {
      return 'You have entered weak password, please try again';
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
