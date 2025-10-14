// lib/data/mock_data_repository.dart
// AUTO-GENERATED: Extracted from your existing screens

class MockDataRepository {
  static final MockDataRepository _instance = MockDataRepository._internal();
  factory MockDataRepository() => _instance;
  MockDataRepository._internal();

  // RESTAURANTS
  static final List<Map<String, dynamic>> restaurants = [
    {
        "id": 1,
        "name": "Aghurmi Restaurant",
        "cuisine": "egyptian",
        "description": "Authentic Siwan and Egyptian cuisine",
        "priceRange": "medium",
        "rating": 4.7,
        "reviews": 234,
        "deliveryTime": "30-45 min",
        "minOrder": 50.0,
        "imageUrl": "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800",
        "specialties": [
            "Siwan Dates"
        ],
        "openNow": true,
        "openingHours": "8:00 AM - 11:00 PM",
        "deliveryFee": 15.0
    },
    {
        "id": 2,
        "name": "Abdu\\'s Kitchen",
        "cuisine": "traditional",
        "description": "Traditional Siwan home-cooked meals",
        "priceRange": "low",
        "rating": 4.9,
        "reviews": 456,
        "deliveryTime": "20-30 min",
        "minOrder": 30.0,
        "imageUrl": "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800",
        "specialties": [
            "Siwan Pizza"
        ],
        "openNow": true,
        "openingHours": "7:00 AM - 10:00 PM",
        "deliveryFee": 10.0
    },
    {
        "id": 3,
        "name": "Oasis Bistro",
        "cuisine": "international",
        "description": "International fusion with local ingredients",
        "priceRange": "high",
        "rating": 4.6,
        "reviews": 189,
        "deliveryTime": "40-60 min",
        "minOrder": 100.0,
        "imageUrl": "https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800",
        "specialties": [
            "Gourmet Burgers"
        ],
        "openNow": true,
        "openingHours": "12:00 PM - 12:00 AM",
        "deliveryFee": 25.0
    },
    {
        "id": 4,
        "name": "Siwa Dates Caf\u00e9",
        "cuisine": "cafe",
        "description": "Specialty coffee and local date desserts",
        "priceRange": "low",
        "rating": 4.8,
        "reviews": 345,
        "deliveryTime": "15-25 min",
        "minOrder": 25.0,
        "imageUrl": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800",
        "specialties": [
            "Date Coffee"
        ],
        "openNow": true,
        "openingHours": "6:00 AM - 9:00 PM",
        "deliveryFee": 10.0
    },
    {
        "id": 5,
        "name": "Desert Grill House",
        "cuisine": "grill",
        "description": "Grilled meats and BBQ specialties",
        "priceRange": "medium",
        "rating": 4.5,
        "reviews": 278,
        "deliveryTime": "35-50 min",
        "minOrder": 80.0,
        "imageUrl": "https://images.unsplash.com/photo-1544025162-d76694265947?w=800",
        "specialties": [
            "Kebab"
        ],
        "openNow": false,
        "openingHours": "5:00 PM - 12:00 AM",
        "deliveryFee": 20.0
    },
    {
        "id": 6,
        "name": "Palm Tree Restaurant",
        "cuisine": "mediterranean",
        "description": "Mediterranean flavors with Egyptian touch",
        "priceRange": "medium",
        "rating": 4.7,
        "reviews": 312,
        "deliveryTime": "30-40 min",
        "minOrder": 60.0,
        "imageUrl": "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800",
        "specialties": [
            "Mezze Platter"
        ],
        "openNow": true,
        "openingHours": "11:00 AM - 11:00 PM",
        "deliveryFee": 15.0
    }
];

