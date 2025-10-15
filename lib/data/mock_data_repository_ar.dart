// lib/data/mock_data_repository_ar.dart
// COMPLETE FIX: All fields populated, no nulls, consistent structure, valid URLs (Arabic version)

class MockDataRepositoryAr {
  static final MockDataRepositoryAr _instance = MockDataRepositoryAr._internal();
  factory MockDataRepositoryAr() => _instance;
  MockDataRepositoryAr._internal();

  // المطاعم - جميع الحقول مطلوبة ومملوءة
  static final List<Map<String, dynamic>> restaurants = [
    {
      "id": 1,
      "name": "مطعم أغرمي",
      "cuisine": "مصري",
      "description": "مأكولات سيوية ومصرية أصيلة بوصفات تقليدية",
      "priceRange": "متوسط",
      "rating": 4.7,
      "reviews": 234,
      "deliveryTime": "30-45 دقيقة",
      "minOrder": 50.0,
      "imageUrl": "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800",
      "specialties": ["تمور سيوية", "خبز تقليدي", "زيتون محلي"],
      "openNow": true,
      "openingHours": "8:00 ص - 11:00 م",
      "deliveryFee": 15.0,
      "category": "restaurant",
      "location": "وسط سيوة"
    },
    {
      "id": 2,
      "name": "مطبخ عبدو",
      "cuisine": "تقليدي",
      "description": "وجبات سيوية منزلية تقليدية مصنوعة بحب",
      "priceRange": "منخفض",
      "rating": 4.9,
      "reviews": 456,
      "deliveryTime": "20-30 دقيقة",
      "minOrder": 30.0,
      "imageUrl": "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800",
      "specialties": ["بيتزا سيوية", "حلويات التمر"],
      "openNow": true,
      "openingHours": "7:00 ص - 10:00 م",
      "deliveryFee": 10.0,
      "category": "restaurant",
      "location": "قرية الشالي"
    },
    {
      "id": 3,
      "name": "بيسترو الواحة",
      "cuisine": "دولي",
      "description": "تقاطع دولي بمكونات محلية ولمسة عصرية",
      "priceRange": "عالي",
      "rating": 4.6,
      "reviews": 189,
      "deliveryTime": "40-60 دقيقة",
      "minOrder": 100.0,
      "imageUrl": "https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800",
      "specialties": ["برغر فاخر", "أطباق مختلطة"],
      "openNow": true,
      "openingHours": "12:00 م - 12:00 ص",
      "deliveryFee": 25.0,
      "category": "restaurant",
      "location": "وسط سيوة المدينة"
    },
    {
      "id": 4,
      "name": "كافيه تمور سيوة",
      "cuisine": "كافيه",
      "description": "قهوة متخصصة وحلويات التمر المحلية في أجواء مريحة",
      "priceRange": "منخفض",
      "rating": 4.8,
      "reviews": 345,
      "deliveryTime": "15-25 دقيقة",
      "minOrder": 25.0,
      "imageUrl": "https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800",
      "specialties": ["قهوة التمر", "معجنات"],
      "openNow": true,
      "openingHours": "6:00 ص - 9:00 م",
      "deliveryFee": 10.0,
      "category": "restaurant",
      "location": "ساحة السوق"
    },
    {
      "id": 5,
      "name": "مطعم الشواء الصحراوي",
      "cuisine": "شواء",
      "description": "لحوم مشوية وتخصصات BBQ بأماكن جلوس خارجية",
      "priceRange": "متوسط",
      "rating": 4.5,
      "reviews": 278,
      "deliveryTime": "35-50 دقيقة",
      "minOrder": 80.0,
      "imageUrl": "https://images.unsplash.com/photo-1544025162-d76694265947?w=800",
      "specialties": ["كباب", "دجاج مشوي"],
      "openNow": false,
      "openingHours": "5:00 م - 12:00 ص",
      "deliveryFee": 20.0,
      "category": "restaurant",
      "location": "منطقة أشجار النخيل"
    },
    {
      "id": 6,
      "name": "مطعم شجرة النخيل",
      "cuisine": "متوسطي",
      "description": "نكهات متوسطية بلمسة مصرية ومكونات طازجة",
      "priceRange": "متوسط",
      "rating": 4.7,
      "reviews": 312,
      "deliveryTime": "30-40 دقيقة",
      "minOrder": 60.0,
      "imageUrl": "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800",
      "specialties": ["طبق المزة", "سلطات طازجة"],
      "openNow": true,
      "openingHours": "11:00 ص - 11:00 م",
      "deliveryFee": 15.0,
      "category": "restaurant",
      "location": "قرب عين كليوباترا"
    }
  ];

