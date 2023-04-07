import 'package:google_components/src/domain/repositories/igoogle_components_repository.dart';

class FirebaseConfirmPassRecovery {
  FirebaseConfirmPassRecovery({
    required IGoogleComponentsRepository repository,
  }) : _repository = repository;

  final IGoogleComponentsRepository _repository;

  Future<String?> call(
          {required String code, required String newPassword,}) async =>
      await _repository.confirmPasswordRecovery(
          code: code, newPassword: newPassword,);
}
