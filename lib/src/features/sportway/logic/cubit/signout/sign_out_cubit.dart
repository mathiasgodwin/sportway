import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_components/google_components.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final IGoogleComponentsRepository repository;
  SignOutCubit(this.repository) : super(const SignOutState());

  late final _signOut = FirebaseSignOutUser(repository: repository);

  Future<void> signOut() async {
    emit(state.copyWith(status: SignOutStatus.loading));
    try {
      await _signOut();
      emit(
        state.copyWith(
          status: SignOutStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          status: SignOutStatus.failure,
          errorMessage: 'Can not log-out this time'));
    }
  }
}