  // الدليل السياحي - جميع الحقول مطلوبة ومملوءة
  static final List<Map<String, dynamic>> guides = [
    {
      "id": 1,
      "name": "أحمد حسن",
      "specialty": "تاريخ",
      "experience": 15,
      "rating": 4.9,
      "reviews": 234,
      "hourlyRate": 150.0,
      "price": 150.0,
      "imageUrl": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
      "bio": "خبير في تاريخ سيوة والآثار المصرية القديمة بأكثر من 15 عامًا من الخبرة في توجيه السياح الدوليين",
      "languages": ["العربية", "الإنجليزية", "الفرنسية"],
      "specialties": ["مصر القديمة", "ثقافة سيوة", "مواقع أثرية"],
      "certifications": ["دليل سياحي مرخص", "درجة في الآثار"],
      "Mon": true,
      "Tue": true,
      "Wed": false,
      "Thu": true,
      "Fri": true,
      "Sat": true,
      "Sun": true,
      "verified": true,
      "responseTime": "< 1 ساعة",
      "category": "guide",
      "location": "واحة سيوة"
    },
    {
      "id": 2,
      "name": "فاطمة السيوية",
      "specialty": "ثقافة",
      "experience": 10,
      "rating": 4.8,
      "reviews": 189,
      "hourlyRate": 120.0,
      "price": 120.0,
      "imageUrl": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
      "bio": "دليلة سيوية أصلية متخصصة في الثقافة المحلية، التقاليد، الحرف اليدوية وتراث النساء",
      "languages": ["العربية", "الإنجليزية"],
      "specialties": ["ثقافة سيوة", "الحرف اليدوية", "تراث النساء"],
      "certifications": ["دليل سياحي مرخص", "شهادة التراث الثقافي"],
      "Mon": true,
      "Tue": true,
      "Wed": true,
      "Thu": true,
      "Fri": false,
      "Sat": true,
      "Sun": false,
      "verified": true,
      "responseTime": "< 2 ساعة",
      "category": "guide",
      "location": "قرية الشالي"
    },
    {
      "id": 3,
      "name": "محمد سعيد",
      "specialty": "مغامرة",
      "experience": 8,
      "rating": 4.9,
      "reviews": 312,
      "hourlyRate": 180.0,
      "price": 180.0,
      "imageUrl": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
      "bio": "متخصص في المغامرات الصحراوية، التزلج على الرمال والرياضات المتطرفة مع تدريب أمان معتمد",
      "languages": ["العربية", "الإنجليزية", "الألمانية"],
      "specialties": ["جولات صحراوية", "تزلج على الرمال", "مغامرات 4x4"],
      "certifications": ["دليل سياحي مرخص", "الإسعافات الأولية في البرية", "قيادة الطرق الوعرة"],
      "Mon": true,
      "Tue": true,
      "Wed": true,
      "Thu": true,
      "Fri": true,
      "Sat": true,
      "Sun": true,
      "verified": true,
      "responseTime": "< 30 دقيقة",
      "category": "guide",
      "location": "معسكرات الصحراء"
    },
    {
      "id": 4,
      "name": "سارة إبراهيم",
      "specialty": "طبيعة",
      "experience": 6,
      "rating": 4.7,
      "reviews": 156,
      "hourlyRate": 100.0,
      "price": 100.0,
      "imageUrl": "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400",
      "bio": "متخصصة في السياحة البيئية تركز على ينابيع سيوة، البحيرات، الحياة البرية والحفاظ على البيئة",
      "languages": ["العربية", "الإنجليزية"],
      "specialties": ["مشاهدة الطيور", "التصوير الطبيعي", "جولات بيئية"],
      "certifications": ["دليل سياحي مرخص", "شهادة السياحة البيئية"],
      "Mon": true,
      "Tue": false,
      "Wed": true,
      "Thu": true,
      "Fri": true,
      "Sat": true,
      "Sun": true,
      "verified": true,
      "responseTime": "< 3 ساعات",
      "category": "guide",
      "location": "بركة سيوة"
    },
    {
      "id": 5,
      "name": "خالد مصطفى",
      "specialty": "تصوير",
      "experience": 12,
      "rating": 4.8,
      "reviews": 267,
      "hourlyRate": 200.0,
      "price": 200.0,
      "imageUrl": "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400",
      "bio": "مصور احترافي ودليل متخصص في جولات التصوير الطبيعي والثقافي",
      "languages": ["العربية", "الإنجليزية", "الإيطالية"],
      "specialties": ["جولات تصوير", "تصوير الطبيعة", "توثيق الثقافة"],
      "certifications": ["دليل سياحي مرخص", "شهادة التصوير الاحترافي"],
      "Mon": true,
      "Tue": true,
      "Wed": true,
      "Thu": false,
      "Fri": true,
      "Sat": true,
      "Sun": true,
      "verified": true,
      "responseTime": "< 1 ساعة",
      "category": "guide",
      "location": "مواقع متنوعة"
    }
  ];

