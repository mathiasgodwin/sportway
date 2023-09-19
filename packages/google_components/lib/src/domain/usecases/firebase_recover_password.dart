import 'package:google_components/src/domain/repositories/igoogle_components_repository.dart';

class FirebaseRecoverPassword {
  FirebaseRecoverPassword({
    required IGoogleComponentsRepository repository,
  }) : _repository = repository;

  final IGoogleComponentsRepository _repository;
  Future<String?> call({String? email}) async =>
      await _repository.passwordRecovery(email: email);
}
