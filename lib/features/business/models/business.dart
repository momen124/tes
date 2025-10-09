// lib/features/business/models/business.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:siwa/features/business/models/business_type.dart';

part 'business.g.dart';

@JsonSerializable()
class Business {
  final int id;
  final String name;
  @JsonKey(
    fromJson: _businessTypeFromJson,
    toJson: _businessTypeToJson,
  )
  final BusinessType type;
  final String contactEmail;
  final String phone;
  final double locationLat;
  final double locationLong;
  final String description;
  final List<dynamic> photos;
  final bool verified;
  final List<dynamic> verificationDocs;
  final DateTime createdAt;
  final DateTime updatedAt;

  Business({
    required this.id,
    required this.name,
    required this.type,
    required this.contactEmail,
    required this.phone,
    required this.locationLat,
    required this.locationLong,
    required this.description,
    required this.photos,
    required this.verified,
    required this.verificationDocs,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Business.fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessToJson(this);

  static BusinessType _businessTypeFromJson(dynamic value) {
    if (value is String) {
      try {
        return BusinessType.values.firstWhere((e) => e.value == value);
      } catch (_) {
        throw Exception('Invalid business type: $value');
      }
    }
    throw Exception('Invalid business type: $value');
  }

  static String _businessTypeToJson(BusinessType type) {
    return type.value;
  }
}