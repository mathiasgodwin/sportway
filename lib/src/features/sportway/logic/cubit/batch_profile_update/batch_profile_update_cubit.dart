import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_components/google_components.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';
import 'package:sportway/core/utils/validators/email_variant.dart';
import 'package:sportway/core/utils/validators/name_variant.dart';
import 'package:sportway/core/utils/validators/password_variant.dart';
import 'package:sportway/core/utils/validators/validators.dart';

part 'batch_profile_update_state.dart';

class BatchProfileUpdateCubit extends Cubit<BatchProfileUpdateState> {
  final IGoogleComponentsRepository repository;
  BatchProfileUpdateCubit(this.repository)
      : super(const BatchProfileUpdateState());

  late final _batchProfileUpdate =
      BatchProfileUpdateUsecase(repository: repository);

  NameVariant fullName = const NameVariant.dirty('');
  EmailVariant email = const EmailVariant.dirty('');
  PasswordVariant password = const PasswordVariant.dirty('');

  void fullNameChanged(String value) {
    fullName = NameVariant.dirty(value);
    emit(
        state.copyWith(fullName: fullName, status: Formz.validate([fullName])));
  }

  void emailChanged(String value) {
    email = EmailVariant.dirty(value);
    emit(state.copyWith(email: email, status: Formz.validate([email])));
  }

  void passwordChanged(String value) {
    password = PasswordVariant.dirty(value);
    emit(
        state.copyWith(password: password, status: Formz.validate([password])));
  }

  Future<void> batchProfileUpdate() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );

    try {
      await _batchProfileUpdate(
          fullName: state.fullName.invalid ? null : state.fullName.value,
          email: state.email.invalid ? null : state.email.value,
          password: state.password.invalid ? null : state.password.value);

      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on UpdateProfileException catch (e, s) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (e, s) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void validateIsEmptyField() {
    emit(
      state.copyWith(
          fullName: fullName, status: Formz.validate([state.fullName])),
    );
  }
}
