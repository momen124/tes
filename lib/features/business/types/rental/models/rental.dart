import 'package:json_annotation/json_annotation.dart';
import 'package:siwa/features/business/models/business.dart';
import 'package:siwa/features/business/models/business_type.dart';

part 'rental.g.dart';

@JsonSerializable()
class Rental extends Business {
  final List<FleetItem> fleet;
  final List<RentalHistory> history;
  final double averageRate;

  Rental({
    required super.id,
    required super.name,
    required super.description,
    this.fleet = const [],
    this.history = const [],
    this.averageRate = 0.0,
  }) : super(type: BusinessType.rental);

  factory Rental.fromJson(Map<String, dynamic> json) => _$RentalFromJson(json);
  Map<String, dynamic> toJson() => _$RentalToJson(this);
}

@JsonSerializable()
class FleetItem {
  final String id;
  final String type; // e.g., "Car", "Bicycle"
  final double ratePerHour;
  final bool available;
  final List<String> photos;
  final String terms;

  FleetItem({
    required this.id,
    required this.type,
    required this.ratePerHour,
    this.available = true,
    required this.photos,
    required this.terms,
  });

  factory FleetItem.fromJson(Map<String, dynamic> json) => _$FleetItemFromJson(json);
  Map<String, dynamic> toJson() => _$FleetItemToJson(this);
}

@JsonSerializable()
class RentalHistory {
  final String id;
  final String guestName;
  final String itemId;
  final DateTime startTime;
  final DateTime endTime;
  final double totalCost;

  RentalHistory({
    required this.id,
    required this.guestName,
    required this.itemId,
    required this.startTime,
    required this.endTime,
    required this.totalCost,
  });

  factory RentalHistory.fromJson(Map<String, dynamic> json) => _$RentalHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$RentalHistoryToJson(this);
}