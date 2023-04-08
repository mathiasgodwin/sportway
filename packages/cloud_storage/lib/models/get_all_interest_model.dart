// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_storage/dto/interest_dto.dart';
import 'package:equatable/equatable.dart';

class InterestsModel extends Equatable {
  const InterestsModel({
    required this.interests,
  });
  final List<SportInterest> interests;

  @override
  List<Object> get props => [interests];

  InterestsModel copyWith({
    List<SportInterest>? interests,
  }) {
    return InterestsModel(
      interests: interests ?? this.interests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'interests': interests.map((x) => x.toMap()).toList(),
    };
  }

  factory InterestsModel.fromMap(Map<String, dynamic> map) {
    return InterestsModel(
      interests: List<SportInterest>.from(
        (map['interests'] as List<int>).map<SportInterest>(
          (x) => SportInterest.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory InterestsModel.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return InterestsModel(
      interests: List<SportInterest>.from(
        (data['interests'] as List<int>).map<SportInterest>(
          (x) => SportInterest.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestsModel.fromJson(String source) =>
      InterestsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
