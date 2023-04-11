part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.oldPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });
  final Password oldPassword;
  final Password newPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [oldPassword, newPassword, status, errorMessage];

  ChangePasswordState copyWith({
    Password? oldPassword,
    Password? newPassword,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
