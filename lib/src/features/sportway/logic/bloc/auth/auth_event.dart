part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppLogoutRequested extends AuthEvent {}

class AppAuthRequested extends AuthEvent {}

class AppUserChanged extends AuthEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [
        user,
      ];
}

class AppUserUpdated extends AuthEvent {}