  // GUIDES
  static final List<Map<String, dynamic>> guides = [
    {
        "id": 1,
        "name": "Ahmed Hassan",
        "specialty": "history",
        "experience": 15,
        "rating": 4.9,
        "reviews": 234,
        "hourlyRate": 150.0,
        "imageUrl": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
        "bio": "Expert in Siwan history and ancient Egyptian archaeology with over 15 years of experience",
        "languages": [
            "Arabic"
        ],
        "specialties": [
            "Ancient Egypt"
        ],
        "Mon": true,
        "Tue": true,
        "Wed": false,
        "Thu": true,
        "Fri": true,
        "Sat": true,
        "verified": true,
        "responseTime": "< 1 hour"
    },
    {
        "id": 2,
        "name": "Fatima Al-Siwy",
        "specialty": "culture",
        "experience": 10,
        "rating": 4.8,
        "reviews": 189,
        "hourlyRate": 120.0,
        "imageUrl": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
        "bio": "Native Siwan guide specializing in local culture, traditions, and handicrafts",
        "languages": [
            "Arabic"
        ],
        "certifications": [
            "Licensed Tour Guide"
        ],
        "specialties": [
            "Siwan Culture"
        ],
        "Mon": true,
        "Tue": true,
        "Wed": true,
        "Thu": true,
        "Fri": false,
        "Sat": true,
        "verified": true,
        "responseTime": "< 2 hours"
    },
    {
        "id": 3,
        "name": "Mohamed Saeed",
        "specialty": "adventure",
        "experience": 8,
        "rating": 4.9,
        "reviews": 312,
        "hourlyRate": 180.0,
        "imageUrl": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
        "bio": "Adventure specialist for desert safaris, sandboarding, and extreme sports",
        "languages": [
            "Arabic"
        ],
        "specialties": [
            "Desert Safari"
        ],
        "Mon": true,
        "Tue": true,
        "Wed": true,
        "Thu": true,
        "Fri": true,
        "Sat": true,
        "verified": true,
        "responseTime": "< 30 min"
    },
    {
        "id": 4,
        "name": "Sara Ibrahim",
        "specialty": "nature",
        "experience": 6,
        "rating": 4.7,
        "reviews": 156,
        "hourlyRate": 100.0,
        "imageUrl": "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400",
        "bio": "Eco-tourism specialist focusing on Siwa\\'s natural springs, lakes, and wildlife",
        "languages": [
            "Arabic"
        ],
        "certifications": [
            "Licensed Tour Guide"
        ],
        "specialties": [
            "Bird Watching"
        ],
        "Mon": true,
        "Tue": false,
        "Wed": true,
        "Thu": true,
        "Fri": true,
        "Sat": true,
        "verified": true,
        "responseTime": "< 3 hours"
    },
    {
        "id": 5,
        "name": "Khaled Mustafa",
        "specialty": "photography",
        "experience": 12,
        "rating": 4.8,
        "reviews": 267,
        "hourlyRate": 200.0,
        "imageUrl": "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400",
        "bio": "Professional photographer and guide specializing in landscape and cultural photography",
        "languages": [
            "Arabic"
        ],
        "certifications": [
            "Licensed Tour Guide"
        ],
        "Mon": true,
        "Tue": true,
        "Wed": true,
        "Thu": false,
        "Fri": true,
        "Sat": true,
        "verified": true,
        "responseTime": "< 1 hour"
    }
];

  // TRANSPORTATION
  static final List<Map<String, dynamic>> transportation = [
    {
        "id": 1,
        "type": "Bus",
        "plate": "ABC123",
        "verified": true,
        "capacity": 45
    },
    {
        "id": 2,
        "type": "4x4 SUV",
        "plate": "XYZ789",
        "verified": true,
        "capacity": 7
    },
    {
        "id": 1,
        "name": "Siwa Express Bus",
        "type": "bus",
        "route": "Cairo - Siwa",
        "price": 150.0,
        "duration": "8 hours",
        "rating": 4.5,
        "reviews": 234,
        "departures": [
            "06:00 AM"
        ],
        "imageUrl": "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=800",
        "amenities": [
            "AC"
        ],
        "seats": 45
    },
    {
        "id": 2,
        "name": "Desert Taxi Service",
        "type": "taxi",
        "route": "Siwa Oasis Tours",
        "price": 300.0,
        "duration": "Flexible",
        "rating": 4.8,
        "reviews": 156,
        "imageUrl": "https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?w=800",
        "amenities": [
            "AC"
        ],
        "seats": 4
    },
    {
        "id": 3,
        "name": "Luxury Van Transfer",
        "type": "van",
        "route": "Airport - Siwa Hotels",
        "price": 500.0,
        "duration": "7 hours",
        "rating": 4.9,
        "reviews": 89,
        "departures": [
            "Flexible booking"
        ],
        "imageUrl": "https://images.unsplash.com/photo-1527786356703-4b100091cd2c?w=800",
        "amenities": [
            "AC"
        ],
        "seats": 8
    },
    {
        "id": 4,
        "name": "Budget Bus Line",
        "type": "bus",
        "route": "Alexandria - Siwa",
        "price": 100.0,
        "duration": "6 hours",
        "rating": 4.2,
        "reviews": 312,
        "departures": [
            "07:00 AM"
        ],
        "imageUrl": "https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=800",
        "amenities": [
            "AC"
        ],
        "seats": 50
    }
];

