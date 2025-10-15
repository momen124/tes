import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/data/mock_data_repository_ar.dart';

// Provider to track current locale
final currentLocaleProvider = StateProvider<Locale>((ref) => const Locale('en'));

// Provider that returns the appropriate data based on locale
final mockDataProvider = Provider<dynamic>((ref) {
  final locale = ref.watch(currentLocaleProvider);
  return locale.languageCode == 'ar' ? mockDataAr : mockData;
});

// Convenience methods that work with both repository types
final restaurantsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllRestaurants();
});

final hotelsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllHotels();
});

final guidesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllTourGuides();
});

final transportationProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllTransportation();
});

final attractionsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllAttractions();
});

final productsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllProducts();
});

final bookingsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllBookings();
});

final reviewsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllReviews();
});

final badgesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllBadges();
});

final otherProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final data = ref.watch(mockDataProvider);
  return data.getAllOther();
});