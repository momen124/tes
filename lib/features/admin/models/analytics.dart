// lib/models/analytics.dart
import 'package:json_annotation/json_annotation.dart';

part 'analytics.g.dart';

@JsonSerializable()
class Analytics {
  final int id;
  final String metricType;
  final Map<String, dynamic> data;
  final DateTime generatedAt;

  Analytics({
    required this.id,
    required this.metricType,
    required this.data,
    required this.generatedAt,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}
