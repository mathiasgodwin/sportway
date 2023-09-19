import 'package:google_components/src/domain/repositories/igoogle_components_repository.dart';

class FirebaseVerifySms {
  FirebaseVerifySms({required IGoogleComponentsRepository repository})
      : _repository = repository;

  final IGoogleComponentsRepository _repository;

  Future<void> call(
          {required String smsCode, required String verificationId}) async =>
      await _repository.verifySmsCode(
          smsCode: smsCode, verificationId: verificationId);
}
