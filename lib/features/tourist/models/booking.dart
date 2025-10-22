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

  // === إضافة: من Map إلى Booking ===
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] as int,
      userId: map['userId'] as int,
      serviceType: ServiceType.values.firstWhere(
        (e) => e.name == map['serviceType'],
        orElse: () => ServiceType.product,
      ),
      serviceId: map['serviceId'] as int,
      bookingDate: DateTime.parse(map['bookingDate'] as String),
      details: map['details'] as Map<String, dynamic>,
      status: BookingStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => BookingStatus.pending,
      ),
      commission: (map['commission'] as num).toDouble(),
      paymentToken: map['paymentToken'] as String,
      offlineSync: map['offlineSync'] as bool? ?? false,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  // === إضافة: من Booking إلى Map (للحفظ المحلي أو الإرسال) ===
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'serviceType': serviceType.name,
      'serviceId': serviceId,
      'bookingDate': bookingDate.toIso8601String(),
      'details': details,
      'status': status.name,
      'commission': commission,
      'paymentToken': paymentToken,
      'offlineSync': offlineSync,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}