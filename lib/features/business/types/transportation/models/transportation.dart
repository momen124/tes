// lib/features/business/types/transportation/models/transportation.dart

// lib/features/business/types/transportation/models/transportation.dart

class TransportationService {
  final String id;
  final String businessId;
  final String name;
  final String type;
  final List<Vehicle> vehicles;
  final List<Route> routes;
  final double rating;
  final int reviewCount;

  TransportationService({
    required this.id,
    required this.businessId,
    required this.name,
    required this.type,
    required this.vehicles,
    required this.routes,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'businessId': businessId,
    'name': name,
    'type': type,
    'vehicles': vehicles.map((v) => v.toJson()).toList(),
    'routes': routes.map((r) => r.toJson()).toList(),
    'rating': rating,
    'reviewCount': reviewCount,
  };

  factory TransportationService.fromJson(Map<String, dynamic> json) =>
      TransportationService(
        id: json['id'],
        businessId: json['businessId'],
        name: json['name'],
        type: json['type'],
        vehicles: (json['vehicles'] as List)
            .map((v) => Vehicle.fromJson(v))
            .toList(),
        routes: (json['routes'] as List).map((r) => Route.fromJson(r)).toList(),
        rating: json['rating'] as double? ?? 0.0,
        reviewCount: json['reviewCount'] as int? ?? 0,
      );
}

class Vehicle {
  final String id;
  final String type;
  final String licensePlate;
  final String driver;
  final bool driverVerified;
  final double rate;
  final String routes;
  final int capacity;
  final List<String> amenities;
  final bool available;

  Vehicle({
    required this.id,
    required this.type,
    required this.licensePlate,
    required this.driver,
    this.driverVerified = false,
    required this.rate,
    required this.routes,
    this.capacity = 4,
    this.amenities = const [],
    this.available = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'licensePlate': licensePlate,
    'driver': driver,
    'driverVerified': driverVerified,
    'rate': rate,
    'routes': routes,
    'capacity': capacity,
    'amenities': amenities,
    'available': available,
  };

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json['id'],
    type: json['type'],
    licensePlate: json['licensePlate'],
    driver: json['driver'],
    driverVerified: json['driverVerified'] as bool? ?? false,
    rate: json['rate'] as double? ?? 0.0,
    routes: json['routes'],
    capacity: json['capacity'] as int? ?? 4,
    amenities: List<String>.from(json['amenities'] as List<dynamic>? ?? []),
    available: json['available'] as bool? ?? true,
  );
}

class Route {
  final String id;
  final String name;
  final String startLocation;
  final String endLocation;
  final List<RouteStop> stops;
  final double distance;
  final String duration;
  final double price;

  Route({
    required this.id,
    required this.name,
    required this.startLocation,
    required this.endLocation,
    required this.stops,
    required this.distance,
    required this.duration,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'startLocation': startLocation,
    'endLocation': endLocation,
    'stops': stops.map((s) => s.toJson()).toList(),
    'distance': distance,
    'duration': duration,
    'price': price,
  };

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json['id'],
    name: json['name'],
    startLocation: json['startLocation'],
    endLocation: json['endLocation'],
    stops: (json['stops'] as List).map((s) => RouteStop.fromJson(s)).toList(),
    distance: json['distance'],
    duration: json['duration'],
    price: json['price'],
  );
}

class RouteStop {
  final String name;
  final double latitude;
  final double longitude;
  final int order;

  RouteStop({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.order,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
    'order': order,
  };

  factory RouteStop.fromJson(Map<String, dynamic> json) => RouteStop(
    name: json['name'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    order: json['order'],
  );
}

class TransportationBooking {
  final String id;
  final String vehicleId;
  final String userId;
  final String userName;
  final String routeId;
  final DateTime pickupTime;
  final String pickupLocation;
  final String dropoffLocation;
  final int passengers;
  final double totalPrice;
  final String status;

  TransportationBooking({
    required this.id,
    required this.vehicleId,
    required this.userId,
    required this.userName,
    required this.routeId,
    required this.pickupTime,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.passengers,
    required this.totalPrice,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'vehicleId': vehicleId,
    'userId': userId,
    'userName': userName,
    'routeId': routeId,
    'pickupTime': pickupTime.toIso8601String(),
    'pickupLocation': pickupLocation,
    'dropoffLocation': dropoffLocation,
    'passengers': passengers,
    'totalPrice': totalPrice,
    'status': status,
  };

  factory TransportationBooking.fromJson(Map<String, dynamic> json) =>
      TransportationBooking(
        id: json['id'],
        vehicleId: json['vehicleId'],
        userId: json['userId'],
        userName: json['userName'],
        routeId: json['routeId'],
        pickupTime: DateTime.parse(json['pickupTime']),
        pickupLocation: json['pickupLocation'],
        dropoffLocation: json['dropoffLocation'],
        passengers: json['passengers'],
        totalPrice: json['totalPrice'],
        status: json['status'],
      );
}