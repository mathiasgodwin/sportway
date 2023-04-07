import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_components/google_components.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';
import 'package:sportway/core/utils/validators/validators.dart';

part 'update_profile_state.dart';

class UpdateProfileNameCubit extends Cubit<UpdateProfileNameState> {
  final IGoogleComponentsRepository repository;
  UpdateProfileNameCubit(this.repository)
      : super(const UpdateProfileNameState());

  late final _updateProfileName = FirebaseUpdateProfile(repository: repository);

  Name fullName = const Name.dirty('');

  void fullNameChanged(String value) {
    fullName = Name.dirty(value);
    emit(
        state.copyWith(fullName: fullName, status: Formz.validate([fullName])));
  }

  Future<void> updateProfileName() async {
    if (!state.status.isValidated) return;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );

    try {
      await _updateProfileName(fullName: state.fullName.value);

      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on UpdateProfileException catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } catch (e) {
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
