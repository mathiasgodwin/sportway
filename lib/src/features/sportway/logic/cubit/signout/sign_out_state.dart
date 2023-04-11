// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_out_cubit.dart';

enum SignOutStatus {
  initial,
  loading,
  success,
  failure,
}

class SignOutState extends Equatable {
  const SignOutState({
    this.errorMessage,
    this.status = SignOutStatus.initial,
  });

  final String? errorMessage;
  final SignOutStatus status;

  @override
  List<Object?> get props => [
        errorMessage,
        status,
      ];

  SignOutState copyWith({
    String? errorMessage,
    SignOutStatus? status,
  }) {
    return SignOutState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
