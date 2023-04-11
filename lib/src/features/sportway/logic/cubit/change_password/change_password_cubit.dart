import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:google_components/google_components.dart';
import 'package:sportway/core/utils/validators/validators.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final IGoogleComponentsRepository repository;
  ChangePasswordCubit(this.repository) : super(const ChangePasswordState());

  late final _changePassword = ChangePasswordUsecase(repository: repository);

  Password oldPassword = const Password.dirty('');
  Password newPassword = const Password.dirty('');

  void oldPasswordChanged(String value) {
    oldPassword = Password.dirty(value);
    emit(
      state.copyWith(
        oldPassword: oldPassword,
        status: Formz.validate([
          oldPassword,
          state.newPassword,
        ]),
      ),
    );
  }

  void newPasswordChanged(String value) {
    newPassword = Password.dirty(value);

    emit(
      state.copyWith(
        newPassword: newPassword,
        status: Formz.validate([
          state.oldPassword,
          newPassword,
        ]),
      ),
    );
  }

  Future<void> changePasswordFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );

    try {
      await _changePassword(
        oldPassword: state.oldPassword.value,
        newPassword: state.newPassword.value,
      );

      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on ChangePasswordException catch (e) {
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
          newPassword: newPassword,
          oldPassword: oldPassword,
          status: Formz.validate([state.oldPassword, state.newPassword])),
    );
  }
}
