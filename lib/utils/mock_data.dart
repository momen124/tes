// lib/utils/mock_data.dart


import 'package:siwa/features/business/models/accommodation.dart';

class MockData {
  static List<Accommodation> accommodations = [
    Accommodation(
      id: 1,
      businessId: 1,
      name: 'Siwa Camp',
      type: 'camp',
      amenities: {'wifi': true},
      capacity: 10,
      price: 50.0,
      availability: {'2025-10-01': true},
      specialRequests: 'None',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    // Add 4-9 more
  ];

  // Similar static lists for other models
}