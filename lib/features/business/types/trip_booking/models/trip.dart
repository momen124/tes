// lib/features/business/types/trip_booking/models/trip.dart

class Trip {
  final String id;
  final String businessId;
  final String title;
  final String description;
  final List<ItineraryStop> itinerary;
  final double price;
  final int maxParticipants;
  final int currentParticipants;
  final String duration;
  final List<String> included;
  final List<String> requirements;
  final String difficultyLevel;
  final List<String> images;
  final double rating;
  final int reviewCount;

  Trip({
    required this.id,
    required this.businessId,
    required this.title,
    required this.description,
    required this.itinerary,
    required this.price,
    required this.maxParticipants,
    this.currentParticipants = 0,
    required this.duration,
    required this.included,
    required this.requirements,
    this.difficultyLevel = 'moderate',
    required this.images,
    this.rating = 0.0,
    this.reviewCount = 0,
  });

  bool get isFull => currentParticipants >= maxParticipants;

  Map<String, dynamic> toJson() => {
        'id': id,
        'businessId': businessId,
        'title': title,
        'description': description,
        'itinerary': itinerary.map((i) => i.toJson()).toList(),
        'price': price,
        'maxParticipants': maxParticipants,
        'currentParticipants': currentParticipants,
        'duration': duration,
        'included': included,
        'requirements': requirements,
        'difficultyLevel': difficultyLevel,
        'images': images,
        'rating': rating,
        'reviewCount': reviewCount,
      };

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json['id'],
        businessId: json['businessId'],
        title: json['title'],
        description: json['description'],
        itinerary: (json['itinerary'] as List)
            .map((i) => ItineraryStop.fromJson(i))
            .toList(),
        price: json['price'],
        maxParticipants: json['maxParticipants'],
        currentParticipants: json['currentParticipants'] ?? 0,
        duration: json['duration'],
        included: List<String>.from(json['included']),
        requirements: List<String>.from(json['requirements']),
        difficultyLevel: json['difficultyLevel'] ?? 'moderate',
        images: List<String>.from(json['images']),
        rating: json['rating'] ?? 0.0,
        reviewCount: json['reviewCount'] ?? 0,
      );
}

class ItineraryStop {
  final String id;
  final String title;
  final String time;
  final String duration;
  final String description;
  final double? latitude;
  final double? longitude;
  final int order;

  ItineraryStop({
    required this.id,
    required this.title,
    required this.time,
    required this.duration,
    required this.description,
    this.latitude,
    this.longitude,
    required this.order,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'time': time,
        'duration': duration,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'order': order,
      };

  factory ItineraryStop.fromJson(Map<String, dynamic> json) => ItineraryStop(
        id: json['id'],
        title: json['title'],
        time: json['time'],
        duration: json['duration'],
        description: json['description'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        order: json['order'],
      );
}

class TripBooking {
  final String id;
  final String tripId;
  final String userId;
  final String userName;
  final int numberOfPeople;
  final DateTime bookingDate;
  final DateTime tripDate;
  final double totalPrice;
  final String status;
  final String? specialRequests;

  TripBooking({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.userName,
    required this.numberOfPeople,
    required this.bookingDate,
    required this.tripDate,
    required this.totalPrice,
    required this.status,
    this.specialRequests,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'tripId': tripId,
        'userId': userId,
        'userName': userName,
        'numberOfPeople': numberOfPeople,
        'bookingDate': bookingDate.toIso8601String(),
        'tripDate': tripDate.toIso8601String(),
        'totalPrice': totalPrice,
        'status': status,
        'specialRequests': specialRequests,
      };

  factory TripBooking.fromJson(Map<String, dynamic> json) => TripBooking(
        id: json['id'],
        tripId: json['tripId'],
        userId: json['userId'],
        userName: json['userName'],
        numberOfPeople: json['numberOfPeople'],
        bookingDate: DateTime.parse(json['bookingDate']),
        tripDate: DateTime.parse(json['tripDate']),
        totalPrice: json['totalPrice'],
        status: json['status'],
        specialRequests: json['specialRequests'],
      );
}

class TripSchedule {
  final String id;
  final String tripId;
  final DateTime date;
  final String status;
  final int availableSlots;

  TripSchedule({
    required this.id,
    required this.tripId,
    required this.date,
    this.status = 'available',
    required this.availableSlots,
  });

  bool get isAvailable => status == 'available' && availableSlots > 0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'tripId': tripId,
        'date': date.toIso8601String(),
        'status': status,
        'availableSlots': availableSlots,
      };

  factory TripSchedule.fromJson(Map<String, dynamic> json) => TripSchedule(
        id: json['id'],
        tripId: json['tripId'],
        date: DateTime.parse(json['date']),
        status: json['status'] ?? 'available',
        availableSlots: json['availableSlots'],
      );
}