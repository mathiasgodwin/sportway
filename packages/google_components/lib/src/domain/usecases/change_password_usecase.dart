import 'package:google_components/google_components.dart';

class ChangePasswordUsecase {
  const ChangePasswordUsecase({
    required this.repository,
  });

  final IGoogleComponentsRepository repository;
  Future<void> call({
    required String newPassword,
    required String oldPassword,
  }) async {
    await repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
