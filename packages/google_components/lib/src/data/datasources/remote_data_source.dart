// ignore_for_file: omit_local_variable_types, body_might_complete_normally_nullable, public_member_api_docs

import 'dart:async';

import 'package:app_storage/app_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_exceptions/firebase_exceptions.dart';
import 'package:google_components/src/data/models/user/user_model.dart'
    as user_model;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

abstract class IRemoteDataSource {
// [Firebase Authentication]
  Future<void> signOut();

  Stream<String> signInWithPhoneNumber({
    required String phoneNumber,
    required Duration timeout,
  });
  //Sends SMS code to the backend for verification, emit error messages, if any.
  Future<void> verifySmsCode({
    required String smsCode,
    required String verificationId,
  });

  Future<bool> isSignedIn();

  Future<String?> googleSignIn();

  Future<String?> emailSignIn({String? email, String? password});

  Future<String?> updateProfile({String? fullName, String? photoUrl});
  Future<String?> batchProfileUpdate({
    String? fullName,
    String? photoUrl,
    String? email,
    String? password,
  });

  Future<String?> emailSignUp({String? email, String? password});

  Future<String?> passwordRecovery({String? email});

  Future<String?> confirmPasswordRecovery({String? code, String? newPassword});
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  user_model.User get currentUser;
}

class RemoteDataSource implements IRemoteDataSource {
  RemoteDataSource({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required AppStorage storage,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _storage = storage;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final AppStorage _storage;

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      lineLength: 50,
      errorMethodCount: 3,
    ),
  );

  /// Firebase Authentication
  ///
  ///
  /// Returns the current cached user.
  /// Defaults to [user_model.User.empty] if there is no cached user.
  @override
  user_model.User get currentUser {
    final user = _storage.getUser();
    if (user == null) {
      return user_model.User.empty;
    } else if (user.isEmpty) {
      return user;
    }

    return user;
  }

  //Sends phone number to the backend, emit error messages, if any.
  @override
  Stream<String> signInWithPhoneNumber({
    required String phoneNumber,
    required Duration timeout,
  }) async* {
    final StreamController<String> streamController =
        StreamController<String>();
    await _firebaseAuth.verifyPhoneNumber(
      timeout: timeout,
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        // Sign the user in (or link) with the auto-generated credential.
        // The feature is currently disabled.
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        streamController.add(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
        throw const PhoneAuthSmsTimeoutError();
      },
      verificationFailed: (FirebaseAuthException e) {
        logger.e(e.message);
        throw PhoneAuthError.fromCode(e.code);
      },
    );
    yield* streamController.stream;
  }

  //Sends SMS code to the backend for verification, emit error messages, if any.
  @override
  Future<void> verifySmsCode({
    required String smsCode,
    required String verificationId,
  }) async {
    try {
      final PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(
        smsCode: smsCode,
        verificationId: verificationId,
      );

      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
    } on FirebaseAuthException catch (e) {
      throw PhoneAuthError.fromCode(e.code);
    } catch (e) {
      throw const PhoneAuthError();
    }
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<String?> googleSignIn() async {
    await _googleSignIn.signOut();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final idToken = await userCredential.user!.getIdToken();
      _storage.setUser(
        user_model.User(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName,
          idToken: idToken,
          email: userCredential.user!.email,
          photoUrl: userCredential.user!.photoURL,
        ),
      );
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithGoogleFailure();
    }
  }

  @override
  Future<String?> emailSignIn({String? email, String? password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      // final idToken = await userCredential.user!.getIdToken();

      _storage.setUser(
        user_model.User(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName,
          // idToken: idToken,
          email: userCredential.user!.email,
          photoUrl: userCredential.user!.photoURL,
        ),
      );

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<String?> emailSignUp({String? email, String? password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!);
      // final idToken = await userCredential.user!.getIdToken();
      _storage.setUser(
        user_model.User(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName,
          // idToken: idToken,
          email: userCredential.user!.email,
          photoUrl: userCredential.user!.photoURL,
        ),
      );

      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<String?> passwordRecovery({String? email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email!);
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw PasswordRecoveryFailure(e.message ?? 'Unknown error');
    } catch (e) {
      throw const PasswordRecoveryFailure();
    }
  }

  @override
  Future<String?> confirmPasswordRecovery({
    String? code,
    String? newPassword,
  }) async {
    try {
      await _firebaseAuth.confirmPasswordReset(
        code: code!,
        newPassword: newPassword!,
      );
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      throw ConfirmPasswordRecoveryFailure.fromCode(e.code);
    } catch (e) {
      throw const ConfirmPasswordRecoveryFailure();
    }
  }

  @override
  Future<void> signOut() async {
    final storage = _storage;

    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      storage.delUser();
    } catch (_) {
      throw LogOutFailure();
    }
  }

  @override
  Future<String?> updateProfile({String? fullName, String? photoUrl}) async {
    final currentUser = _firebaseAuth.currentUser;
    final cachedUser = _storage.getUser();
    try {
      if (photoUrl != null) {
        await currentUser!.updatePhotoURL(photoUrl);
      }
      if (fullName != null) {
        await currentUser!.updateDisplayName(fullName);
      }
      _storage
          .setUser(cachedUser!.copyWith(name: fullName, photoUrl: photoUrl));
      await currentUser!.reload();
    } on FirebaseAuthException catch (e) {
      throw UpdateProfileException(e.code);
    } catch (e) {
      throw const UpdateProfileException();
    }
  }

  @override
  Future<String?> batchProfileUpdate({
    String? fullName,
    String? photoUrl,
    String? email,
    String? password,
  }) async {
    final currentUser = _firebaseAuth.currentUser;
    final cachedUser = _storage.getUser();

    try {
      if (fullName != null) {
        await currentUser!.updateDisplayName(fullName);
      }

      _storage.setUser(
        cachedUser!.copyWith(name: fullName),
      );
      await currentUser!.reload();
    } on FirebaseAuthException catch (e) {
      throw UpdateProfileException(e.code);
    } catch (e) {
      throw const UpdateProfileException();
    }
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final currentUser = _firebaseAuth.currentUser;
    final cachedUser = _storage.getUser();
    try {
      final emailAuth = EmailAuthProvider.credential(
        email: cachedUser!.email!,
        password: oldPassword,
      );
      await currentUser?.reauthenticateWithCredential(emailAuth);
      await currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw ChangePasswordException(e.code);
    } catch (e) {
      throw const ChangePasswordException();
    }
  }
}
