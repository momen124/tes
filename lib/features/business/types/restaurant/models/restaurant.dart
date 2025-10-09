import 'package:json_annotation/json_annotation.dart';
import 'package:siwa/features/business/models/business.dart';
import 'package:siwa/features/business/models/business_type.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant extends Business {
  final List<MenuItem> menu;
  final int seatingCapacity;
  final List<String> categories;

  Restaurant({
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
    this.menu = const [],
    this.seatingCapacity = 0,
    this.categories = const [],
  }) : super(type: BusinessType.restaurant);

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}

@JsonSerializable()
class MenuItem {
  final String id;
  final String name;
  final double price;
  final List<String> ingredients;
  final String category;
  final List<String> photos;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.category,
    required this.photos,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}