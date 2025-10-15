// lib/models/user.dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String username;
  final String passwordHash;
  final String role;
  final String? ageRange;
  final String? preferredLanguage;
  final Map<String, dynamic>? preferences;
  final String? referralCode;
  final bool gpsConsent;
  final bool mfaEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.passwordHash,
    required this.role,
    this.ageRange,
    this.preferredLanguage,
    this.preferences,
    this.referralCode,
    required this.gpsConsent,
    required this.mfaEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
