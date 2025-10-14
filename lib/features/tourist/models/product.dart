// lib/models/product.dart
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final int businessId;
  final String name;
  final String description;
  final double price;
  final int stock;
  final List<dynamic> photos;
  final String shippingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.businessId,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.photos,
    required this.shippingAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
