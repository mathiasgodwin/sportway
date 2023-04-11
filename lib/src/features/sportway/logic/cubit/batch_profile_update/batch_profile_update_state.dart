part of 'batch_profile_update_cubit.dart';

class BatchProfileUpdateState extends Equatable {
  const BatchProfileUpdateState({
    this.fullName = const NameVariant.pure(),
    this.status = FormzStatus.pure,
    this.email = const EmailVariant.pure(),
    this.password = const PasswordVariant.pure(),
    this.errorMessage,
  });
  final NameVariant fullName;
  final PasswordVariant password;
  final EmailVariant email;

  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        fullName,
        status,
        errorMessage,
        password,
        email,
      ];

  BatchProfileUpdateState copyWith({
    NameVariant? fullName,
    PasswordVariant? password,
    EmailVariant? email,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return BatchProfileUpdateState(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
