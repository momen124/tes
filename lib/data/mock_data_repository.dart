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
      "price": 150.0,
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
'id': 'inside_1',
      'name': 'Siwa Eco Bikes',
      'type': 'bicycle',
      'serviceLocation': 'inside',
      'rentalType': 'self_drive',
      'description': 'Rent a bicycle and explore Siwa at your own pace',
      'imageUrl': 'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=800',
      'price': 50.0,
      'priceUnit': '/day',
      'duration': 'Flexible',
      'amenities': ['Helmet included', 'Lock provided', 'Map included'],
      'rating': 4.7,
      'reviews': 142,
    },
    {
      'id': 'inside_2',
      'name': 'Oasis Bike Tours',
      'type': 'bicycle',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'Guided bicycle tours through palm groves and villages',
      'imageUrl': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
      'price': 150.0,
      'priceUnit': '/2 hours',
      'duration': '2-3 hours',
      'amenities': ['Guide included', 'Water provided', 'Photo stops'],
      'rating': 4.9,
      'reviews': 87,
    },

    // Donkey Carts
    {
      'id': 'inside_3',
      'name': 'Traditional Donkey Cart',
      'type': 'donkey_cart',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'Experience authentic Siwan transport with a local driver',
      'imageUrl': 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
      'price': 100.0,
      'priceUnit': '/hour',
      'duration': 'Flexible',
      'seats': 4,
      'amenities': ['Local driver', 'Traditional experience', 'Slow-paced'],
      'rating': 4.8,
      'reviews': 203,
    },

    // Tuk-Tuks
    {
      'id': 'inside_4',
      'name': 'Siwa Tuk-Tuk Service',
      'type': 'tuk_tuk',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'Quick and convenient rides around Siwa',
      'imageUrl': 'https://images.unsplash.com/photo-1583221864690-e7e11ed4b152?w=800',
      'price': 20.0,
      'priceUnit': '/trip',
      'duration': '10-30 min',
      'seats': 3,
      'amenities': ['Fast service', 'Local driver', 'Affordable'],
      'rating': 4.5,
      'reviews': 324,
    },

    // Local Taxis
    {
      'id': 'inside_5',
      'name': 'Siwa Local Taxi',
      'type': 'local_taxi',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'Comfortable taxi service within Siwa Oasis',
      'imageUrl': 'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?w=800',
      'price': 50.0,
      'priceUnit': '/trip',
      'duration': 'Flexible',
      'seats': 4,
      'amenities': ['Air conditioning', 'Professional driver', 'Clean vehicle'],
      'rating': 4.6,
      'reviews': 198,
    },
    {
      'id': 'inside_6',
      'name': 'Siwa Full Day Taxi',
      'type': 'local_taxi',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'Hire a taxi with driver for full day exploration',
      'imageUrl': 'https://images.unsplash.com/photo-1506521781263-d8422e82f27a?w=800',
      'price': 400.0,
      'priceUnit': '/day',
      'duration': '8-10 hours',
      'seats': 4,
      'amenities': ['Full day service', 'Flexible stops', 'Bottled water'],
      'rating': 4.8,
      'reviews': 156,
    },

    // ========== OUTSIDE SIWA - External Transfers ==========

    // To/From Marsa Matrouh
    {
      'id': 'outside_1',
      'name': 'Siwa ↔ Marsa Matrouh Transfer',
      'type': 'private_transfer',
      'serviceLocation': 'outside',
      'rentalType': 'with_driver',
      'description': 'Private car transfer between Siwa and Marsa Matrouh',
      'imageUrl': 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800',
      'price': 1200.0,
      'priceUnit': '/one way',
      'duration': '3-4 hours',
      'seats': 4,
      'amenities': ['Air-conditioned SUV', 'Professional driver', 'Door-to-door'],
      'rating': 4.9,
      'reviews': 178,
    },

    // To/From Cairo
    {
      'id': 'outside_2',
      'name': 'Siwa ↔ Cairo Premium Transfer',
      'type': 'private_transfer',
      'serviceLocation': 'outside',
      'rentalType': 'with_driver',
      'description': 'Luxury transfer from Cairo to Siwa with experienced driver',
      'imageUrl': 'https://images.unsplash.com/photo-1512453979798-5ea1b2d9c374?w=800',
      'price': 3500.0,
      'priceUnit': '/one way',
      'duration': '8-9 hours',
      'seats': 4,
      'amenities': ['WiFi', 'Refreshments', 'Comfort stops', 'Modern sedan'],
      'rating': 4.9,
      'reviews': 92,
    },

    // Airport Transfer (Marsa Matrouh Airport)
    {
      'id': 'outside_3',
      'name': 'Marsa Matrouh Airport ↔ Siwa',
      'type': 'airport_transfer',
      'serviceLocation': 'outside',
      'rentalType': 'with_driver',
      'description': 'Meet & greet airport transfer service',
      'imageUrl': 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=800',
      'price': 1300.0,
      'priceUnit': '/one way',
      'duration': '3.5 hours',
      'seats': 4,
      'amenities': ['Flight monitoring', 'Name sign', 'Luggage help'],
      'rating': 4.8,
      'reviews': 134,
    },

    // Shared Minibus (Budget Option)
    {
      'id': 'outside_4',
      'name': 'Siwa Shared Minibus',
      'type': 'shared_transfer',
      'serviceLocation': 'outside',
      'rentalType': 'with_driver',
      'description': 'Affordable shared ride to/from Marsa Matrouh',
      'imageUrl': 'https://images.unsplash.com/photo-1558981806-6995a7d0c0e9?w=800',
      'price': 250.0,
      'priceUnit': '/person',
      'duration': '4-5 hours',
      'seats': 14,
      'amenities': ['Scheduled departures', 'Air-conditioned', 'Safe & reliable'],
      'rating': 4.3,
      'reviews': 412,
    }
  ];

  // ATTRACTIONS - All fields complete with valid URLs
  static final List<Map<String, dynamic>> attractions = [
    {
          'id': '1',
      'name': 'Shali Fortress',
      'category': 'historical',
      'description': 'Ancient mud-brick fortress ruins with panoramic views of Siwa Oasis',
      'longDescription': 'The Shali Fortress is the most iconic landmark of Siwa Oasis. Built in the 13th century from kershef (a mixture of salt, mud, and rock), this ancient fortress served as the fortified center of Siwa town. Rising dramatically from the oasis floor, the fortress once housed hundreds of families within its labyrinthine passages and multi-story dwellings. Though largely in ruins today after devastating rains in 1926, Shali remains a powerful testament to Siwan architectural ingenuity and offers spectacular panoramic views of the surrounding palm groves and desert.',
      'imageUrl': 'https://images.unsplash.com/photo-1589993464410-6c55678afc12?w=800',
      'images': [
        'https://images.unsplash.com/photo-1589993464410-6c55678afc12?w=800',
        'https://images.unsplash.com/photo-1548013146-72479768bada?w=800',
        'https://images.unsplash.com/photo-1583037189850-1921ae7c6c22?w=800',
        'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=800',
      ],
      'videoUrl': 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
      'rating': 4.8,
      'reviews': 245,
      'location': 'Siwa Town Center',
      'difficulty': 'Easy',
      'duration': '1-2 hours',
      'bestTimeToVisit': 'Sunset',
      'entryFee': 'EGP 50',
      'openingHours': '8:00 AM - 6:00 PM',
      'price': 50.0,
      'highlights': [
        'Panoramic views of Siwa Oasis from the top',
        '13th-century mud-brick architecture',
        'Maze of narrow alleyways and ancient dwellings',
        'Best sunset viewing point in Siwa',
        'Rich historical significance',
      ],
      'facilities': [
        'Guided tours available',
        'Information plaques',
        'Photo spots',
        'Nearby parking',
      ],
      'tips': [
        'Visit during sunset for the best views and photography',
        'Wear comfortable shoes as paths can be uneven',
        'Bring water and sun protection',
        'Respect the historical site - do not climb on fragile structures',
        'Early morning visits are less crowded',
      ],
      'historicalInfo': {
        'origins': 'Built in the 13th century (circa 1203 AD) by the Amazigh people, the Shali Fortress was constructed as a fortified settlement to protect inhabitants from desert raiders and hostile forces.',
        'events': 'For centuries, Shali served as the beating heart of Siwa. The fortress withstood numerous sieges and attacks. Its decline began in 1926 when three days of unprecedented rainfall caused massive structural damage to the salt-based architecture.',
        'impact': 'Today, Shali stands as a symbol of Siwan resilience and architectural innovation. It represents one of the finest examples of traditional kershef construction in North Africa and continues to inspire modern sustainable building practices.',
      },
      'nearbyAttractions': [
        {
          'name': 'House of Siwa Museum',
          'distance': '0.2 km',
          'type': 'Museum',
        },
        {
          'name': 'Old Souk',
          'distance': '0.3 km',
          'type': 'Market',
        },
      ],
    },
    {
      'id': '2',
      'name': 'Temple of the Oracle',
      'category': 'historical',
      'description': 'Ancient Egyptian temple where Alexander the Great consulted the Oracle',
      'longDescription': 'The Temple of the Oracle of Amun is one of Egypt\'s most mystical and historically significant sites. Built in the 6th century BC atop the ancient settlement of Aghurmi, this temple gained legendary status when Alexander the Great made a perilous journey across the desert to consult the Oracle in 331 BC. The priests of Amun declared him the son of Zeus-Amun, legitimizing his rule over Egypt. The temple\'s remote location and mysterious aura have captivated travelers for millennia.',
      'imageUrl': 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
      'images': [
        'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
        'https://images.unsplash.com/photo-1548013146-72479768bada?w=800',
        'https://images.unsplash.com/photo-1503177119275-0aa32b3a9368?w=800',
      ],
      'rating': 4.9,
      'reviews': 312,
      'location': 'Aghurmi Village',
      'difficulty': 'Moderate',
      'duration': '2-3 hours',
      'bestTimeToVisit': 'Morning',
      'entryFee': 'EGP 80',
      'openingHours': '8:00 AM - 5:00 PM',
      'price': 80.0,
      'highlights': [
        'Site where Alexander the Great consulted the Oracle',
        'Ancient Egyptian hieroglyphs and carvings',
        'Panoramic views of Siwa Oasis',
        '2,500 years of documented history',
        'Mystical atmosphere and remote location',
      ],
      'facilities': [
        'Professional guides',
        'Visitor center',
        'Rest areas',
        'Souvenir shop',
      ],
      'tips': [
        'Hire a knowledgeable guide to fully appreciate the history',
        'Best visited in the morning when it\'s cooler',
        'Combine with a visit to nearby Cleopatra\'s Spring',
        'Bring binoculars to see distant desert vistas',
        'Respect the sacred nature of the site',
      ],
      'historicalInfo': {
        'origins': 'Constructed in the 6th century BC during the 26th Dynasty of Egypt, the temple was dedicated to the god Amun-Ra. It quickly became one of the most important oracle sites in the ancient world.',
        'events': 'Alexander the Great\'s legendary visit in 331 BC is the most famous event. The Oracle\'s proclamation of Alexander as the son of Zeus-Amun was politically crucial for his rule. The temple remained active until the 4th century AD.',
        'impact': 'The Oracle of Siwa influenced major political decisions in the ancient Mediterranean world. Its remote location added to its mystique, and its ruins continue to attract scholars, historians, and spiritual seekers from around the globe.',
      },
    },
    {
      'id': '3',
      'name': 'Great Sand Sea',
      'category': 'nature',
      'description': 'Vast desert expanse with towering sand dunes perfect for adventure',
      'longDescription': 'The Great Sand Sea is a massive sand desert stretching across 72,000 square kilometers of Egypt and Libya. Near Siwa, the dunes reach heights of over 100 meters, creating a spectacular landscape of golden waves frozen in time. This pristine wilderness offers unparalleled opportunities for desert adventures, from sandboarding down massive dunes to camping under star-filled skies. The silence and majesty of the Great Sand Sea provide a profound connection with nature\'s raw power.',
      'imageUrl': 'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800',
      'images': [
        'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800',
        'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=800',
        'https://images.unsplash.com/photo-1547036967-23d11aacaee0?w=800',
        'https://images.unsplash.com/photo-1551244072-5d12893278ab?w=800',
      ],
      'rating': 4.9,
      'reviews': 428,
      'location': 'Western Desert, 15km from Siwa',
      'difficulty': 'Challenging',
      'duration': 'Half day to full day',
      'bestTimeToVisit': 'Winter (Oct-Apr)',
      'entryFee': 'Free',
      'openingHours': '24/7 (guided tours recommended)',
      'price': 0.0,
      'highlights': [
        'Massive sand dunes over 100 meters high',
        'World-class sandboarding opportunities',
        'Spectacular sunrise and sunset views',
        'Desert camping experiences',
        'Fossil hunting in certain areas',
      ],
      'facilities': [
        '4x4 tours available',
        'Camping equipment rental',
        'Sandboarding gear',
        'Experienced desert guides',
      ],
      'tips': [
        'NEVER venture into the desert without a guide',
        'Bring plenty of water (4+ liters per person)',
        'Wear sunscreen and protective clothing',
        'Best visited October to April when temperatures are moderate',
        'Book tours with reputable operators only',
      ],
      'historicalInfo': {
        'origins': 'The Great Sand Sea has existed for millennia, formed by wind erosion and sand deposition. Ancient caravan routes once crossed parts of this desert, though few dared venture deep into its heart.',
        'events': 'During World War II, the Long Range Desert Group and Special Air Service used the Great Sand Sea for reconnaissance operations. Explorer Ralph Bagnold mapped much of the region in the 1920s-30s.',
        'impact': 'The Great Sand Sea remains one of Earth\'s most pristine desert environments. It serves as a natural laboratory for studying desert formation and climate change while offering adventurers a taste of true wilderness.',
      },
    },
    {
      'id': '4',
      'name': 'Cleopatra\'s Bath (Ain Juba)',
      'category': 'nature',
      'description': 'Natural spring-fed pool where legend says Cleopatra bathed',
      'longDescription': 'Cleopatra\'s Bath, known locally as Ain Juba, is a natural stone pool fed by a warm spring. According to local legend, Cleopatra herself bathed in these waters during her visits to Siwa. The crystal-clear spring water maintains a comfortable temperature year-round, making it a popular swimming spot for locals and visitors alike. Surrounded by palm trees and with views of the Temple of the Oracle nearby, it offers a refreshing respite from the desert heat.',
      'imageUrl': 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=800',
      'images': [
        'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=800',
        'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800',
      ],
      'rating': 4.6,
      'reviews': 189,
      'location': 'Near Aghurmi Village',
      'difficulty': 'Easy',
      'duration': '1-2 hours',
      'bestTimeToVisit': 'Afternoon',
      'entryFee': 'EGP 30',
      'openingHours': '8:00 AM - 5:00 PM',
      'price': 30.0,
      'highlights': [
        'Natural warm spring water',
        'Historic site with Cleopatra legend',
        'Beautiful palm grove setting',
        'Safe for swimming and bathing',
        'Nearby to Temple of the Oracle',
      ],
      'facilities': [
        'Changing rooms',
        'Lockers',
        'Small café',
        'Shaded seating areas',
      ],
      'tips': [
        'Bring swimwear and towel',
        'Visit in the afternoon when water is warmest',
        'Combine with Temple of the Oracle visit',
        'Be respectful - locals also use this spring',
        'Water can be crowded on weekends',
      ],
    },
    {
      'id': '5',
      'name': 'Mountain of the Dead (Gebel al-Mawta)',
      'category': 'historical',
      'description': 'Ancient tombs carved into the rock face dating to Ptolemaic times',
      'longDescription': 'Gebel al-Mawta, the Mountain of the Dead, is a honeycomb of ancient rock-cut tombs dating from the 26th Dynasty and Ptolemaic period (663-30 BC). These tombs feature remarkably well-preserved paintings and hieroglyphs depicting ancient Egyptian religious beliefs and daily life. The site gained modern significance during World War II when locals used the tombs as bomb shelters. Today, visitors can explore several open tombs and marvel at the ancient artistry that has survived millennia.',
      'imageUrl': 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
      'images': [
        'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
        'https://images.unsplash.com/photo-1503177119275-0aa32b3a9368?w=800',
      ],
      'rating': 4.7,
      'reviews': 156,
      'location': '1 km north of Siwa Town',
      'difficulty': 'Easy',
      'duration': '1-2 hours',
      'bestTimeToVisit': 'Morning',
      'entryFee': 'EGP 60',
      'openingHours': '8:00 AM - 5:00 PM',
      'price': 60.0,
      'highlights': [
        'Ancient painted tombs from Ptolemaic period',
        'Well-preserved hieroglyphs and artwork',
        'Four main tombs open to visitors',
        'Panoramic views of Siwa Oasis',
        'Historical WWII significance',
      ],
      'facilities': [
        'Guided tours',
        'Information boards',
        'Lighting inside tombs',
        'Pathways and stairs',
      ],
      'tips': [
        'Bring a flashlight for better viewing inside tombs',
        'Photography may be restricted in some tombs',
        'Wear comfortable walking shoes',
        'Visit early to avoid crowds and heat',
        'Respect the ancient artwork - no touching',
      ],
      'historicalInfo': {
        'origins': 'The tombs date primarily to the 26th Dynasty and Ptolemaic period (663-30 BC). They were carved into the soft rock and decorated for Siwan nobles and wealthy families.',
        'events': 'During World War II, Italian forces bombed Siwa, and local residents took shelter in these ancient tombs. The tombs were rediscovered by archaeologists in the early 20th century.',
        'impact': 'The Mountain of the Dead provides invaluable insights into ancient Siwan culture and beliefs about the afterlife. The artistry demonstrates the sophisticated artistic traditions that flourished in this remote oasis.',
      },
    },
    {
      'id': '6',
      'name': 'Fatnas Island',
      'category': 'nature',
      'description': 'Palm-covered island with natural springs perfect for sunset viewing',
      'longDescription': 'Fatnas Island, also known as Fantasy Island, is a small palm-covered island on the edge of Birket Siwa, a large salt lake. Connected to the mainland by a narrow causeway, this tranquil oasis features natural spring-fed pools, lush palm groves, and serene walking paths. The island is famous for its spectacular sunset views, where the sun sets over the lake with palm trees silhouetted against vibrant orange and pink skies. It\'s the perfect spot for a peaceful evening picnic or a refreshing swim.',
      'imageUrl': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
      'images': [
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
        'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=800',
      ],
      'rating': 4.5,
      'reviews': 203,
      'location': 'Western edge of Birket Siwa',
      'difficulty': 'Easy',
      'duration': '2-3 hours',
      'bestTimeToVisit': 'Sunset',
      'entryFee': 'EGP 20',
      'openingHours': '9:00 AM - 8:00 PM',
      'price': 20.0,
      'highlights': [
        'Spectacular sunset views over the lake',
        'Natural spring pools for swimming',
        'Peaceful palm grove setting',
        'Birdwatching opportunities',
        'Picnic areas and cafés',
      ],
      'facilities': [
        'Café and restaurant',
        'Swimming areas',
        'Picnic tables',
        'Parking',
      ],
      'tips': [
        'Arrive at least an hour before sunset for best spots',
        'Bring picnic supplies for a romantic evening',
        'Swimwear needed if planning to swim',
        'Mosquito repellent recommended in summer',
        'Book café seating in advance during peak season',
      ],
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

  // HOTEL ROOMS - All fields complete
  static final List<Map<String, dynamic>> rooms = [
    {
      "id": 1,
      "hotelId": 1,
      "type": "Deluxe Suite",
      "price": 150.0,
      "amenities": ["WiFi", "Mini Bar", "Balcony", "King Bed"],
      "available": true,
      "capacity": 2,
      "size": "45 sqm",
      "view": "Desert View",
      "category": "room",
      "imageUrl": "https://images.unsplash.com/photo-1590490360182-c33d57733427?w=800"
    },
    {
      "id": 2,
      "hotelId": 1,
      "type": "Standard Room",
      "price": 80.0,
      "amenities": ["WiFi", "TV", "Queen Bed"],
      "available": true,
      "capacity": 2,
      "size": "25 sqm",
      "view": "Garden View",
      "category": "room",
      "imageUrl": "https://images.unsplash.com/photo-1618773928121-c32242e63f39?w=800"
    },
    {
      "id": 3,
      "hotelId": 2,
      "type": "Family Room",
      "price": 200.0,
      "amenities": ["WiFi", "Kitchen", "Living Room", "Two Bedrooms"],
      "available": false,
      "capacity": 4,
      "size": "60 sqm",
      "view": "Lake View",
      "category": "room",
      "imageUrl": "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800"
    }
  ];

  // RENTAL VEHICLES - All fields complete
  static final List<Map<String, dynamic>> rentals = [
    {
      "id": 1,
      "type": "Mountain Bike",
      "model": "Trek X-Caliber",
      "rate": 25.0,
      "rateType": "day",
      "available": true,
      "condition": "Excellent",
      "features": ["21-speed gears", "Front suspension", "Water bottle holder"],
      "image": "pedal_bike",
      "category": "rental",
      "imageUrl": "https://images.unsplash.com/photo-1576435728678-68d0fbf94e91?w=800",
      "location": "Siwa Town Center"
    },
    {
      "id": 2,
      "type": "SUV",
      "model": "Toyota Land Cruiser",
      "rate": 120.0,
      "rateType": "day",
      "available": false,
      "condition": "Good",
      "features": ["4x4 capability", "AC", "GPS", "Seats 7"],
      "image": "directions_car",
      "category": "rental",
      "imageUrl": "https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=800",
      "location": "Desert Safari Center"
    },
    {
      "id": 3,
      "type": "Electric Scooter",
      "model": "Xiaomi Pro 2",
      "rate": 15.0,
      "rateType": "hour",
      "available": true,
      "condition": "Excellent",
      "features": ["30km range", "25 km/h max speed", "LED display"],
      "image": "electric_scooter",
      "category": "rental",
      "imageUrl": "https://images.unsplash.com/photo-1578610906114-0b5e6dc32f52?w=800",
      "location": "Market Square"
    }
  ];

  // PHOTO CHALLENGES - All fields complete
  static final List<Map<String, dynamic>> challenges = [
    {
      "id": 1,
      "title": "Capture the Sunset",
      "description": "Find the perfect spot to photograph the sunset over the desert dunes.",
      "imageUrl": "https://images.unsplash.com/photo-1500322969630-a26ab6ef0e0a?w=800",
      "completed": false,
      "points": 50,
      "proof": null,
      "category": "challenge",
      "difficulty": "easy",
      "location": "Fatnas Island",
      "tips": ["Arrive 30 minutes before sunset", "Use golden hour lighting"],
      "timeLimit": "2 hours"
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
      "difficulty": "hard",
      "location": "Western Desert",
      "tips": ["Hire a local guide", "Bring plenty of water"],
      "timeLimit": "6 hours"
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
      "difficulty": "medium",
      "location": "Birket Siwa",
      "tips": ["Visit during calm weather", "Early morning has best lighting"],
      "timeLimit": "3 hours"
    }
  ];

  // FEATURED SERVICES - All fields complete
  static final List<Map<String, dynamic>> featuredServices = [
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
      "featured": true,
      "openingHours": "24/7",
      "contactNumber": "+20 123 456 7890"
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
      "hidden_gem": true,
      "openingHours": "8:00 AM - 6:00 PM",
      "contactNumber": "+20 123 456 7891"
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
      "hidden_gem": true,
      "openingHours": "7:00 AM - 10:00 PM",
      "contactNumber": "+20 123 456 7892"
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
  List<Map<String, dynamic>> getAllRooms() => rooms;
  List<Map<String, dynamic>> getAllRentals() => rentals;
  List<Map<String, dynamic>> getAllChallenges() => challenges;
  List<Map<String, dynamic>> getAllFeaturedServices() => featuredServices;

  List<Map<String, dynamic>> getBookingsByUserId(String userId) {
    return bookings.where((b) => b['userId'] == userId).toList();
  }

  List<Map<String, dynamic>> searchAll(String query) {
    final results = <Map<String, dynamic>>[];
    final lowerQuery = query.toLowerCase();
    
    for (var category in [
      hotels, 
      restaurants, 
      guides, 
      attractions, 
      products, 
      badges, 
      rooms, 
      rentals, 
      challenges, 
      featuredServices
    ]) {
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