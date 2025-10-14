// lib/features/business/types/hotel/models/hotel.dart

class Hotel {
  final String id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final List<Room> rooms;
  final List<String> amenities;
  final double rating;
  final int reviewCount;
  final String imageUrl;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rooms,
    required this.amenities,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'rooms': rooms.map((r) => r.toJson()).toList(),
    'amenities': amenities,
    'rating': rating,
    'reviewCount': reviewCount,
    'imageUrl': imageUrl,
  };

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    address: json['address'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    rooms: (json['rooms'] as List).map((r) => Room.fromJson(r)).toList(),
    amenities: List<String>.from(json['amenities']),
    rating: json['rating'],
    reviewCount: json['reviewCount'],
    imageUrl: json['imageUrl'],
  );
}

class Room {
  final String id;
  final String type;
  final double price;
  final List<String> amenities;
  final bool available;
  final List<String> photos;
  final int maxGuests;
  final double size;

  Room({
    required this.id,
    required this.type,
    required this.price,
    required this.amenities,
    this.available = true,
    required this.photos,
    this.maxGuests = 2,
    this.size = 0.0,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'price': price,
    'amenities': amenities,
    'available': available,
    'photos': photos,
    'maxGuests': maxGuests,
    'size': size,
  };

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json['id'],
    type: json['type'],
    price: json['price'],
    amenities: List<String>.from(json['amenities']),
    available: json['available'],
    photos: List<String>.from(json['photos']),
    maxGuests: json['maxGuests'],
    size: json['size'],
  );
}

class Reservation {
  final String id;
  final String guestName;
  final String guestEmail;
  final String roomId;
  final DateTime checkIn;
  final DateTime checkOut;
  final String status;
  final double totalPrice;

  Reservation({
    required this.id,
    required this.guestName,
    required this.guestEmail,
    required this.roomId,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'guestName': guestName,
    'guestEmail': guestEmail,
    'roomId': roomId,
    'checkIn': checkIn.toIso8601String(),
    'checkOut': checkOut.toIso8601String(),
    'status': status,
    'totalPrice': totalPrice,
  };

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
    id: json['id'],
    guestName: json['guestName'],
    guestEmail: json['guestEmail'],
    roomId: json['roomId'],
    checkIn: DateTime.parse(json['checkIn']),
    checkOut: DateTime.parse(json['checkOut']),
    status: json['status'],
    totalPrice: json['totalPrice'],
  );
}
