library cloud_storage;

import 'package:app_storage/app_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storage/dto/interest_dto.dart';
import 'package:cloud_storage/models/get_all_interest_model.dart';

abstract class ICloudStorage {
  Future<void> saveInterest(SportInterest interest);
  Future<List<SportInterest>> getInterests();
}

/// Implementation of [ICloudStorage]
class CloudStorage implements ICloudStorage {
  final _usersDbCollection = 'sportway_users';
  final _interestCollection = 'interests';
  final _storage = AppStorage();
  final firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveInterest(SportInterest interest) async {
    final userId = _storage.getUser()!.id;
    try {
      await firestore
          .collection(_usersDbCollection)
          .doc(userId)
          .collection(_interestCollection)
          .withConverter<SportInterest>(
            fromFirestore: (snapshot, _) =>
                SportInterest.fromMap(snapshot.data()!),
            toFirestore: (model, _) => model.toMap(),
          )
          .doc(interest.id)
          .set(interest);
    } catch (e) {}
  }

  @override
  Future<List<SportInterest>> getInterests() async {
    final userId = _storage.getUser()!.id;
    final interestList = <SportInterest>[];

    try {
      final db = firestore
          .collection(_usersDbCollection)
          .doc(
            userId,
          )
          .collection(_interestCollection)
          .withConverter<SportInterest>(
            fromFirestore: (snapshot, _) =>
                SportInterest.fromMap(snapshot.data()!),
            toFirestore: (model, _) => model.toMap(),
          );
      final data = await db.get();
      for (final e in data.docs) {
        interestList.add(e.data());
      }
    } catch (e) {
      rethrow;
    }

    return interestList;
  }
}
