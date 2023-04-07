

import 'package:google_components/src/domain/repositories/igoogle_components_repository.dart';

class FirebaseEmailSignUp {
  FirebaseEmailSignUp({
    required IGoogleComponentsRepository repository,
  }) : _repository = repository;

  final IGoogleComponentsRepository _repository;

  Future<String?> call({String? email, String? password}) async =>
      await _repository.emailSignUp(email: email, password: password);
}