  // النقل - جميع الحقول متسقة ومملوءة
  static final List<Map<String, dynamic>> transportation = [
    {
      "id": 1,
      "name": "حافلة سيوة السريعة",
      "type": "حافلة",
      "plate": "ABC123",
      "verified": true,
      "capacity": 45,
      "seats": 45,
      "route": "القاهرة - سيوة",
      "price": 150.0,
      "duration": "8 ساعات",
      "rating": 4.5,
      "reviews": 234,
      "departures": ["06:00 ص", "10:00 م"],
      "imageUrl": "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=800",
      "amenities": ["تكييف", "واي فاي", "مقاعد قابلة للنصب", "مطاعم على الطريق"],
      "description": "خدمة حافلة سريعة مريحة بمرافق حديثة",
      "category": "transportation",
      "location": "مسار القاهرة إلى سيوة"
    },
    {
      "id": 2,
      "name": "خدمة تاكسي الصحراء",
      "type": "تأكسي",
      "plate": "XYZ789",
      "verified": true,
      "capacity": 4,
      "seats": 4,
      "route": "جولات واحة سيوة",
      "price": 300.0,
      "duration": "مرن",
      "rating": 4.8,
      "reviews": 156,
      "departures": ["عند الطلب"],
      "imageUrl": "https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?w=800",
      "amenities": ["تكييف", "سائق محترف", "دليل محلي"],
      "description": "خدمة تاكسي خاصة لجولات واحة شخصية",
      "category": "transportation",
      "location": "مدينة سيوة"
    },
    {
      "id": 3,
      "name": "نقل فان فاخر",
      "type": "فان",
      "plate": "LUX456",
      "verified": true,
      "capacity": 8,
      "seats": 8,
      "route": "المطار - فنادق سيوة",
      "price": 500.0,
      "duration": "7 ساعات",
      "rating": 4.9,
      "reviews": 89,
      "departures": ["حجز مرن", "08:00 ص", "02:00 م"],
      "imageUrl": "https://images.unsplash.com/photo-1527786356703-4b100091cd2c?w=800",
      "amenities": ["تكييف", "واي فاي", "مشروبات", "مساحة أمتعة"],
      "description": "خدمة نقل فاخرة براحة وأناقة",
      "category": "transportation",
      "location": "مسار المطار"
    },
    {
      "id": 4,
      "name": "خط حافلات الميزانية",
      "type": "حافلة",
      "plate": "BDG789",
      "verified": true,
      "capacity": 50,
      "seats": 50,
      "route": "الإسكندرية - سيوة",
      "price": 100.0,
      "duration": "6 ساعات",
      "rating": 4.2,
      "reviews": 312,
      "departures": ["07:00 ص", "03:00 م"],
      "imageUrl": "https://images.unsplash.com/photo-1570125909232-eb263c188f7e?w=800",
      "amenities": ["تكييف", "مقاعد قياسية"],
      "description": "خدمة حافلات اقتصادية للمسافرين ذوي الميزانية المحدودة",
      "category": "transportation",
      "location": "مسار الإسكندرية"
    },
    {
      "id": 5,
      "name": "مغامرة صحراوية 4x4",
      "type": "4x4",
      "plate": "DST321",
      "verified": true,
      "capacity": 7,
      "seats": 7,
      "route": "جولة بحر الرمال الكبير",
      "price": 400.0,
      "duration": "يوم كامل",
      "rating": 4.9,
      "reviews": 178,
      "departures": ["08:00 ص", "02:00 م"],
      "imageUrl": "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=800",
      "amenities": ["مركبة 4x4", "معدات أمان", "وجبات خفيفة", "ماء"],
      "description": "تجربة مغامرة صحراوية مثيرة في بحر الرمال الكبير",
      "category": "transportation",
      "location": "معسكرات الصحراء"
    }
  ];