  // ATTRACTIONS
  static final List<Map<String, dynamic>> attractions = [
    {
        "id": 1,
        "name": "Temple of the Oracle",
        "category": "historical",
        "description": "Ancient temple where Alexander the Great consulted the oracle",
        "price": 50.0,
        "duration": "2 hours",
        "rating": 4.8,
        "reviews": 456,
        "imageUrl": "https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800",
        "location": "Aghurmi Village",
        "openingHours": "8:00 AM - 5:00 PM",
        "difficulty": "Easy"
    },
    {
        "id": 2,
        "name": "Siwa Salt Lakes",
        "category": "nature",
        "description": "Crystal-clear salt lakes with therapeutic properties",
        "price": 30.0,
        "duration": "3 hours",
        "rating": 4.9,
        "reviews": 789,
        "imageUrl": "https://visitegypt.com/wp-content/uploads/2025/07/the-salt-lake-siwa-oasis.webp",
        "location": "Birket Siwa",
        "highlights": [
            "Swimming"
        ],
        "openingHours": "24/7",
        "difficulty": "Easy"
    },
    {
        "id": 3,
        "name": "Shali Fortress",
        "category": "historical",
        "description": "Ancient mud-brick fortress with panoramic oasis views",
        "price": 25.0,
        "duration": "1.5 hours",
        "rating": 4.6,
        "reviews": 324,
        "imageUrl": "https://images.unsplash.com/photo-1548013146-72479768bada?w=800",
        "location": "Siwa Town Center",
        "highlights": [
            "Architecture"
        ],
        "openingHours": "8:00 AM - 6:00 PM",
        "difficulty": "Moderate"
    },
    {
        "id": 4,
        "name": "Cleopatra\\'s Bath",
        "category": "nature",
        "description": "Natural spring pool with crystal-clear water",
        "price": 20.0,
        "duration": "2 hours",
        "rating": 4.7,
        "reviews": 612,
        "imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
        "location": "Near Siwa Town",
        "highlights": [
            "Swimming"
        ],
        "openingHours": "7:00 AM - 7:00 PM",
        "difficulty": "Easy"
    },
    {
        "id": 5,
        "name": "Great Sand Sea Safari",
        "category": "adventure",
        "description": "Thrilling 4x4 desert adventure through massive dunes",
        "price": 200.0,
        "duration": "6 hours",
        "rating": 4.9,
        "reviews": 234,
        "imageUrl": "https://www.kemetexperience.com/wp-content/uploads/2019/09/incredible-white-desert-960x636.jpg",
        "location": "Western Desert",
        "highlights": [
            "Sandboarding"
        ],
        "openingHours": "By appointment",
        "difficulty": "Challenging"
    },
    {
        "id": 6,
        "name": "Fatnas Island Sunset",
        "category": "nature",
        "description": "Peaceful palm-covered island perfect for sunset viewing",
        "price": 15.0,
        "duration": "2 hours",
        "rating": 4.8,
        "reviews": 445,
        "imageUrl": "https://www.heatheronhertravels.com/wp-content/uploads/2011/09/Sunset-at-Fatnas-Island-in-Siwa-in-Egypt-2.jpg.webp",
        "location": "Birket Siwa",
        "highlights": [
            "Sunset views"
        ],
        "openingHours": "4:00 PM - 7:00 PM",
        "difficulty": "Easy"
    },
    {
        "id": 7,
        "name": "Mountain of the Dead",
        "category": "historical",
        "description": "Ancient necropolis with well-preserved tomb paintings",
        "price": 40.0,
        "duration": "1.5 hours",
        "rating": 4.5,
        "reviews": 267,
        "imageUrl": "https://images.unsplash.com/photo-1503756234508-e32369269deb?w=800",
        "location": "Gebel al-Mawta",
        "highlights": [
            "Ancient tombs"
        ],
        "openingHours": "8:00 AM - 5:00 PM",
        "difficulty": "Moderate"
    },
    {
        "id": 8,
        "name": "Siwa House Museum",
        "category": "culture",
        "description": "Traditional Siwan house showcasing local culture and crafts",
        "price": 35.0,
        "duration": "1 hour",
        "rating": 4.4,
        "reviews": 189,
        "imageUrl": "https://images.unsplash.com/photo-1565711561500-691d9ec04506?w=800",
        "location": "Siwa Town",
        "openingHours": "9:00 AM - 4:00 PM",
        "difficulty": "Easy"
    }
];

