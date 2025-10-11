// lib/features/business/models/business_type.dart

enum BusinessType { tourGuide, hotel, rental, restaurant, store, transportation, tripBooking }

extension BusinessTypeExtension on BusinessType {
  String get displayName {
    switch (this) {
      case BusinessType.hotel:
        return 'Hotel';
      case BusinessType.restaurant:
        return 'Restaurant';
      case BusinessType.store:
        return 'Store';
      case BusinessType.rental:
        return 'Rental';
      case BusinessType.tourGuide:
        return 'Tour Guide';
      case BusinessType.transportation:
        return 'Transportation';
      case BusinessType.tripBooking:
        return 'Trip Booking';
    }
  }

  String get value {
    switch (this) {
      case BusinessType.hotel:
        return 'hotel';
      case BusinessType.restaurant:
        return 'restaurant';
      case BusinessType.store:
        return 'store';
      case BusinessType.rental:
        return 'rental';
      case BusinessType.tourGuide:
        return 'tour_guide';
      case BusinessType.transportation:
        return 'transportation';
      case BusinessType.tripBooking:
        return 'trip_booking';
    }
  }

  static BusinessType fromString(String value) {
    switch (value) {
      case 'hotel':
        return BusinessType.hotel;
      case 'restaurant':
        return BusinessType.restaurant;
      case 'store':
        return BusinessType.store;
      case 'rental':
        return BusinessType.rental;
      case 'tour_guide':
        return BusinessType.tourGuide;
      case 'transportation':
        return BusinessType.transportation;
      case 'trip_booking':
        return BusinessType.tripBooking;
      default:
        throw Exception('Unknown business type: $value');
    }
  }
}