  // المعالم السياحية - جميع الحقول مكتملة مع روابط صالحة
  static final List<Map<String, dynamic>> attractions = [
    {
      "id": 1,
      "name": "معبد الوحي",
      "category": "تاريخي",
      "description": "معبد قديم حيث استشار الإسكندر الأكبر وحي أمون",
      "price": 50.0,
      "duration": "2 ساعات",
      "rating": 4.8,
      "reviews": 456,
      "imageUrl": "https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800",
      "location": "قرية أغرمي",
      "openingHours": "8:00 ص - 5:00 م",
      "difficulty": "سهل",
      "highlights": ["تاريخ قديم", "موقع أثري", "إطلالات بانورامية"],
      "tags": ["تاريخ", "آثار", "قديم"],
      "featured": true
    },
    {
      "id": 2,
      "name": "بحيرات الملح في سيوة",
      "category": "طبيعي",
      "description": "بحيرات ملح صافية بصفات علاجية ومناظر خلابة",
      "price": 30.0,
      "duration": "3 ساعات",
      "rating": 4.9,
      "reviews": 789,
      "imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800",
      "location": "بركة سيوة",
      "openingHours": "24/7",
      "difficulty": "سهل",
      "highlights": ["سباحة", "استرخاء", "تصوير"],
      "tags": ["طبيعة", "سباحة", "استرخاء"],
      "eco_friendly": true,
      "featured": true
    },
    {
      "id": 3,
      "name": "حصن الشالي",
      "category": "تاريخي",
      "description": "حصن طوب طيني قديم بإطلالات بانورامية على الواحة وعمارة تقليدية",
      "price": 25.0,
      "duration": "1.5 ساعات",
      "rating": 4.6,
      "reviews": 324,
      "imageUrl": "https://images.unsplash.com/photo-1548013146-72479768bada?w=800",
      "location": "مركز مدينة سيوة",
      "openingHours": "8:00 ص - 6:00 م",
      "difficulty": "متوسط",
      "highlights": ["عمارة", "تاريخ", "إطلالات غروب الشمس"],
      "tags": ["تاريخ", "عمارة", "ثقافة"],
      "featured": false
    },
    {
      "id": 4,
      "name": "حمام كليوباترا",
      "category": "طبيعي",
      "description": "بركة ينبوع طبيعي بماء صاف وأهمية تاريخية",
      "price": 20.0,
      "duration": "2 ساعات",
      "rating": 4.7,
      "reviews": 612,
      "imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
      "location": "قرب مدينة سيوة",
      "openingHours": "7:00 ص - 7:00 م",
      "difficulty": "سهل",
      "highlights": ["سباحة", "ينبوع طبيعي", "موقع تاريخي"],
      "tags": ["طبيعة", "سباحة", "تاريخ"],
      "eco_friendly": true,
      "hidden_gem": true
    },
    {
      "id": 5,
      "name": "جولة بحر الرمال الكبير",
      "category": "مغامرة",
      "description": "مغامرة صحراوية مثيرة بمركبة 4x4 عبر الكثبان الرملية الضخمة",
      "price": 200.0,
      "duration": "6 ساعات",
      "rating": 4.9,
      "reviews": 234,
      "imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
      "location": "الصحراء الغربية",
      "openingHours": "حسب الموعد",
      "difficulty": "صعب",
      "highlights": ["تزلج على الرمال", "مغامرة 4x4", "إطلالات غروب الشمس"],
      "tags": ["مغامرة", "صحراء", "متطرف"],
      "featured": true
    },
    {
      "id": 6,
      "name": "غروب الشمس في جزيرة فتناس",
      "category": "طبيعي",
      "description": "جزيرة مغطاة بالنخيل مثالية لمشاهدة غروب الشمس والاسترخاء",
      "price": 15.0,
      "duration": "2 ساعات",
      "rating": 4.8,
      "reviews": 445,
      "imageUrl": "https://images.unsplash.com/photo-1500322969630-a26ab6ef0e0a?w=800",
      "location": "بركة سيوة",
      "openingHours": "4:00 م - 7:00 م",
      "difficulty": "سهل",
      "highlights": ["إطلالات غروب الشمس", "تصوير", "طبيعة"],
      "tags": ["طبيعة", "غروب الشمس", "تصوير"],
      "eco_friendly": true,
      "hidden_gem": true
    },
    {
      "id": 7,
      "name": "جبل الموتى",
      "category": "تاريخي",
      "description": "مدفن قديم برسومات مقابر محفوظة من الفترة اليونانية الرومانية",
      "price": 40.0,
      "duration": "1.5 ساعات",
      "rating": 4.5,
      "reviews": 267,
      "imageUrl": "https://images.unsplash.com/photo-1503756234508-e32369269deb?w=800",
      "location": "جبل الموتى",
      "openingHours": "8:00 ص - 5:00 م",
      "difficulty": "متوسط",
      "highlights": ["مقابر قديمة", "آثار", "تاريخ"],
      "tags": ["تاريخ", "آثار", "قديم"],
      "featured": false
    },
    {
      "id": 8,
      "name": "متحف بيت سيوة",
      "category": "ثقافي",
      "description": "بيت سيوي تقليدي يعرض الثقافة المحلية، الحرف اليدوية والحياة اليومية",
      "price": 35.0,
      "duration": "1 ساعة",
      "rating": 4.4,
      "reviews": 189,
      "imageUrl": "https://images.unsplash.com/photo-1565711561500-691d9ec04506?w=800",
      "location": "مدينة سيوة",
      "openingHours": "9:00 ص - 4:00 م",
      "difficulty": "سهل",
      "highlights": ["التراث الثقافي", "الحرف اليدوية", "الحياة المحلية"],
      "tags": ["ثقافة", "متحف", "تقليدي"],
      "hidden_gem": true
    }
  ];

