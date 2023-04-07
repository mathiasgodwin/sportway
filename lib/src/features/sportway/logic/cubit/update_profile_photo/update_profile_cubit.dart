import 'package:bloc/bloc.dart';
import 'package:google_components/google_components.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';

part 'update_profile_state.dart';

class UpdateProfilePhotoCubit extends Cubit<UpdateProfilePhotoState> {
  final IGoogleComponentsRepository repository;
  UpdateProfilePhotoCubit(this.repository)
      : super(const UpdateProfilePhotoState());

  late final _updateProfilePhoto =
      FirebaseUpdateProfile(repository: repository);

  Future<void> updatePhotoUrl(String photoUrl) async {
    emit(state.copyWith(
      status: UpdateProfilePhotoStatus.updating,
    ));

    try {
      final response = await _updateProfilePhoto(photoUrl: photoUrl);
      emit(state.copyWith(
          status: UpdateProfilePhotoStatus.updated));
    } on UpdateProfileException catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: UpdateProfilePhotoStatus.failure,
      ));
    } catch (e) {
      emit(state.copyWith(status: UpdateProfilePhotoStatus.failure));
    }
  }
}
