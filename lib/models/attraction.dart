// lib/models/attraction.dart
import 'package:json_annotation/json_annotation.dart';

part 'attraction.g.dart';

@JsonSerializable()
class Attraction {
  final int id;
  final int businessId;
  final String name;
  final String description;
  final Map<String, dynamic> schedule;
  final double price;
  final int groupLimit;
  final String culturalDetails;
  final bool premiumFlag;
  final DateTime createdAt;
  final DateTime updatedAt;

  Attraction({
    required this.id,
    required this.businessId,
    required this.name,
    required this.description,
    required this.schedule,
    required this.price,
    required this.groupLimit,
    required this.culturalDetails,
    required this.premiumFlag,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) => _$AttractionFromJson(json);
  Map<String, dynamic> toJson() => _$AttractionToJson(this);
}