  // المنتجات - جميع الحقول مكتملة
  static final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "زيت زيتون سيوة",
      "price": 25.0,
      "stock": 45,
      "category": "طعام",
      "lowStockThreshold": 20,
      "image": "https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400",
      "description": "زيت زيتون بكر فائق من زيتون سيوة المحلي",
      "rating": 4.8,
      "reviews": 156,
      "imageUrl": "https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400"
    },
    {
      "id": 2,
      "name": "سلة منسوجة يدويًا",
      "price": 35.0,
      "stock": 12,
      "category": "حرف يدوية",
      "lowStockThreshold": 15,
      "image": "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400",
      "description": "سلة نخيل تقليدية منسوجة يدويًا من قبل الحرفيين المحليين",
      "rating": 4.7,
      "reviews": 89,
      "imageUrl": "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=400"
    },
    {
      "id": 3,
      "name": "عسل نخيل التمر",
      "price": 30.0,
      "stock": 8,
      "category": "طعام",
      "lowStockThreshold": 10,
      "image": "https://images.unsplash.com/photo-1587049352846-4a222e784169?w=400",
      "description": "عسل طبيعي نقي من أزهار نخيل التمر",
      "rating": 4.9,
      "reviews": 234,
      "imageUrl": "https://images.unsplash.com/photo-1587049352846-4a222e784169?w=400"
    },
    {
      "id": 4,
      "name": "مصباح ملح سيوة",
      "price": 50.0,
      "stock": 25,
      "category": "حرف يدوية",
      "lowStockThreshold": 15,
      "image": "https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400",
      "description": "مصباح بلور ملح طبيعي من بحيرات ملح سيوة",
      "rating": 4.6,
      "reviews": 112,
      "imageUrl": "https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400"
    },
    {
      "id": 5,
      "name": "فخار تقليدي",
      "price": 40.0,
      "stock": 18,
      "category": "حرف يدوية",
      "lowStockThreshold": 10,
      "image": "https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?w=400",
      "description": "فخار طيني يدوي بتصاميم سيوية تقليدية",
      "rating": 4.8,
      "reviews": 145,
      "imageUrl": "https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?w=400"
    }
  ];

  // الحجوزات - هيكل متسق تمامًا
  static final List<Map<String, dynamic>> bookings = [
    {
      "id": 1001,
      "title": "منتجع شالي سيوة",
      "guest": "سارة جونسون",
      "room": "جناح فاخر",
      "date": DateTime(2025, 10, 17),
      "checkIn": DateTime(2025, 10, 17),
      "checkOut": DateTime(2025, 10, 20),
      "status": "تم التأكيد",
      "imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
      "amount": "\$450",
      "category": "accommodation",
      "location": "وسط سيوة"
    },
    {
      "id": 1002,
      "title": "مغامرة صحراوية",
      "guest": "أحمد حسن",
      "room": "غير محدد",
      "date": DateTime(2025, 10, 20),
      "checkIn": DateTime(2025, 10, 20),
      "checkOut": DateTime(2025, 10, 20),
      "status": "تم التأكيد",
      "imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
      "amount": "\$200",
      "category": "tour",
      "location": "بحر الرمال الكبير"
    },
    {
      "id": 1003,
      "title": "استئجار دراجة جبلية",
      "guest": "إيميلي تشن",
      "room": "غير محدد",
      "date": DateTime(2025, 10, 22),
      "checkIn": DateTime(2025, 10, 22),
      "checkOut": DateTime(2025, 10, 24),
      "status": "قيد الانتظار",
      "imageUrl": "https://images.unsplash.com/photo-1571333250630-f0230c320b6d?w=800",
      "amount": "\$50",
      "category": "rental",
      "location": "مدينة سيوة"
    },
    {
      "id": 1004,
      "title": "حجز في بيسترو الواحة",
      "guest": "محمد علي",
      "room": "غير محدد",
      "date": DateTime(2025, 10, 18),
      "checkIn": DateTime(2025, 10, 18),
      "checkOut": DateTime(2025, 10, 18),
      "status": "تم التأكيد",
      "imageUrl": "https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800",
      "amount": "\$120",
      "category": "restaurant",
      "location": "وسط سيوة المدينة"
    },
    {
      "id": 1005,
      "title": "حافلة سيوة السريعة",
      "guest": "ليلى إبراهيم",
      "room": "غير محدد",
      "date": DateTime(2025, 10, 25),
      "checkIn": DateTime(2025, 10, 25),
      "checkOut": DateTime(2025, 10, 25),
      "status": "قيد الانتظار",
      "imageUrl": "https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?w=800",
      "amount": "\$150",
      "category": "transportation",
      "location": "القاهرة إلى سيوة"
    },
    {
      "id": 1006,
      "title": "جولة معبد الوحي",
      "guest": "جيمس سميث",
      "room": "غير محدد",
      "date": DateTime(2025, 10, 19),
      "checkIn": DateTime(2025, 10, 19),
      "checkOut": DateTime(2025, 10, 19),
      "status": "تم التأكيد",
      "imageUrl": "https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800",
      "amount": "\$50",
      "category": "attraction",
      "location": "قرية أغرمي"
    },
    {
      "id": 1007,
      "title": "مطعم شجرة النخيل",
      "guest": "فاطمة أحمد",
      "room": "غير محدد",
      "date": DateTime(2025, 10, 16),
      "checkIn": DateTime(2025, 10, 16),
      "checkOut": DateTime(2025, 10, 16),
      "status": "ملغية",
      "imageUrl": "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800",
      "amount": "\$75",
      "category": "restaurant",
      "location": "قرب عين كليوباترا"
    }
  ];

  // الفنادق - جميع الحقول مكتملة
  static final List<Map<String, dynamic>> hotels = [
    {
      "id": 1,
      "name": "منتجع شالي سيوة",
      "type": "مضيفة بيئية",
      "description": "منتجع صديق للبيئة بتصميم معماري سيوي تقليدي ومرافق حديثة",
      "pricePerNight": 120.0,
      "price": 120.0,
      "rating": 4.8,
      "reviews": 320,
      "imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
      "amenities": ["واي فاي", "مسبح", "إفطار مشمول", "سبا", "مطعم"],
      "location": "وسط سيوة",
      "checkInTime": "2:00 م",
      "checkOutTime": "12:00 م",
      "openNow": true,
      "starRating": 4,
      "category": "accommodation",
      "eco_friendly": true,
      "featured": true
    },
    {
      "id": 2,
      "name": "فندق الورد الصحراوي",
      "type": "فندق",
      "description": "فندق فاخر بإطلالات على بحر الرمال الكبير وخدمات متميزة",
      "pricePerNight": 200.0,
      "price": 200.0,
      "rating": 4.9,
      "reviews": 450,
      "imageUrl": "https://images.unsplash.com/photo-1542314831-8d7e7b9e0f97?w=800",
      "amenities": ["واي فاي", "سبا", "مطعم", "مسبح", "صالة رياضية", "خدمة الغرف"],
      "location": "قرب بحيرة سيوة",
      "checkInTime": "3:00 م",
      "checkOutTime": "11:00 ص",
      "openNow": true,
      "starRating": 5,
      "category": "accommodation",
      "featured": true
    },
    {
      "id": 3,
      "name": "بيت ضيافة الواحة",
      "type": "بيت ضيافة",
      "description": "بيت ضيافة مريح بضيافة سيوية أصيلة وأجواء عائلية",
      "pricePerNight": 60.0,
      "price": 60.0,
      "rating": 4.6,
      "reviews": 180,
      "imageUrl": "https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=800",
      "amenities": ["واي فاي", "حديقة", "مواقف مجانية", "إفطار"],
      "location": "قرية الشالي",
      "checkInTime": "1:00 م",
      "checkOutTime": "12:00 م",
      "openNow": true,
      "starRating": 3,
      "category": "accommodation",
      "hidden_gem": true
    },
    {
      "id": 4,
      "name": "منزل أشجار النخيل",
      "type": "مضيفة",
      "description": "مضيفة ريفية محاطة بأشجار النخيل بأجواء هادئة",
      "pricePerNight": 80.0,
      "price": 80.0,
      "rating": 4.7,
      "reviews": 250,
      "imageUrl": "https://images.unsplash.com/photo-1596436889106-be35e843f974?w=800",
      "amenities": ["إفطار مشمول", "جلوس خارجي", "حديقة", "مواقف مجانية"],
      "location": "قرب عين كليوباترا",
      "checkInTime": "2:00 م",
      "checkOutTime": "11:00 ص",
      "openNow": true,
      "starRating": 3,
      "category": "accommodation",
      "eco_friendly": true
    },
    {
      "id": 5,
      "name": "معسكر الكثبان الرملية",
      "type": "معسكر",
      "description": "تجربة معسكر صحراوي بأجواء بدوية ومشاهدة النجوم",
      "pricePerNight": 50.0,
      "price": 50.0,
      "rating": 4.5,
      "reviews": 150,
      "imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800",
      "amenities": ["نار معسكر", "جولات مرشدة", "وجبات تقليدية", "خيام بدوية"],
      "location": "بحر الرمال الكبير",
      "checkInTime": "4:00 م",
      "checkOutTime": "10:00 ص",
      "openNow": true,
      "starRating": 2,
      "category": "accommodation",
      "hidden_gem": true
    }
  ];

  // المراجعات - جميع الحقول مكتملة
  static final List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "userId": "user123",
      "itemId": "1",
      "itemType": "hotel",
      "rating": 5.0,
