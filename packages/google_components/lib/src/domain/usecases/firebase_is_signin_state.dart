import 'package:google_components/src/domain/repositories/igoogle_components_repository.dart';

class FirebaseIsSignedIn {
  FirebaseIsSignedIn({
    required IGoogleComponentsRepository repository,
  }) : _repository = repository;

  final IGoogleComponentsRepository _repository;

  Future<bool?> call() async => await _repository.isSignedIn();
}
