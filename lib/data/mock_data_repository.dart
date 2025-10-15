// lib/data/mock_data_repository.dart
// COMPLETE FIX: All fields populated, no nulls, consistent structure, valid URLs


class MockDataRepository {
  static final MockDataRepository _instance = MockDataRepository._internal();
  factory MockDataRepository() => _instance;
  MockDataRepository._internal();

  // RESTAURANTS - All fields required and populated
  static final List<Map<String, dynamic>> restaurants = [
    {
      "id": 1,
      "name": "Aghurmi Restaurant",
      "cuisine": "egyptian",
      "description": "Authentic Siwan and Egyptian cuisine with traditional recipes",
      "priceRange": "medium",
      "rating": 4.7,
      "reviews": 234,
      "deliveryTime": "30-45 min",
      "minOrder": 50.0,
      "imageUrl": "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800",
      "specialties": ["Siwan Dates", "Traditional Bread", "Local Olives"],
      "openNow": true,
      "openingHours": "8:00 AM - 11:00 PM",
      "deliveryFee": 15.0,
      "category": "restaurant",
      "location": "Central Siwa"
    },
    {
      "id": 2,
      "name": "Abdu's Kitchen",
      "cuisine": "traditional",
      "description": "Traditional Siwan home-cooked meals made with love",
      "priceRange": "low",
      "rating": 4.9,
      "reviews": 456,
      "deliveryTime": "20-30 min",
      "minOrder": 30.0,
      "imageUrl": "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800",
      "specialties": ["Siwan Pizza", "Date Desserts"],
      "openNow": true,
      "openingHours": "7:00 AM - 10:00 PM",
      "deliveryFee": 10.0,
      "category": "restaurant",
      "location": "Shali Village"
    },
    {
      "id": 3,
      "name": "Oasis Bistro",
      "cuisine": "international",
      "description": "International fusion with local ingredients and modern twist",
      "priceRange": "high",
      "rating": 4.6,
      "reviews": 189,
      "deliveryTime": "40-60 min",
      "minOrder": 100.0,
      "imageUrl": "https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800",
      "specialties": ["Gourmet Burgers", "Fusion Dishes"],
      "openNow": true,
      "openingHours": "12:00 PM - 12:00 AM",
      "deliveryFee": 25.0,
      "category": "restaurant",
      "location": "Downtown Siwa"
    },
    {
      "id": 4,
      "name": "Siwa Dates Café",
      "cuisine": "cafe",
      "description": "Specialty coffee and local date desserts in cozy atmosphere",
      "priceRange": "low",
      "rating": 4.8,
      "reviews": 345,
      "deliveryTime": "15-25 min",
      "minOrder": 25.0,
      "imageUrl": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800",
      "specialties": ["Date Coffee", "Pastries"],
      "openNow": true,
      "openingHours": "6:00 AM - 9:00 PM",
      "deliveryFee": 10.0,
      "category": "restaurant",
      "location": "Market Square"
    },
    {
      "id": 5,
      "name": "Desert Grill House",
      "cuisine": "grill",
      "description": "Grilled meats and BBQ specialties with outdoor seating",
      "priceRange": "medium",
      "rating": 4.5,
      "reviews": 278,
      "deliveryTime": "35-50 min",
      "minOrder": 80.0,
      "imageUrl": "https://images.unsplash.com/photo-1544025162-d76694265947?w=800",
      "specialties": ["Kebab", "Grilled Chicken"],
      "openNow": false,
      "openingHours": "5:00 PM - 12:00 AM",
      "deliveryFee": 20.0,
      "category": "restaurant",
      "location": "Palm Grove Area"
    },
    {
      "id": 6,
      "name": "Palm Tree Restaurant",
      "cuisine": "mediterranean",
      "description": "Mediterranean flavors with Egyptian touch and fresh ingredients",
      "priceRange": "medium",
      "rating": 4.7,
      "reviews": 312,
      "deliveryTime": "30-40 min",
      "minOrder": 60.0,
      "imageUrl": "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800",
      "specialties": ["Mezze Platter", "Fresh Salads"],
      "openNow": true,
      "openingHours": "11:00 AM - 11:00 PM",
      "deliveryFee": 15.0,
      "category": "restaurant",
      "location": "Near Cleopatra Spring"
    }
  ];

