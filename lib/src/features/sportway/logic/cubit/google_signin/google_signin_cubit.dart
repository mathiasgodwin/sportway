import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_components/google_components.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';

part 'google_signin_state.dart';

class GoogleSigninCubit extends Cubit<GoogleSigninState> {
  final IGoogleComponentsRepository repository;
  GoogleSigninCubit(this.repository) : super(const GoogleSigninState());
  late final _loginWithGoogle = FirebaseGoogleSignIn(repository: repository);

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(status: GoogleSigninStatus.inProgress));
    try {
      await _loginWithGoogle();
      emit(state.copyWith(status: GoogleSigninStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      emit(state.copyWith(
        status: GoogleSigninStatus.failed,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: GoogleSigninStatus.failed));
    }
  }
}
