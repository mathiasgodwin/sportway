import 'package:app_storage/app_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storage/dto/interest_dto.dart';

/// An abstract class defining the contract for cloud storage operations related to sport interests.
abstract class ICloudStorage {
  /// Saves a [SportInterest] object to the cloud storage.
  Future<void> saveInterest(SportInterest interest);

  /// Retrieves a list of [SportInterest] objects from cloud storage.
  Future<List<SportInterest>> getInterests();
}

/// Implementation of [ICloudStorage] for Firebase Cloud Storage.
class CloudStorage implements ICloudStorage {
  final _usersDbCollection = 'sportway_users';
  final _interestCollection = 'interests';
  final _storage = AppStorage();
  final firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveInterest(SportInterest interest) async {
    final userId = _storage.getUser()!.id;

    try {
      // Save the interest to the user's collection in Firestore.
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
    } catch (e) {
      // Handle any errors that may occur during the save operation.
    }
  }

  @override
  Future<List<SportInterest>> getInterests() async {
    final userId = _storage.getUser()!.id;
    final interestList = <SportInterest>[];

    try {
      // Retrieve the user's collection of interests from Firestore.
      final db = firestore
          .collection(_usersDbCollection)
          .doc(userId)
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
      // Rethrow any exceptions that occur during the retrieval process.
      rethrow;
    }

    return interestList;
  }
}