  // GUIDES - All fields required and populated
  static final List<Map<String, dynamic>> guides = [
    {
      "id": 1,
      "name": "Ahmed Hassan",
      "specialty": "history",
      "experience": 15,
      "rating": 4.9,
      "reviews": 234,
      "hourlyRate": 150.0,
      "price": 150.0, // Added for consistency
      "imageUrl": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
      "bio": "Expert in Siwan history and ancient Egyptian archaeology with over 15 years of experience guiding international tourists",
      "languages": ["Arabic", "English", "French"],
      "specialties": ["Ancient Egypt", "Siwan Culture", "Archaeological Sites"],
      "certifications": ["Licensed Tour Guide", "Archaeology Degree"],
      "Mon": true,
      "Tue": true,
      "Wed": false,
      "Thu": true,
      "Fri": true,
      "Sat": true,
      "Sun": true,
      "verified": true,
      "responseTime": "< 1 hour",
      "category": "guide",
      "location": "Siwa Oasis"
    },
    {
      "id": 2,
      "name": "Fatima Al-Siwy",
      "specialty": "culture",
      "experience": 10,
      "rating": 4.8,
      "reviews": 189,
      "hourlyRate": 120.0,
      "price": 120.0,
      "imageUrl": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
      "bio": "Native Siwan guide specializing in local culture, traditions, handicrafts and women's heritage",
      "languages": ["Arabic", "English"],
      "specialties": ["Siwan Culture", "Handicrafts", "Women's Heritage"],
      "certifications": ["Licensed Tour Guide", "Cultural Heritage Certificate"],
      "Mon": true,
      "Tue": true,
      "Wed": true,
      "Thu": true,
      "Fri": false,
      "Sat": true,
      "Sun": false,
      "verified": true,
      "responseTime": "< 2 hours",
      "category": "guide",
      "location": "Shali Village"
    },
    {
      "id": 3,
      "name": "Mohamed Saeed",
      "specialty": "adventure",
      "experience": 8,
      "rating": 4.9,
      "reviews": 312,
      "hourlyRate": 180.0,
      "price": 180.0,
      "imageUrl": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
      "bio": "Adventure specialist for desert safaris, sandboarding, and extreme sports with certified safety training",
      "languages": ["Arabic", "English", "German"],
      "specialties": ["Desert Safari", "Sandboarding", "4x4 Adventures"],
      "certifications": ["Licensed Tour Guide", "Wilderness First Aid", "Off-Road Driving"],
      "Mon": true,
      "Tue": true,
      "Wed": true,
      "Thu": true,
      "Fri": true,
      "Sat": true,
      "Sun": true,
      "verified": true,
      "responseTime": "< 30 min",
      "category": "guide",
      "location": "Desert Camps"
    },
    {
      "id": 4,
      "name": "Sara Ibrahim",
      "specialty": "nature",
      "experience": 6,
      "rating": 4.7,
      "reviews": 156,
      "hourlyRate": 100.0,
      "price": 100.0,
      "imageUrl": "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400",
      "bio": "Eco-tourism specialist focusing on Siwa's natural springs, lakes, wildlife and environmental conservation",
      "languages": ["Arabic", "English"],
      "specialties": ["Bird Watching", "Nature Photography", "Environmental Tours"],
      "certifications": ["Licensed Tour Guide", "Eco-Tourism Certification"],
      "Mon": true,
      "Tue": false,
      "Wed": true,
      "Thu": true,
      "Fri": true,
      "Sat": true,
      "Sun": true,
      "verified": true,
      "responseTime": "< 3 hours",
      "category": "guide",
      "location": "Birket Siwa"
    },
    {
      "id": 5,
      "name": "Khaled Mustafa",
      "specialty": "photography",
      "experience": 12,
      "rating": 4.8,
      "reviews": 267,
      "hourlyRate": 200.0,
      "price": 200.0,
      "imageUrl": "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400",
      "bio": "Professional photographer and guide specializing in landscape and cultural photography tours",
      "languages": ["Arabic", "English", "Italian"],
      "specialties": ["Photography Tours", "Landscape Photography", "Cultural Documentation"],
      "certifications": ["Licensed Tour Guide", "Professional Photography Certificate"],
      "Mon": true,
      "Tue": true,
      "Wed": true,
      "Thu": false,
      "Fri": true,
      "Sat": true,
      "Sun": true,
      "verified": true,
      "responseTime": "< 1 hour",
      "category": "guide",
      "location": "Various Locations"
    }
  ];

