part of 'google_signin_cubit.dart';

enum GoogleSigninStatus { initial, inProgress, success, failed }

class GoogleSigninState extends Equatable {
  final String? errorMessage;
  final GoogleSigninStatus status;
  const GoogleSigninState({
    this.errorMessage,
    this.status = GoogleSigninStatus.initial,
  });

  @override
  List<Object?> get props => [errorMessage, status];

  GoogleSigninState copyWith(
      {String? errorMessage, GoogleSigninStatus? status}) {
    return GoogleSigninState(
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status);
  }
}
