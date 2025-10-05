// lib/models/transportation.dart
import 'package:json_annotation/json_annotation.dart';

part 'transportation.g.dart';

@JsonSerializable()
class Transportation {
  final int id;
  final int businessId;
  final String vehicleType;
  final double rates;
  final String routes;
  final String driverContact;
  final bool driverVerified;
  final Map<String, dynamic> availability;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transportation({
    required this.id,
    required this.businessId,
    required this.vehicleType,
    required this.rates,
    required this.routes,
    required this.driverContact,
    required this.driverVerified,
    required this.availability,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transportation.fromJson(Map<String, dynamic> json) => _$TransportationFromJson(json);
  Map<String, dynamic> toJson() => _$TransportationToJson(this);
}