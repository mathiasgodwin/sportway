import 'package:google_components/src/data/models/user/user_model.dart';
import 'package:google_components/src/domain/repositories/igoogle_components_repository.dart';

class FirebaseGetCurrentUser {
  FirebaseGetCurrentUser({required IGoogleComponentsRepository repository})
      : _repository = repository;

  final IGoogleComponentsRepository _repository;

  User call() => _repository.currentUser;
}