"comment": "إقامة رائعة في منتجع شالي سيوة! التصميم البيئي والضيافة الدافئة جعلاها لا تُنسى.",
"date": "2025-09-15",
"userName": "أماني حسن",
"verified": true,
"helpful": 23
},
{
"id": 2,
"userId": "user456",
"itemId": "2",
"itemType": "restaurant",
"rating": 4.8,
"comment": "مطبخ عبدو قدم أفضل بيتزا سيوية تذوقتها! أوصي به بشدة.",
"date": "2025-08-20",
"userName": "يوسف أحمد",
"verified": true,
"helpful": 18
},
{
"id": 3,
"userId": "user789",
"itemId": "3",
"itemType": "guide",
"rating": 4.9,
"comment": "جولة محمد سعيد الصحراوية كانت مثيرة! معرفته بسيوة جعلت الجولة استثنائية.",
"date": "2025-07-10",
"userName": "ليلى محمد",
"verified": true,
"helpful": 31
},
{
"id": 4,
"userId": "user101",
"itemId": "1",
"itemType": "transportation",
"rating": 4.5,
"comment": "حافلة سيوة السريعة كانت مريحة وفي الموعد، رائعة للرحلات الطويلة.",
"date": "2025-06-05",
"userName": "خالد عمر",
"verified": true,
"helpful": 12
},
{
"id": 5,
"userId": "user102",
"itemId": "4",
"itemType": "restaurant",
"rating": 4.7,
"comment": "كافيه تمور سيوة يقدم أفضل قهوة تمر وأجواء مريحة.",
"date": "2025-05-12",
"userName": "سارة علي",
"verified": true,
"helpful": 15
}
];
// الأوسمة - جميع الحقول مكتملة مع روابط صالحة
static final List<Map<String, dynamic>> badges = [
{
"id": 1,
"name": "مستكشف الواحة الخفية",
"description": "اكتشاف واحة خفية",
"imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=400",
"points": 75,
"rarity": "نادر"
},
{
"id": 2,
"name": "مصور غروب الشمس",
"description": "التقطت غروب الشمس المثالي",
"imageUrl": "https://images.unsplash.com/photo-1500322969630-a26ab6ef0e0a?w=400",
"points": 50,
"rarity": "شائع"
},
{
"id": 3,
"name": "سباح بحيرة الملح",
"description": "سبحت في بحيرات الملح",
"imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400",
"points": 60,
"rarity": "غير شائع"
}
];
// بيانات أخرى - جميع الحقول مكتملة (للتحديات، إلخ)
static final List<Map<String, dynamic>> other = [
// غرف الفندق
{
"id": 1,
"type": "جناح فاخر",
"price": 150.0,
"amenities": ["واي فاي", "بار صغير", "شرفة"],
"available": true,
"category": "room"
},
{
"id": 2,
"type": "غرفة قياسية",
"price": 80.0,
"amenities": ["واي فاي", "تلفاز"],
"available": true,
"category": "room"
},
{
"id": 3,
"type": "غرفة عائلية",
"price": 200.0,
"amenities": ["واي فاي", "مطبخ", "غرفة معيشة"],
"available": false,
"category": "room"
},
// مركبات للإيجار
{
"id": 1,
"type": "دراجة جبلية",
"model": "Trek X-Caliber",
"rate": 25.0,
"rateType": "يوم",
"available": true,
"condition": "ممتاز",
"image": "pedal_bike",
"category": "rental"
},
{
"id": 2,
"type": "سيارة SUV",
"model": "Toyota Land Cruiser",
"rate": 120.0,
"rateType": "يوم",
"available": false,
"condition": "جيد",
"image": "directions_car",
"category": "rental"
},
{
"id": 3,
"type": "سكوتر كهربائي",
"model": "Xiaomi Pro 2",
"rate": 15.0,
"rateType": "ساعة",
"available": true,
"condition": "ممتاز",
"image": "electric_scooter",
"category": "rental"
},
// تحديات التصوير
{
"id": 1,
"title": "التقط غروب الشمس",
"description": "ابحث عن الموقع المثالي لتصوير غروب الشمس فوق الكثبان الرملية.",
"imageUrl": "https://images.unsplash.com/photo-1500322969630-a26ab6ef0e0a?w=800",
"completed": false,
"points": 50,
"proof": null,
"category": "challenge",
"difficulty": "سهل"
},
{
"id": 2,
"title": "الواحة الخفية",
"description": "اكتشف واصور واحة خفية في صحراء سيوة.",
"imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
"completed": false,
"points": 75,
"proof": null,
"category": "challenge",
"difficulty": "صعب"
},
{
"id": 3,
"title": "انعكاس بحيرة الملح",
"description": "التقط انعكاسات رائعة على سطح بحيرات الملح.",
"imageUrl": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800",
"completed": false,
"points": 60,
"proof": null,
"category": "challenge",
"difficulty": "متوسط"
},
// الخدمات المميزة
{
"id": 1,
"name": "منتجع شالي سيوة",
"price": 120.0,
"rating": 4.5,
"location": "سيوة، مصر",
"imageUrl": "https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800",
"eco_friendly": true,
"reviews": 125,
"category": "accommodation",
"description": "منتجع فاخر صديق للبيئة بتصميم معماري تقليدي",
"tags": ["فاخر", "بيئي"],
"featured": true
},
{
"id": 2,
"name": "مغامرة صحراوية",
"price": 80.0,
"rating": 4.6,
"location": "صحراء سيوة",
"imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
"reviews": 128,
"category": "attraction",
"description": "جولة صحراوية مثيرة بمركبة 4x4",
"tags": ["مغامرة", "صحراء"],
"hidden_gem": true
},
{
"id": 3,
"name": "مطعم عبدو",
"price": 25.0,
"rating": 4.8,
"location": "ساحة السوق، سيوة",
"imageUrl": "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800",
"reviews": 234,
"category": "restaurant",
"description": "مأكولات سيوية تقليدية",
"tags": ["تقليدي", "محلي"],
"hidden_gem": true
}
];
// طرق الوصول
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
final mockDataAr = MockDataRepositoryAr();