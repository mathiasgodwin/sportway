// ignore_for_file: public_member_api_docs

import 'package:google_components/src/data/datasources/remote_data_source.dart';
import 'package:google_components/src/data/models/user/user_model.dart';
import 'package:google_components/src/domain/domain.dart';
import 'package:logger/logger.dart';

/// GoogleComponents repository implementation
class GoogleComponentsRepository implements IGoogleComponentsRepository {
  /// GoogleComponents repository constructor
  GoogleComponentsRepository({
    required this.remoteDataSource,
  });

  final RemoteDataSource remoteDataSource;

  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      lineLength: 50,
      errorMethodCount: 3,
      colors: true,
      printEmojis: true,
    ),
  );

  /// Firebase Authentication
  @override
  Future<void> signOut() async {
    try {
      await remoteDataSource.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<String> signInWithPhoneNumber({
    required String phoneNumber,
    Duration? timeout,
  }) async* {
    final tO = timeout ?? const Duration(seconds: 30);
    try {
      final response = remoteDataSource.signInWithPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: tO,
      );
      yield* response;
    } catch (e) {
      rethrow;
    }
  }

  //Sends SMS code to the backend for verification, emit error messages, if any.
  @override
  Future<void> verifySmsCode({
    required String smsCode,
    required String verificationId,
  }) async {
    try {
      await remoteDataSource.verifySmsCode(
        smsCode: smsCode,
        verificationId: verificationId,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> confirmPasswordRecovery({
    String? code,
    String? newPassword,
  }) async {
    try {
      final response = await remoteDataSource.confirmPasswordRecovery(
        code: code,
        newPassword: newPassword,
      );
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String?> emailSignIn({String? email, String? password}) async {
    try {
      final response =
          await remoteDataSource.emailSignIn(email: email, password: password);
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String?> emailSignUp({String? email, String? password}) async {
    try {
      final response =
          await remoteDataSource.emailSignUp(email: email, password: password);
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String?> googleSignIn() async {
    try {
      await remoteDataSource.googleSignIn();
    } catch (e, s) {
      print(s);
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      final response = await remoteDataSource.isSignedIn();
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  User get currentUser {
    try {
      final response = remoteDataSource.currentUser;
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String?> passwordRecovery({String? email}) async {
    try {
      final response = await remoteDataSource.passwordRecovery(email: email);
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String?> updateProfile({
    String? fullName,
    String? photoUrl,
  }) async {
    try {
      final response = await remoteDataSource.updateProfile(
          fullName: fullName, photoUrl: photoUrl);
      return response;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<String?> batchProfileUpdate({
    String? fullName,
    String? photoUrl,
    String? email,
    String? password,
  }) async {
    try {
      await remoteDataSource.batchProfileUpdate(
        fullName: fullName,
        photoUrl: photoUrl,
        email: email,
        password: password,
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
