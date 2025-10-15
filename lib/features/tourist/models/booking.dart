// lib/models/booking.dart
import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

enum ServiceType { accommodation, transportation, attraction, product }

enum BookingStatus { pending, confirmed, cancelled, completed }

@JsonSerializable()
class Booking {
  final int id;
  final int userId;
  final ServiceType serviceType;
  final int serviceId;
  final DateTime bookingDate;
  final Map<String, dynamic> details;
  final BookingStatus status;
  final double commission;
  final String paymentToken;
  final bool offlineSync;
  final DateTime createdAt;
  final DateTime updatedAt;

  Booking({
    required this.id,
    required this.userId,
    required this.serviceType,
    required this.serviceId,
    required this.bookingDate,
    required this.details,
    required this.status,
    required this.commission,
    required this.paymentToken,
    required this.offlineSync,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