  // PRODUCTS
  static final List<Map<String, dynamic>> products = [
    {
        "id": 1,
        "name": "Siwa Olive Oil",
        "price": 25.0,
        "stock": 45,
        "category": "Food",
        "lowStockThreshold": 20,
        "image": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400&h=300&fit=crop"
    },
    {
        "id": 2,
        "name": "Handwoven Basket",
        "price": 35.0,
        "stock": 12,
        "category": "Crafts",
        "lowStockThreshold": 15,
        "image": "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400&h=300&fit=crop"
    },
    {
        "id": 3,
        "name": "Date Palm Honey",
        "price": 30.0,
        "stock": 8,
        "category": "Food",
        "lowStockThreshold": 10
    },
    {
        "id": 4,
        "name": "Siwa Salt Lamp",
        "price": 50.0,
        "stock": 25,
        "category": "Crafts",
        "lowStockThreshold": 15,
        "image": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400&h=300&fit=crop"
    }
];

  // BOOKINGS
  static final List<Map<String, dynamic>> bookings = [
    {
        "id": 1,
        "guest": "Sarah Johnson",
        "room": "Deluxe Suite",
        "checkIn": "DateTime.now().add(const Duration(days: 2))",
        "checkOut": "DateTime.now().add(const Duration(days: 5))",
        "status": "pending"
    },
    {
        "id": 2,
        "guest": "Ahmed Hassan",
        "room": "Family Room",
        "checkIn": "DateTime.now().add(const Duration(days: 1))",
        "checkOut": "DateTime.now().add(const Duration(days: 4))",
        "status": "confirmed"
    },
    {
        "id": 1,
        "guest": "Group of 5",
        "date": "DateTime.now().add(const Duration(days: 5))",
        "status": "confirmed"
    },
    {
        "id": 2,
        "guest": "Family of 4",
        "date": "DateTime.now().add(const Duration(days: 12))",
        "status": "pending"
    },
    {
        "id": 1001,
        "title": "Siwa Shali Resort",
        "date": "2024-07-20",
        "status": "Confirmed",
        "imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&h=600&fit=crop",
        "amount": "\\$150"
    },
    {
        "id": 1002,
        "title": "Mountain Bike Rental",
        "date": "2024-08-15",
        "status": "Pending",
        "imageUrl": "https://www.quitandgotravel.com/wp-content/uploads/sites/8/2022/04/Cycling-Across-Siwa-Oasis-Lake.jpg",
        "amount": "\\$85"
    },
    {
        "id": 1003,
        "title": "Siwa Oasis Tour",
        "date": "2024-09-05",
        "status": "Cancelled",
        "imageUrl": "https://www.kemetexperience.com/wp-content/uploads/2019/09/incredible-white-desert-960x636.jpg",
        "amount": "\\$65"
    }
];

