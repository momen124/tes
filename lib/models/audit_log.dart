// lib/models/audit_log.dart
import 'package:json_annotation/json_annotation.dart';

part 'audit_log.g.dart';

@JsonSerializable()
class AuditLog {
  final int id;
  final int adminId;
  final String actionType;
  final Map<String, dynamic> details;
  final DateTime createdAt;

  AuditLog({
    required this.id,
    required this.adminId,
    required this.actionType,
    required this.details,
    required this.createdAt,
  });

  factory AuditLog.fromJson(Map<String, dynamic> json) => _$AuditLogFromJson(json);
  Map<String, dynamic> toJson() => _$AuditLogToJson(this);
}