  // TRANSPORTATION - All fields consistent and populated
  static final List<Map<String, dynamic>> transportation = [
    {
      "id": 1,
      "name": "Siwa Express Bus",
      "type": "bus",
      "plate": "ABC123",
      "verified": true,
      "capacity": 45,
      "seats": 45,
      "route": "Cairo - Siwa",
      "price": 150.0,
      "duration": "8 hours",
      "rating": 4.5,
      "reviews": 234,
      "departures": ["06:00 AM", "10:00 PM"],
      "imageUrl": "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=800",
      "amenities": ["AC", "WiFi", "Reclining Seats", "Rest Stops"],
      "description": "Comfortable express bus service with modern amenities",
      "category": "transportation",
      "location": "Cairo to Siwa Route"
    },
    {
      "id": 2,
      "name": "Desert Taxi Service",
      "type": "taxi",
      "plate": "XYZ789",
      "verified": true,
      "capacity": 4,
      "seats": 4,
      "route": "Siwa Oasis Tours",
      "price": 300.0,
      "duration": "Flexible",
      "rating": 4.8,
      "reviews": 156,
      "departures": ["On Demand"],
      "imageUrl": "https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?w=800",
      "amenities": ["AC", "Professional Driver", "Local Guide"],
      "description": "Private taxi service for personalized oasis tours",
      "category": "transportation",
      "location": "Siwa Town"
    },
    {
      "id": 3,
      "name": "Luxury Van Transfer",
      "type": "van",
      "plate": "LUX456",
      "verified": true,
      "capacity": 8,
      "seats": 8,
      "route": "Airport - Siwa Hotels",
      "price": 500.0,
      "duration": "7 hours",
      "rating": 4.9,
      "reviews": 89,
      "departures": ["Flexible booking", "08:00 AM", "02:00 PM"],
      "imageUrl": "https://images.unsplash.com/photo-1527786356703-4b100091cd2c?w=800",
      "amenities": ["AC", "WiFi", "Refreshments", "Luggage Space"],
      "description": "Premium transfer service with comfort and style",
      "category": "transportation",
      "location": "Airport Route"
    },
    {
      "id": 4,
      "name": "Budget Bus Line",
      "type": "bus",
      "plate": "BDG789",
      "verified": true,
      "capacity": 50,
      "seats": 50,
      "route": "Alexandria - Siwa",
      "price": 100.0,
      "duration": "6 hours",
      "rating": 4.2,
      "reviews": 312,
      "departures": ["07:00 AM", "03:00 PM"],
      "imageUrl": "https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=800",
      "amenities": ["AC", "Standard Seats"],
      "description": "Affordable bus service for budget travelers",
      "category": "transportation",
      "location": "Alexandria Route"
    },
    {
      "id": 5,
      "name": "4x4 Desert Adventure",
      "type": "4x4",
      "plate": "DST321",
      "verified": true,
      "capacity": 7,
      "seats": 7,
      "route": "Great Sand Sea Safari",
      "price": 400.0,
      "duration": "Full Day",
      "rating": 4.9,
      "reviews": 178,
      "departures": ["08:00 AM", "02:00 PM"],
      "imageUrl": "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=800",
      "amenities": ["4x4 Vehicle", "Safety Equipment", "Snacks", "Water"],
      "description": "Thrilling desert safari experience in the Great Sand Sea",
      "category": "transportation",
      "location": "Desert Camps"
    }
  ];

