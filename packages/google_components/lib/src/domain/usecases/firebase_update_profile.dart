// ignore_for_file: public_member_api_docs

import 'package:google_components/src/domain/domain.dart';

class FirebaseUpdateProfile {
  const FirebaseUpdateProfile({required IGoogleComponentsRepository repository})
      : _repository = repository;

  final IGoogleComponentsRepository _repository;

  Future<String?> call({String? fullName, String? photoUrl}) async {
    return await _repository.updateProfile(
      fullName: fullName,
      photoUrl: photoUrl,
    );
  }
}
