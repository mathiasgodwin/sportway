import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:google_components/google_components.dart';
import 'package:sportway/core/utils/validators/validators.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final IGoogleComponentsRepository repository;
  LoginCubit(this.repository) : super(const LoginState());

  late final _loginWithPasswordEmail =
      FirebaseEmailSignIn(repository: repository);
  late final _loginWithGoogle = FirebaseGoogleSignIn(repository: repository);

  Email email = const Email.dirty('');
  Password password = const Password.dirty('');

  void emailChanged(String value) {
    email = Email.dirty(value);

    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value) {
    password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  Future<void> loginWithCredential() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _loginWithPasswordEmail(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, error: e.message));
    } catch (_) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _loginWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LogInWithGoogleFailure catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        error: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void validateIsEmptyFields() {
    emit(
      state.copyWith(
          email: email,
          password: password,
          status: Formz.validate([state.email, state.password])),
    );
  }
}
