import 'package:json_annotation/json_annotation.dart';
import 'package:siwa/features/business/models/business.dart';
import 'package:siwa/features/business/models/business_type.dart';

part 'tour_guide.g.dart';

@JsonSerializable()
class TourGuide extends Business {
  final List<String> expertise; // e.g., 'History', 'Eco-Tours'
  final List<Schedule> schedules;
  final double averageRating;

  TourGuide({
    required super.id,
    required super.name,
    required super.description,
    this.expertise = const [],
    this.schedules = const [],
    this.averageRating = 0.0,
  }) : super(type: BusinessType.tourGuide);

  factory TourGuide.fromJson(Map<String, dynamic> json) => _$TourGuideFromJson(json);
  Map<String, dynamic> toJson() => _$TourGuideToJson(this);
}

@JsonSerializable()
class Schedule {
  final DateTime date;
  final bool available;
  final String tourDescription;

  Schedule({
    required this.date,
    this.available = true,
    required this.tourDescription,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}