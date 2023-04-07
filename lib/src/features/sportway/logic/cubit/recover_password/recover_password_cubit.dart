import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:google_components/google_components.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';
import 'package:sportway/core/utils/validators/validators.dart';

part 'recover_password_state.dart';

class RecoverPasswordCubit extends Cubit<RecoverPasswordState> {
  final IGoogleComponentsRepository repository;
  RecoverPasswordCubit(this.repository) : super(const RecoverPasswordState());

  // late final _confirmPasswordRecovery =
  //     FirebaseConfirmPassRecovery(repository: repository);

  late final _requestPasswordRecovery =
      FirebaseRecoverPassword(repository: repository);

  Email email = const Email.dirty('');

  void emailChanged(String value) {
    email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
        ]),
      ),
    );
  }

  Future<void> recoverPassword() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _requestPasswordRecovery(
        email: state.email.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on PasswordRecoveryFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  // Future<void> confirmRecoverPassword() async {
  //   if (!state.status.isValidated) return;
  //   emit(state.copyWith(status: FormzStatus.submissionInProgress));

  //   try {
  //     await _confirmPasswordRecovery(
  //         newPassword: state.password.value, code: state.code.value);
  //     emit(state.copyWith(status: FormzStatus.submissionSuccess));
  //   } on ConfirmedPasswordValidationError catch (e) {
  //     emit(state.copyWith(
  //         status: FormzStatus.invalid, errorMessage: e.toString()));
  //   } on ConfirmPasswordRecoveryFailure catch (e) {
  //     emit(state.copyWith(
  //         status: FormzStatus.submissionFailure, errorMessage: e.toString()));
  //   } catch (_) {
  //     emit(state.copyWith(status: FormzStatus.submissionFailure));
  //   }
  // }

  void validateIsEmtptyField() {
    emit(state.copyWith(email: email, status: Formz.validate([state.email])));
  }
}
