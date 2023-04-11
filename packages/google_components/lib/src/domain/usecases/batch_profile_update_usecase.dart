import 'package:google_components/google_components.dart';

class BatchProfileUpdateUsecase {
  const BatchProfileUpdateUsecase({
    required this.repository,
  });
  final IGoogleComponentsRepository repository;
  Future<void> call({
    String? fullName,
    String? photoUrl,
    String? email,
    String? password,
  }) async {
    await repository.batchProfileUpdate(
        fullName: fullName,
        photoUrl: photoUrl,
        email: email,
        password: password);
  }
}
