part of 'update_profile_cubit.dart';


class UpdateProfileNameState extends Equatable {
  const UpdateProfileNameState({
    this.fullName = const Name.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });
  final Name fullName;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [fullName, status, errorMessage];

  UpdateProfileNameState copyWith({
    Name? fullName,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return UpdateProfileNameState(
      fullName: fullName ?? this.fullName,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
