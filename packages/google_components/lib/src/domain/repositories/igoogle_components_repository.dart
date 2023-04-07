// ignore_for_file: public_member_api_docs

import 'package:google_components/src/data/models/user/user_model.dart';

/// Repository interface for google_components
abstract class IGoogleComponentsRepository {
// [Firebase Authentication]
  Future<void> signOut();

  Stream<String> signInWithPhoneNumber({
    required String phoneNumber,
    Duration? timeout,
  });
  //Sends SMS code to the backend for verification, emit error messages, if any.
  Future<void> verifySmsCode({
    required String smsCode,
    required String verificationId,
  });

  Future<bool> isSignedIn();

  Future<String?> googleSignIn();

  Future<String?> emailSignIn({String? email, String? password});

  Future<String?> updateProfile({String? fullName, String? photoUrl}) async {}

  Future<String?> emailSignUp({String? email, String? password});

  Future<String?> passwordRecovery({String? email});

  Future<String?> confirmPasswordRecovery({String? code, String? newPassword});
  User get currentUser;
}
