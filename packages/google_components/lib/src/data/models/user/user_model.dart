// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'user_model.g.dart';

/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
///

@HiveType(typeId: 1)
class User extends Equatable {
  const User({
    required this.id,
    this.backendAuthorized,
    this.email,
    this.name,
    this.idToken,
    this.photoUrl,
  });

  /// The current user's email address.
  @HiveField(1)
  final String? email;

  /// The current user's id.
  @HiveField(2)
  final String id;

  /// The current user's name (display name).
  @HiveField(3)
  final String? name;

  /// Url for the current user's photoUrl.
  @HiveField(4)
  final String? photoUrl;

  @HiveField(5)
  final bool? backendAuthorized;

  @HiveField(6)
  final String? idToken;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [
        email,
        id,
        name,
        photoUrl,
        backendAuthorized,
        idToken,
      ];

  User copyWith({
    String? email,
    String? id,
    String? name,
    String? idToken,
    String? photoUrl,
    bool? backendAuthorized,
    bool? empty,
    bool? isEmpty,
    bool? isNotEmpty,
  }) {
    return User(
      email: email ?? this.email,
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      backendAuthorized: backendAuthorized ?? this.backendAuthorized,
      name: name ?? this.name,
      idToken: idToken,
    );
  }
}