  // BADGES
  static final List<Map<String, dynamic>> badges = [
    {
        "name": "'tourist.challenges.hidden_oasis'.tr()",
        "imageUrl": "https://www.kemetexperience.com/wp-content/uploads/2019/09/incredible-white-desert-960x636.jpg"
    },
    {
        "name": "'tourist.challenges.capture_sunset'.tr()",
        "imageUrl": "https://thedaydreamdrifters.com/wp-content/uploads/2018/09/Siwa-Oasis-.jpg"
    },
    {
        "name": "'tourist.challenges.salt_lake'.tr()",
        "imageUrl": "https://visitegypt.com/wp-content/uploads/2025/07/the-salt-lake-siwa-oasis.webp"
    }
];

  // OTHER
  static final List<Map<String, dynamic>> other = [
    {
        "id": 1,
        "type": "Deluxe Suite",
        "price": 150.0,
        "amenities": [
            "WiFi"
        ],
        "available": true
    },
    {
        "id": 2,
        "type": "Standard Room",
        "price": 80.0,
        "amenities": [
            "WiFi"
        ],
        "available": true
    },
    {
        "id": 3,
        "type": "Family Room",
        "price": 200.0,
        "amenities": [
            "WiFi"
        ],
        "available": false
    },
    {
        "id": 1,
        "type": "Mountain Bike",
        "model": "Trek X-Caliber",
        "rate": 25.0,
        "rateType": "day",
        "available": true,
        "condition": "Excellent",
        "image": "Icons.pedal_bike"
    },
    {
        "id": 2,
        "type": "SUV",
        "model": "Toyota Land Cruiser",
        "rate": 120.0,
        "rateType": "day",
        "available": false,
        "condition": "Good",
        "image": "Icons.directions_car"
    },
    {
        "id": 3,
        "type": "Electric Scooter",
        "model": "Xiaomi Pro 2",
        "rate": 15.0,
        "rateType": "hour",
        "available": true,
        "condition": "Excellent",
        "image": "Icons.electric_scooter"
    },
    {
        "id": 4,
        "type": "ATV",
        "model": "Polaris Sportsman",
        "rate": 80.0,
        "rateType": "day",
        "available": true,
        "condition": "Good",
        "image": "Icons.terrain"
    },
    {
        "id": 1,
        "vehicle": "Mountain Bike",
        "customer": "Sarah Johnson",
        "startDate": "DateTime.now().subtract(const Duration(days: 3))",
        "endDate": "DateTime.now().subtract(const Duration(days: 1))",
        "revenue": 50.0
    },
    {
        "id": 2,
        "vehicle": "SUV",
        "customer": "Ahmed Hassan",
        "startDate": "DateTime.now().subtract(const Duration(days: 1))",
        "endDate": "DateTime.now().add(const Duration(days: 2))",
        "revenue": 360.0
    },
    {
        "id": 1,
        "customer": "Emily Johnson",
        "items": [
            "Olive Oil x2"
        ],
        "total": 85.0,
        "status": "pending",
        "date": "DateTime.now().subtract(const Duration(hours: 2))"
    },
    {
        "id": 2,
        "customer": "Ahmed Khalil",
        "items": [
            "Date Honey x3"
        ],
        "total": 90.0,
        "status": "processing",
        "date": "DateTime.now().subtract(const Duration(hours: 5))"
    },
    {
        "id": 1,
        "name": "Siwa Local Loop",
        "ratePerKm": 2.0,
        "schedule": "Daily 8AM-8PM",
        "distance": "25 km",
        "duration": "1.5 hours"
    },
    {
        "id": 2,
        "name": "Desert Safari Route",
        "ratePerKm": 3.5,
        "schedule": "Daily 7AM-6PM",
        "distance": "80 km",
        "duration": "4 hours"
    },
    {
        "id": 1,
        "guest": "Jane Doe",
        "route": "Siwa Local Loop",
        "status": "pending",
        "time": "09:00 AM",
        "passengers": 3
    },
    {
        "id": 2,
        "guest": "Ahmed Hassan",
        "route": "Desert Safari Route",
        "status": "confirmed",
        "time": "07:30 AM",
        "passengers": 5
    },
    {
        "id": 1,
        "name": "Salt Lakes Tour",
        "duration": "const Duration(hours: 2)",
        "description": "Explore the stunning natural salt lakes",
        "time": "09:00 AM"
    },
    {
        "id": 2,
        "name": "Cleopatra Spring",
        "duration": "const Duration(hours: 1, minutes: 30)",
        "description": "Swimming in the famous natural spring",
        "time": "11:30 AM"
    },
    {
        "id": 3,
        "name": "Traditional Lunch",
        "duration": "const Duration(hours: 1)",
        "description": "Authentic Siwan cuisine",
        "time": "01:00 PM"
    },
    {
        "title": "Desert Safari",
        "subtitle": "Explore the dunes",
        "image": "Icons.terrain"
    },
    {
        "title": "Hot Air Balloon Ride",
        "subtitle": "Sunrise views",
        "image": "Icons.air"
    },
    {
        "id": 1,
        "title": "Capture the Sunset",
        "description": "Find the perfect spot to photograph the sunset over the desert dunes.",
        "imageUrl": "https://www.heatheronhertravels.com/wp-content/uploads/2011/09/Sunset-at-Fatnas-Island-in-Siwa-in-Egypt-2.jpg.webp",
        "completed": false,
        "points": 50,
        "proof": "null"
    },
    {
        "id": 2,
        "title": "Hidden Oasis",
        "description": "Discover and photograph a hidden oasis within the Siwa desert.",
        "imageUrl": "https://thedaydreamdrifters.com/wp-content/uploads/2018/09/Siwa-Oasis-.jpg",
        "completed": false,
        "points": 75,
        "proof": "null"
    },
    {
        "id": 3,
        "title": "Salt Lake Reflection",
        "description": "Capture the stunning reflections on the surface of the salt lakes.",
        "imageUrl": "https://visitegypt.com/wp-content/uploads/2025/07/the-salt-lake-siwa-oasis.webp",
        "completed": false,
        "points": 60,
        "proof": "null"
    },
    {
        "name": "Siwa Shali Resort",
        "price": 120.0,
        "rating": 4.5,
        "location": "Siwa, Egypt",
        "imageUrl": "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg?w=900&h=500&s=1",
        "eco_friendly": true,
        "reviews": 125,
        "category": "accommodation",
        "description": "Luxury eco-resort with traditional architecture",
        "tags": [
            "luxury"
        ],
        "featured": true
    },
    {
        "name": "Adrar Amellal",
        "price": 150.0,
        "rating": 4.7,
        "location": "Siwa, Egypt",
        "imageUrl": "https://www.adrereamellal.com/adrere/wp-content/uploads/2019/09/Adrere-amellal-siwa-oasis-eco-lodge-Omar-Hikal.jpg",
        "eco_friendly": true,
        "reviews": 98,
        "category": "accommodation",
        "description": "Candlelit eco-lodge without electricity",
        "tags": [
            "eco"
        ],
        "featured": true
    },
    {
        "name": "Taziry Ecolodge Siwa",
        "price": 90.0,
        "rating": 4.3,
        "location": "Siwa, Egypt",
        "eco_friendly": true,
        "reviews": 67,
        "category": "accommodation",
        "description": "Budget-friendly eco-lodge",
        "tags": [
            "eco"
        ]
    },
    {
        "name": "Desert Safari Adventure",
        "price": 80.0,
        "rating": 4.6,
        "location": "Siwa Desert",
        "imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
        "reviews": 128,
        "category": "attraction",
        "description": "Thrilling 4x4 desert safari",
        "tags": [
            "adventure"
        ],
        "hidden_gem": true
    },
    {
        "name": "Abdu Restaurant",
        "price": 25.0,
        "rating": 4.8,
        "location": "Market Square, Siwa",
        "imageUrl": "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800",
        "reviews": 234,
        "category": "restaurant",
        "description": "Traditional Siwan cuisine",
        "tags": [
            "traditional"
        ],
        "hidden_gem": true
    },
    {
        "name": "Siwa Express Bus",
        "price": 150.0,
        "rating": 4.5,
        "location": "Cairo - Siwa",
        "reviews": 234,
        "category": "transportation",
        "description": "Comfortable express bus service",
        "tags": [
            "bus"
        ]
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
      results.addAll(category.where((item) =>
        item['name']?.toString().toLowerCase().contains(lowerQuery) ?? false
      ));
    }
    
    return results;
  }
}

final mockData = MockDataRepository();
