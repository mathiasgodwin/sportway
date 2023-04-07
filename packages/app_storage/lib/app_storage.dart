// ignore_for_file: public_member_api_docs

library app_storage;

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_components/google_components.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

abstract class IAppStorage {
  void setString(String key, String value);
  void setUser(User value);
  User? getUser();
  String? getString(String key, {String defValue = ''});
  void delKey(String key);
  void delUser();
  Future<void> initDb();
  String? get uid;
}

/// [AppStorage] is the confidential storage system of the app
/// It's a lot different from App Preference, At least it encrypts most
/// of the data it stores.
class AppStorage implements IAppStorage {
  final _secureStorage =
      const FlutterSecureStorage(aOptions: AndroidOptions(resetOnError: true));

  static const _sportwaySecureStorageBox = 'sportway_secure_storage';
  static const String _userKey = '_sportway_user_key_';

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      lineLength: 50,
      errorMethodCount: 3,
      colors: true,
      printEmojis: true,
    ),
  );

  Future<void> _init() async {
    // if key doesn't exists return null
    try {
      final encryprionKey = await _secureStorage.read(key: 'key');
      if (encryprionKey == null) {
        final key = Hive.generateSecureKey();
        await _secureStorage.write(
          key: 'key',
          value: base64UrlEncode(key),
        );
      }
      final key = await _secureStorage.read(key: 'key');
      final encryptionKey = base64Url.decode(key!);
      await Hive.openBox(_sportwaySecureStorageBox,
          encryptionCipher: HiveAesCipher(encryptionKey));
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> initDb() async {
    Hive.registerAdapter(UserAdapter());
    await _init();
  }

  
  @override
  String? getString(String key, {String defValue = ''}) {
    String? value;
    try {
      value = Hive.box(_sportwaySecureStorageBox).get(key);
    } on Exception catch (e) {
      logger.e(e);
      // await _secureStorage.deleteAll();
    }
    return value;
  }

  @override
  void setString(String key, String value) {
    try {
      Hive.box(_sportwaySecureStorageBox).put(key, value);
    } on Exception catch (e) {
      logger.e(e);
      // await _secureStorage.deleteAll();
    }
  }

  @override
  void delKey(String key) {
    try {
      Hive.box(_sportwaySecureStorageBox).delete(key);
    } catch (e) {
      logger.e(e);
      // await _secureStorage.deleteAll();
    }
  }

  @override
  User? getUser() {
    User? user;
    try {
      user = Hive.box(_sportwaySecureStorageBox).get(_userKey);
    } catch (e) {
      logger.e(e);
    }
    return user;
  }

  @override
  void setUser(User value) {
    try {
      Hive.box(_sportwaySecureStorageBox).put(_userKey, value);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  String? get uid {
    final User user = Hive.box(_sportwaySecureStorageBox).get(_userKey);
    return user.id;
  }

  @override
  void delUser() {
    Hive.box(_sportwaySecureStorageBox).delete(_userKey);
  }

 }
