// lib/models/accommodation.dart
import 'package:json_annotation/json_annotation.dart';

part 'accommodation.g.dart';

@JsonSerializable()
class Accommodation {
  final int id;
  final int businessId;
  final String name;
  final String type;
  final Map<String, dynamic> amenities;
  final int capacity;
  final double price;
  final Map<String, dynamic> availability;
  final String specialRequests;
  final DateTime createdAt;
  final DateTime updatedAt;

  Accommodation({
    required this.id,
    required this.businessId,
    required this.name,
    required this.type,
    required this.amenities,
    required this.capacity,
    required this.price,
    required this.availability,
    required this.specialRequests,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Accommodation.fromJson(Map<String, dynamic> json) => _$AccommodationFromJson(json);
  Map<String, dynamic> toJson() => _$AccommodationToJson(this);
}