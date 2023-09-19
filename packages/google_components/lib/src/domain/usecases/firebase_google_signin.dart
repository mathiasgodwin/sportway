import 'package:google_components/src/domain/repositories/igoogle_components_repository.dart';

class FirebaseGoogleSignIn {
  FirebaseGoogleSignIn({
    required IGoogleComponentsRepository repository,
  }) : _repository = repository;

  final IGoogleComponentsRepository _repository;

  Future<String?> call() async => await _repository.googleSignIn();
}
