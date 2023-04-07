
import 'package:google_components/src/domain/repositories/igoogle_components_repository.dart';

class FirebasePhoneSignIn {
  FirebasePhoneSignIn({required IGoogleComponentsRepository repository})
      : _repository = repository;

  final IGoogleComponentsRepository _repository;

  Stream<String> call({required String phoneNumber, Duration? timeout}) async* {
    final response = _repository.signInWithPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeout);

    yield* response;
  }
}