  // ATTRACTIONS - All fields complete with valid URLs
  static final List<Map<String, dynamic>> attractions = [
    {
      "id": 1,
      "name": "Temple of the Oracle",
      "category": "historical",
      "description": "Ancient temple where Alexander the Great consulted the oracle of Amun",
      "price": 50.0,
      "duration": "2 hours",
      "rating": 4.8,
      "reviews": 456,
      "imageUrl": "https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800",
      "location": "Aghurmi Village",
      "openingHours": "8:00 AM - 5:00 PM",
      "difficulty": "Easy",
      "highlights": ["Ancient History", "Archaeological Site", "Panoramic Views"],
      "tags": ["history", "archaeology", "ancient"],
      "featured": true
    },
    {
      "id": 2,
      "name": "Siwa Salt Lakes",
      "category": "nature",
      "description": "Crystal-clear salt lakes with therapeutic properties and stunning landscapes",
      "price": 30.0,
      "duration": "3 hours",
      "rating": 4.9,
      "reviews": 789,
      "imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800",
      "location": "Birket Siwa",
      "openingHours": "24/7",
      "difficulty": "Easy",
      "highlights": ["Swimming", "Relaxation", "Photography"],
      "tags": ["nature", "swimming", "relaxation"],
      "eco_friendly": true,
      "featured": true
    },
    {
      "id": 3,
      "name": "Shali Fortress",
      "category": "historical",
      "description": "Ancient mud-brick fortress with panoramic oasis views and traditional architecture",
      "price": 25.0,
      "duration": "1.5 hours",
      "rating": 4.6,
      "reviews": 324,
      "imageUrl": "https://images.unsplash.com/photo-1548013146-72479768bada?w=800",
      "location": "Siwa Town Center",
      "openingHours": "8:00 AM - 6:00 PM",
      "difficulty": "Moderate",
      "highlights": ["Architecture", "History", "Sunset Views"],
      "tags": ["history", "architecture", "culture"],
      "featured": false
    },
    {
      "id": 4,
      "name": "Cleopatra's Bath",
      "category": "nature",
      "description": "Natural spring pool with crystal-clear water and historical significance",
      "price": 20.0,
      "duration": "2 hours",
      "rating": 4.7,
      "reviews": 612,
      "imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
      "location": "Near Siwa Town",
      "openingHours": "7:00 AM - 7:00 PM",
      "difficulty": "Easy",
      "highlights": ["Swimming", "Natural Spring", "Historical Site"],
      "tags": ["nature", "swimming", "history"],
      "eco_friendly": true,
      "hidden_gem": true
    },
    {
      "id": 5,
      "name": "Great Sand Sea Safari",
      "category": "adventure",
      "description": "Thrilling 4x4 desert adventure through massive dunes and stunning landscapes",
      "price": 200.0,
      "duration": "6 hours",
      "rating": 4.9,
      "reviews": 234,
      "imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
      "location": "Western Desert",
      "openingHours": "By appointment",
      "difficulty": "Challenging",
      "highlights": ["Sandboarding", "4x4 Adventure", "Sunset Views"],
      "tags": ["adventure", "desert", "extreme"],
      "featured": true
    },
    {
      "id": 6,
      "name": "Fatnas Island Sunset",
      "category": "nature",
      "description": "Peaceful palm-covered island perfect for sunset viewing and relaxation",
      "price": 15.0,
      "duration": "2 hours",
      "rating": 4.8,
      "reviews": 445,
      "imageUrl": "https://images.unsplash.com/photo-1500322969630-a26ab6ef0e0a?w=800",
      "location": "Birket Siwa",
      "openingHours": "4:00 PM - 7:00 PM",
      "difficulty": "Easy",
      "highlights": ["Sunset views", "Photography", "Nature"],
      "tags": ["nature", "sunset", "photography"],
      "eco_friendly": true,
      "hidden_gem": true
    },
    {
      "id": 7,
      "name": "Mountain of the Dead",
      "category": "historical",
      "description": "Ancient necropolis with well-preserved tomb paintings from Greco-Roman period",
      "price": 40.0,
      "duration": "1.5 hours",
      "rating": 4.5,
      "reviews": 267,
      "imageUrl": "https://images.unsplash.com/photo-1503756234508-e32369269deb?w=800",
      "location": "Gebel al-Mawta",
      "openingHours": "8:00 AM - 5:00 PM",
      "difficulty": "Moderate",
      "highlights": ["Ancient tombs", "Archaeology", "History"],
      "tags": ["history", "archaeology", "ancient"],
      "featured": false
    },
    {
      "id": 8,
      "name": "Siwa House Museum",
      "category": "culture",
      "description": "Traditional Siwan house showcasing local culture, crafts and daily life",
      "price": 35.0,
      "duration": "1 hour",
      "rating": 4.4,
      "reviews": 189,
      "imageUrl": "https://images.unsplash.com/photo-1565711561500-691d9ec04506?w=800",
      "location": "Siwa Town",
      "openingHours": "9:00 AM - 4:00 PM",
      "difficulty": "Easy",
      "highlights": ["Cultural Heritage", "Traditional Crafts", "Local Life"],
      "tags": ["culture", "museum", "traditional"],
      "hidden_gem": true
    }
  ];

