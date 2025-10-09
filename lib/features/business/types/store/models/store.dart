import 'package:json_annotation/json_annotation.dart';
import 'package:siwa/features/business/models/business.dart';
import 'package:siwa/features/business/models/business_type.dart';

part 'store.g.dart';

@JsonSerializable()
class Store extends Business {
  final List<Product> inventory;
  final List<String> categories;
  final double salesVolume;

  Store({
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
    this.inventory = const [],
    this.categories = const [],
    this.salesVolume = 0.0,
  }) : super(type: BusinessType.store);

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}

@JsonSerializable()
class Product {
  final String id;
  final String name;
  final double price;
  final int stock;
  final List<String> photos;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.photos,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}