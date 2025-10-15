import 'package:json_annotation/json_annotation.dart';
import 'package:siwa/features/business/models/business.dart';
import 'package:siwa/features/business/models/business_type.dart';

part 'tour_guide.g.dart';

@JsonSerializable()
class TourGuide extends Business {
  final List<Schedule> schedules;

  TourGuide({
    required super.id,
    required super.name,
    required super.description,
    required super.contactEmail,
    required super.phone,
    required super.locationLat,
    required super.locationLong,
    required super.photos,
    required super.verified,
    required super.verificationDocs,
    required super.createdAt,
    required super.updatedAt,
    this.schedules = const [],
  }) : super(type: BusinessType.tourGuide);

  factory TourGuide.fromJson(Map<String, dynamic> json) =>
      _$TourGuideFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TourGuideToJson(this);
}

@JsonSerializable()
class Schedule {
  final String id;
  final DateTime date;
  final String timeSlot;
  final int maxGuests;
  final bool booked;

  Schedule({
    required this.id,
    required this.date,
    required this.timeSlot,
    required this.maxGuests,
    this.booked = false,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
