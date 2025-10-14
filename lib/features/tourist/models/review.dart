import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

// Define the enum
enum ServiceType { accommodation, attraction, transportation, product }

// Custom converter for ServiceType
class ServiceTypeConverter implements JsonConverter<ServiceType, String> {
  const ServiceTypeConverter();

  @override
  ServiceType fromJson(String json) {
    return ServiceType.values.firstWhere(
      (e) => e.toString().split('.').last == json,
      orElse: () => ServiceType.accommodation, // Default value
    );
  }

  @override
  String toJson(ServiceType object) => object.toString().split('.').last;
}

@JsonSerializable()
class Review {
  final int id;
  final int userId;
  @ServiceTypeConverter()
  final ServiceType serviceType; // Annotate with converter
  final int serviceId;
  final int rating;
  final String comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.serviceType,
    required this.serviceId,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
