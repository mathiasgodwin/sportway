import 'package:google_components/src/domain/repositories/igoogle_components_repository.dart';

class FirebaseSignOutUser {
  FirebaseSignOutUser({
    required IGoogleComponentsRepository repository,
  }) : _repository = repository;

  final IGoogleComponentsRepository _repository;

  Future<void> call() async => await _repository.signOut();
}
