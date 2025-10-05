// lib/models/external_service_log.dart
import 'package:json_annotation/json_annotation.dart';

part 'external_service_log.g.dart';

@JsonSerializable()
class ExternalServiceLog {
  final int id;
  final String serviceType;
  final Map<String, dynamic> request;
  final Map<String, dynamic> response;
  final DateTime createdAt;

  ExternalServiceLog({
    required this.id,
    required this.serviceType,
    required this.request,
    required this.response,
    required this.createdAt,
  });

  factory ExternalServiceLog.fromJson(Map<String, dynamic> json) => _$ExternalServiceLogFromJson(json);
  Map<String, dynamic> toJson() => _$ExternalServiceLogToJson(this);
}