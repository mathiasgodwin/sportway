import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:google_components/google_components.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';
import 'package:sportway/core/utils/validators/validators.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final IGoogleComponentsRepository repository;
  SignUpCubit(this.repository) : super(const SignUpState());

  late final _signUpWithEmail = FirebaseEmailSignUp(repository: repository);

  Email email = const Email.dirty('');
  Password password = const Password.dirty('');

  void emailChanged(String value) {
    email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
          // state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        // confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          password,
          // confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );

    try {
      await _signUpWithEmail(
        email: state.email.value,
        password: state.password.value,
      );

      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void validateIsEmptyFields() {
    emit(
      state.copyWith(
          password: password,
          email: email,
          status: Formz.validate([state.email, state.password])),
    );
  }
}
