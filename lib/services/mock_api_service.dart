// lib/services/mock_api_service.dart


import 'package:siwa/features/auth/models/user.dart';
import 'package:siwa/features/business/models/accommodation.dart';
import 'package:siwa/features/business/models/business.dart';

class MockApiService {
  final List<User> _users = [
    User(
      id: 1,
      email: 'tourist@example.com',
      username: 'tourist1',
      passwordHash: 'password1',
      role: 'tourist',
      gpsConsent: true,
      mfaEnabled: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  // ignore: unused_field
  final List<Business> _businesses = [
    Business(
      id: 1,
      name: 'Siwa Hotel',
      type: 'hotel',
      contactEmail: 'info@siwahotel.com',
      phone: '1234567890',
      locationLat: 29.2,
      locationLong: 25.5,
      description: 'Luxury hotel in Siwa',
      photos: [],
      verified: true,
      verificationDocs: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final List<Accommodation> _accommodations = [
    Accommodation(
      id: 1,
      name: 'Siwa Oasis Lodge',
      type: 'lodge',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      businessId: 1,
      amenities: {},
      capacity: 30,
      price: 80.0,
      availability: {},
      specialRequests: '',
    ),
  ];

  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return _users.firstWhere((u) => u.email == email && u.passwordHash == password, orElse: () => throw Exception('Invalid credentials'));
  }

  Future<List<dynamic>> searchServices(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    return _accommodations.where((a) => a.name.contains(query)).toList();
  }
}