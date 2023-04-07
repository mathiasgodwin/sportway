part of 'update_profile_cubit.dart';

enum UpdateProfilePhotoStatus { initial, updating, updated, failure }

class UpdateProfilePhotoState extends Equatable {
  const UpdateProfilePhotoState({
    this.photoUrl,
    this.status = UpdateProfilePhotoStatus.initial,
    this.errorMessage,
  });
  final String? photoUrl;
  final UpdateProfilePhotoStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [photoUrl, status, errorMessage];

  UpdateProfilePhotoState copyWith({
    String? photoUrl,
    UpdateProfilePhotoStatus? status,
    String? errorMessage,
  }) {
    return UpdateProfilePhotoState(
      photoUrl: photoUrl ?? this.photoUrl,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
