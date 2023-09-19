import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_components/google_components.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IGoogleComponentsRepository repository;
  AuthBloc(this.repository)
      : _repository = repository,
        super(repository.currentUser.isEmpty
            ? const AuthState.unauthenticated()
            : AuthState.authenticated(repository.currentUser)) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppAuthRequested>(_onAuthRequested);
    on<AppUserUpdated>(_onUserUpdated);
  }

  final IGoogleComponentsRepository _repository;

  void _onUserChanged(AppUserChanged event, Emitter<AuthState> emit) {
    emit(event.user.isNotEmpty
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated());
  }

  void _onAuthRequested(AppAuthRequested event, Emitter<AuthState> emit) {
    emit(_repository.currentUser.isNotEmpty
        ? AuthState.authenticated(_repository.currentUser)
        : const AuthState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AuthState> emit) {
    emit(const AuthState.unauthenticated());
  }

  void _onUserUpdated(AppUserUpdated event, Emitter<AuthState> emit) async {
    emit(AuthState.authUpdated(_repository.currentUser));
  }
}
