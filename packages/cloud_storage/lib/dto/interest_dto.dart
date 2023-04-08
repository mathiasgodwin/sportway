// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SportInterest extends Equatable {
  const SportInterest({
    required this.name,
    required this.id,
  });

  final String name;
  final String id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory SportInterest.fromMap(Map<String, dynamic> map) {
    return SportInterest(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SportInterest.fromJson(String source) =>
      SportInterest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [name, id];
}