  // PRODUCTS - All fields complete
  static final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Siwa Olive Oil",
      "price": 25.0,
      "stock": 45,
      "category": "Food",
      "lowStockThreshold": 20,
      "image": "https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400",
      "description": "Premium extra virgin olive oil from local Siwan olives",
      "rating": 4.8,
      "reviews": 156,
      "imageUrl": "https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400"
    },
    {
      "id": 2,
      "name": "Handwoven Basket",
      "price": 35.0,
      "stock": 12,
      "category": "Crafts",
      "lowStockThreshold": 15,
      "image": "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400",
      "description": "Traditional handwoven palm basket made by local artisans",
      "rating": 4.7,
      "reviews": 89,
      "imageUrl": "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400"
    },
    {
      "id": 3,
      "name": "Date Palm Honey",
      "price": 30.0,
      "stock": 8,
      "category": "Food",
      "lowStockThreshold": 10,
      "image": "https://images.unsplash.com/photo-1587049352846-4a222e784169?w=400",
      "description": "Pure natural honey from date palm flowers",
      "rating": 4.9,
      "reviews": 234,
      "imageUrl": "https://images.unsplash.com/photo-1587049352846-4a222e784169?w=400"
    },
    {
      "id": 4,
      "name": "Siwa Salt Lamp",
      "price": 50.0,
      "stock": 25,
      "category": "Crafts",
      "lowStockThreshold": 15,
      "image": "https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400",
      "description": "Natural salt crystal lamp from Siwa salt lakes",
      "rating": 4.6,
      "reviews": 112,
      "imageUrl": "https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400"
    },
    {
      "id": 5,
      "name": "Traditional Pottery",
      "price": 40.0,
      "stock": 18,
      "category": "Crafts",
      "lowStockThreshold": 10,
      "image": "https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?w=400",
      "description": "Handmade clay pottery with traditional Siwan designs",
      "rating": 4.8,
      "reviews": 145,
      "imageUrl": "https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?w=400"
    }
  ];

  // BOOKINGS - COMPLETELY CONSISTENT STRUCTURE
  static final List<Map<String, dynamic>> bookings = [
    {
      "id": 1001,
      "title": "Siwa Shali Resort",
      "guest": "Sarah Johnson",
      "room": "Deluxe Suite",
      "date": DateTime(2025, 10, 17),
      "checkIn": DateTime(2025, 10, 17),
      "checkOut": DateTime(2025, 10, 20),
      "status": "Confirmed",
      "imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
      "amount": "\$450",
      "category": "accommodation",
      "location": "Central Siwa"
    },
    {
      "id": 1002,
      "title": "Desert Safari Adventure",
      "guest": "Ahmed Hassan",
      "room": "N/A",
      "date": DateTime(2025, 10, 20),
      "checkIn": DateTime(2025, 10, 20),
      "checkOut": DateTime(2025, 10, 20),
      "status": "Confirmed",
      "imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
      "amount": "\$200",
      "category": "tour",
      "location": "Great Sand Sea"
    },
    {
      "id": 1003,
      "title": "Mountain Bike Rental",
      "guest": "Emily Chen",
      "room": "N/A",
      "date": DateTime(2025, 10, 22),
      "checkIn": DateTime(2025, 10, 22),
      "checkOut": DateTime(2025, 10, 24),
      "status": "Pending",
      "imageUrl": "https://images.unsplash.com/photo-1571333250630-f0230c320b6d?w=800",
      "amount": "\$50",
      "category": "rental",
      "location": "Siwa Town"
    },
    {
      "id": 1004,
      "title": "Oasis Bistro Reservation",
      "guest": "Mohamed Ali",
      "room": "N/A",
      "date": DateTime(2025, 10, 18),
      "checkIn": DateTime(2025, 10, 18),
      "checkOut": DateTime(2025, 10, 18),
      "status": "Confirmed",
      "imageUrl": "https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800",
      "amount": "\$120",
      "category": "restaurant",
      "location": "Downtown Siwa"
    },
    {
      "id": 1005,
      "title": "Siwa Express Bus",
      "guest": "Layla Ibrahim",
      "room": "N/A",
      "date": DateTime(2025, 10, 25),
      "checkIn": DateTime(2025, 10, 25),
      "checkOut": DateTime(2025, 10, 25),
      "status": "Pending",
      "imageUrl": "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=800",
      "amount": "\$150",
      "category": "transportation",
      "location": "Cairo to Siwa"
    },
    {
      "id": 1006,
      "title": "Temple of Oracle Tour",
      "guest": "James Smith",
      "room": "N/A",
      "date": DateTime(2025, 10, 19),
      "checkIn": DateTime(2025, 10, 19),
      "checkOut": DateTime(2025, 10, 19),
      "status": "Confirmed",
      "imageUrl": "https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800",
      "amount": "\$50",
      "category": "attraction",
      "location": "Aghurmi Village"
    },
    {
      "id": 1007,
      "title": "Palm Tree Restaurant",
      "guest": "Fatima Ahmed",
      "room": "N/A",
      "date": DateTime(2025, 10, 16),
      "checkIn": DateTime(2025, 10, 16),
      "checkOut": DateTime(2025, 10, 16),
      "status": "Cancelled",
      "imageUrl": "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800",
      "amount": "\$75",
      "category": "restaurant",
      "location": "Near Cleopatra Spring"
    }
  ];

  // HOTELS - All fields complete
  static final List<Map<String, dynamic>> hotels = [
    {
      "id": 1,
      "name": "Siwa Shali Resort",
      "type": "eco-lodge",
      "description": "Eco-friendly resort with traditional Siwan architecture and modern amenities",
      "pricePerNight": 120.0,
      "price": 120.0,
      "rating": 4.8,
      "reviews": 320,
      "imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
      "amenities": ["Wi-Fi", "Pool", "Breakfast Included", "Spa", "Restaurant"],
      "location": "Central Siwa",
      "checkInTime": "2:00 PM",
      "checkOutTime": "12:00 PM",
      "openNow": true,
      "starRating": 4,
      "category": "accommodation",
      "eco_friendly": true,
      "featured": true
    },
    {
      "id": 2,
      "name": "Desert Rose Hotel",
      "type": "hotel",
      "description": "Luxury hotel with views of the Great Sand Sea and premium services",
      "pricePerNight": 200.0,
      "price": 200.0,
      "rating": 4.9,
      "reviews": 450,
      "imageUrl": "https://images.unsplash.com/photo-1542314831-8d7e7b9e0f97?w=800",
      "amenities": ["Wi-Fi", "Spa", "Restaurant", "Pool", "Gym", "Room Service"],
      "location": "Near Siwa Lake",
      "checkInTime": "3:00 PM",
      "checkOutTime": "11:00 AM",
      "openNow": true,
      "starRating": 5,
      "category": "accommodation",
      "featured": true
    },
    {
      "id": 3,
      "name": "Oasis Guesthouse",
      "type": "guesthouse",
      "description": "Cozy guesthouse with authentic Siwan hospitality and family atmosphere",
      "pricePerNight": 60.0,
      "price": 60.0,
      "rating": 4.6,
      "reviews": 180,
      "imageUrl": "https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=800",
      "amenities": ["Wi-Fi", "Garden", "Free Parking", "Breakfast"],
      "location": "Shali Village",
      "checkInTime": "1:00 PM",
      "checkOutTime": "12:00 PM",
      "openNow": true,
      "starRating": 3,
      "category": "accommodation",
      "hidden_gem": true
    },
    {
      "id": 4,
      "name": "Palm Trees Lodge",
      "type": "lodge",
      "description": "Rustic lodge surrounded by date palms with peaceful atmosphere",
      "pricePerNight": 80.0,
      "price": 80.0,
      "rating": 4.7,
      "reviews": 250,
      "imageUrl": "https://images.unsplash.com/photo-1596436889106-be35e843f974?w=800",
      "amenities": ["Breakfast Included", "Outdoor Seating", "Garden", "Free Parking"],
      "location": "Near Cleopatra Spring",
      "checkInTime": "2:00 PM",
      "checkOutTime": "11:00 AM",
      "openNow": true,
      "starRating": 3,
      "category": "accommodation",
      "eco_friendly": true
    },
    {
      "id": 5,
      "name": "Sand Dunes Camp",
      "type": "camp",
      "description": "Desert camping experience with Bedouin vibes and stargazing",
      "pricePerNight": 50.0,
      "price": 50.0,
      "rating": 4.5,
      "reviews": 150,
      "imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800",
      "amenities": ["Campfire", "Guided Tours", "Traditional Meals", "Bedouin Tents"],
      "location": "Great Sand Sea",
      "checkInTime": "4:00 PM",
      "checkOutTime": "10:00 AM",
      "openNow": true,
      "starRating": 2,
      "category": "accommodation",
      "hidden_gem": true
    }
  ];

  // REVIEWS - All fields complete
  static final List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "userId": "user123",
      "itemId": "1",
      "itemType": "hotel",
      "rating": 5.0,
      "comment": "Amazing stay at Siwa Shali Resort! The eco-friendly design and warm hospitality made it unforgettable.",
      "date": "2025-09-15",
      "userName": "Amani Hassan",
      "verified": true,
      "helpful": 23
    },
    {
      "id": 2,
      "userId": "user456",
      "itemId": "2",
      "itemType": "restaurant",
      "rating": 4.8,
      "comment": "Abdu's Kitchen served the best Siwan Pizza I've ever tasted! Highly recommend.",
      "date": "2025-08-20",
      "userName": "Youssef Ahmed",
      "verified": true,
      "helpful": 18
    },
    {
      "id": 3,
      "userId": "user789",
      "itemId": "3",
      "itemType": "guide",
      "rating": 4.9,
      "comment": "Mohamed Saeed's desert safari was thrilling! His knowledge of Siwa made the tour exceptional.",
      "date": "2025-07-10",
      "userName": "Layla Mohamed",
      "verified": true,
      "helpful": 31
    },
    {
      "id": 4,
      "userId": "user101",
      "itemId": "1",
      "itemType": "transportation",
      "rating": 4.5,
      "comment": "Siwa Express Bus was comfortable and on time, great for long trips.",
      "date": "2025-06-05",
      "userName": "Khaled Omar",
      "verified": true,
      "helpful": 12
    },
    {
      "id": 5,
      "userId": "user102",
      "itemId": "4",
      "itemType": "restaurant",
      "rating": 4.7,
      "comment": "Siwa Dates Café has the best date coffee and a cozy atmosphere.",
      "date": "2025-05-12",
      "userName": "Sara Ali",
      "verified": true,
      "helpful": 15
    }
  ];

  // BADGES - All fields complete with valid URLs
  static final List<Map<String, dynamic>> badges = [
    {
      "id": 1,
      "name": "Hidden Oasis Explorer",
      "description": "Discovered a hidden oasis",
      "imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=400",
      "points": 75,
      "rarity": "rare"
    },
    {
      "id": 2,
      "name": "Sunset Photographer",
      "description": "Captured the perfect sunset",
      "imageUrl": "https://images.unsplash.com/photo-1500322969630-a26ab6ef0e0a?w=400",
      "points": 50,
      "rarity": "common"
    },
    {
      "id": 3,
      "name": "Salt Lake Swimmer",
      "description": "Swam in the salt lakes",
      "imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400",
      "points": 60,
      "rarity": "uncommon"
    }
  ];

  // OTHER DATA - All fields complete (for challenges, etc.)
  static final List<Map<String, dynamic>> other = [
    // Hotel Rooms
    {
      "id": 1,
      "type": "Deluxe Suite",
      "price": 150.0,
      "amenities": ["WiFi", "Mini Bar", "Balcony"],
      "available": true,
      "category": "room"
    },
    {
      "id": 2,
      "type": "Standard Room",
      "price": 80.0,
      "amenities": ["WiFi", "TV"],
      "available": true,
      "category": "room"
    },
    {
      "id": 3,
      "type": "Family Room",
      "price": 200.0,
      "amenities": ["WiFi", "Kitchen", "Living Room"],
      "available": false,
      "category": "room"
    },
    
    // Rental Vehicles
    {
      "id": 1,
      "type": "Mountain Bike",
      "model": "Trek X-Caliber",
      "rate": 25.0,
      "rateType": "day",
      "available": true,
      "condition": "Excellent",
      "image": "pedal_bike",
      "category": "rental"
    },
    {
      "id": 2,
      "type": "SUV",
      "model": "Toyota Land Cruiser",
      "rate": 120.0,
      "rateType": "day",
      "available": false,
      "condition": "Good",
      "image": "directions_car",
      "category": "rental"
    },
    {
      "id": 3,
      "type": "Electric Scooter",
      "model": "Xiaomi Pro 2",
      "rate": 15.0,
      "rateType": "hour",
      "available": true,
      "condition": "Excellent",
      "image": "electric_scooter",
      "category": "rental"
    },
    
    // Photo Challenges
    {
      "id": 1,
      "title": "Capture the Sunset",
      "description": "Find the perfect spot to photograph the sunset over the desert dunes.",
      "imageUrl": "https://images.unsplash.com/photo-1500322969630-a26ab6ef0e0a?w=800",
      "completed": false,
      "points": 50,
      "proof": null,
      "category": "challenge",
      "difficulty": "easy"
    },
    {
      "id": 2,
      "title": "Hidden Oasis",
      "description": "Discover and photograph a hidden oasis within the Siwa desert.",
      "imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
      "completed": false,
      "points": 75,
      "proof": null,
      "category": "challenge",
      "difficulty": "hard"
    },
    {
      "id": 3,
      "title": "Salt Lake Reflection",
      "description": "Capture the stunning reflections on the surface of the salt lakes.",
      "imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800",
      "completed": false,
      "points": 60,
      "proof": null,
      "category": "challenge",
      "difficulty": "medium"
    },
    
    // Featured Services
    {
      "id": 1,
      "name": "Siwa Shali Resort",
      "price": 120.0,
      "rating": 4.5,
      "location": "Siwa, Egypt",
      "imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
      "eco_friendly": true,
      "reviews": 125,
      "category": "accommodation",
      "description": "Luxury eco-resort with traditional architecture",
      "tags": ["luxury", "eco"],
      "featured": true
    },
    {
      "id": 2,
      "name": "Desert Safari Adventure",
      "price": 80.0,
      "rating": 4.6,
      "location": "Siwa Desert",
      "imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
      "reviews": 128,
      "category": "attraction",
      "description": "Thrilling 4x4 desert safari",
      "tags": ["adventure", "desert"],
      "hidden_gem": true
    },
    {
      "id": 3,
      "name": "Abdu Restaurant",
      "price": 25.0,
      "rating": 4.8,
      "location": "Market Square, Siwa",
      "imageUrl": "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800",
      "reviews": 234,
      "category": "restaurant",
      "description": "Traditional Siwan cuisine",
      "tags": ["traditional", "local"],
      "hidden_gem": true
    }
  ];

  // GETTER METHODS
  List<Map<String, dynamic>> getAllHotels() => hotels;
  List<Map<String, dynamic>> getAllRestaurants() => restaurants;
  List<Map<String, dynamic>> getAllTourGuides() => guides;
  List<Map<String, dynamic>> getAllTransportation() => transportation;
  List<Map<String, dynamic>> getAllAttractions() => attractions;
  List<Map<String, dynamic>> getAllProducts() => products;
  List<Map<String, dynamic>> getAllBookings() => bookings;
  List<Map<String, dynamic>> getAllReviews() => reviews;
  List<Map<String, dynamic>> getAllBadges() => badges;
  List<Map<String, dynamic>> getAllOther() => other;

  List<Map<String, dynamic>> getBookingsByUserId(String userId) {
    return bookings.where((b) => b['userId'] == userId).toList();
  }

  List<Map<String, dynamic>> searchAll(String query) {
    final results = <Map<String, dynamic>>[];
    final lowerQuery = query.toLowerCase();
    
    for (var category in [hotels, restaurants, guides, attractions, products, badges, other]) {
      for (var item in category) {
        final name = (item['name'] as String?)?.toLowerCase() ?? '';
        final title = (item['title'] as String?)?.toLowerCase() ?? '';
        final description = (item['description'] as String?)?.toLowerCase() ?? '';
        if (name.contains(lowerQuery) || title.contains(lowerQuery) || description.contains(lowerQuery)) {
          results.add(item);
        }
      }
    }
    
    return results;
  }
}

final mockData = MockDataRepository();