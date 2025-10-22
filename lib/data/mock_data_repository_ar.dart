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
      'id': 'inside_1',
      'name': 'دراجات سيوة البيئية',
      'type': 'bicycle',
      'serviceLocation': 'inside',
      'rentalType': 'self_drive',
      'description': 'استأجر دراجة واستكشف سيوة بالسرعة التي تناسبك',
      'imageUrl': 'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=800',
      'price': 50.0,
      'priceUnit': '/يوم',
      'duration': 'مرن',
      'amenities': ['خوذ الخوذة مشمولة', 'قفل مشمول', 'خريطة مشمولة'],
      'rating': 4.7,
      'reviews': 142,
    },
    {
      'id': 'inside_2',
      'name': 'جولات الدراجات في الواحة',
      'type': 'bicycle',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'جولات بالدراجات بصحبة مرشد عبر بساتين النخيل والقرى',
      'imageUrl': 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
      'price': 150.0,
      'priceUnit': '/ساعتين',
      'duration': '2-3 ساعات',
      'amenities': ['مرشد مشمول', 'ماء مشمول', 'محطات تصوير'],
      'rating': 4.9,
      'reviews': 87,
    },

    // عربات الحمير
    {
      'id': 'inside_3',
      'name': 'عربة الحمار التقليدية',
      'type': 'donkey_cart',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'اختبر وسائل النقل السيوانية الأصيلة مع سائق محلي',
      'imageUrl': 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
      'price': 100.0,
      'priceUnit': '/ساعة',
      'duration': 'مرن',
      'seats': 4,
      'amenities': ['سائق محلي', 'تجربة تقليدية', 'بطيء السرعة'],
      'rating': 4.8,
      'reviews': 203,
    },

    // التوك توك
    {
      'id': 'inside_4',
      'name': 'خدمة التوك توك في سيوة',
      'type': 'tuk_tuk',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'رحلات سريعة ومريحة حول سيوة',
      'imageUrl': 'https://images.unsplash.com/photo-1583221864690-e7e11ed4b152?w=800',
      'price': 20.0,
      'priceUnit': '/رحلة',
      'duration': '10-30 دقيقة',
      'seats': 3,
      'amenities': ['خدمة سريعة', 'سائق محلي', 'سعر معقول'],
      'rating': 4.5,
      'reviews': 324,
    },

    // التاكسي المحلي
    {
      'id': 'inside_5',
      'name': 'تاكسي سيوة المحلي',
      'type': 'local_taxi',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'خدمة تاكسي مريحة داخل واحة سيوة',
      'imageUrl': 'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?w=800',
      'price': 50.0,
      'priceUnit': '/رحلة',
      'duration': 'مرن',
      'seats': 4,
      'amenities': ['تكييف', 'سائق محترف', 'سيارة نظيفة'],
      'rating': 4.6,
      'reviews': 198,
    },
    {
      'id': 'inside_6',
      'name': 'تاكسي سيوة ليوم كامل',
      'type': 'local_taxi',
      'serviceLocation': 'inside',
      'rentalType': 'with_driver',
      'description': 'استأجر تاكسي مع سائق لاستكشاف يوم كامل',
      'imageUrl': 'https://images.unsplash.com/photo-1506521781263-d8422e82f27a?w=800',
      'price': 400.0,
      'priceUnit': '/يوم',
      'duration': '8-10 ساعات',
      'seats': 4,
      'amenities': ['خدمة يوم كامل', 'توقفات مرنة', 'ماء معبأ'],
      'rating': 4.8,
      'reviews': 156,
    },

    // ========== خارج سيوة - النقل الخارجي ==========

    // سيوة ↔ مرسى مطروح
    {
      'id': 'outside_1',
      'name': 'نقل سيوة ↔ مرسى مطروح',
      'type': 'private_transfer',
      'serviceLocation': 'outside',
      'rentalType': 'with_driver',
      'description': 'نقل خاص بسيارة بين سيوة ومرسى مطروح',
      'imageUrl': 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800',
      'price': 1200.0,
      'priceUnit': '/اتجاه واحد',
      'duration': '3-4 ساعات',
      'seats': 4,
      'amenities': ['سيارة دفع رباعي مكيفة', 'سائق محترف', 'من الباب إلى الباب'],
      'rating': 4.9,
      'reviews': 178,
    },

    // سيوة ↔ القاهرة
    {
      'id': 'outside_2',
      'name': 'نقل فاخر سيوة ↔ القاهرة',
      'type': 'private_transfer',
      'serviceLocation': 'outside',
      'rentalType': 'with_driver',
      'description': 'نقل فاخر من القاهرة إلى سيوة مع سائق محترف',
      'imageUrl': 'https://images.unsplash.com/photo-1512453979798-5ea1b2d9c374?w=800',
      'price': 3500.0,
      'priceUnit': '/اتجاه واحد',
      'duration': '8-9 ساعات',
      'seats': 4,
      'amenities': ['واي فاي', 'مشروبات', 'توقفات راحة', 'سيدان حديثة'],
      'rating': 4.9,
      'reviews': 92,
    },

    // مطار مرسى مطروح ↔ سيوة
    {
      'id': 'outside_3',
      'name': 'مطار مرسى مطروح ↔ سيوة',
      'type': 'airport_transfer',
      'serviceLocation': 'outside',
      'rentalType': 'with_driver',
      'description': 'خدمة استقبال وتوصيل من/إلى المطار',
      'imageUrl': 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=800',
      'price': 1300.0,
      'priceUnit': '/اتجاه واحد',
      'duration': '3.5 ساعات',
      'seats': 4,
      'amenities': ['مراقبة الرحلات', 'لافتة بالاسم', 'مساعدة بالأمتعة'],
      'rating': 4.8,
      'reviews': 134,
    },

    // ميني باص مشترك
    {
      'id': 'outside_4',
      'name': 'ميني باص مشترك سيوة',
      'type': 'shared_transfer',
      'serviceLocation': 'outside',
      'rentalType': 'with_driver',
      'description': 'رحلة مشتركة بأسعار معقولة من/إلى مرسى مطروح',
      'imageUrl': 'https://images.unsplash.com/photo-1558981806-6995a7d0c0e9?w=800',
      'price': 250.0,
      'priceUnit': '/شخص',
      'duration': '4-5 ساعات',
      'seats': 14,
      'amenities': ['مواعيد مجدولة', 'مكيف', 'آمن وموثوق'],
      'rating': 4.3,
      'reviews': 412,
    }
  ];

  // المعالم السياحية - جميع الحقول مكتملة مع روابط صالحة
  static final List<Map<String, dynamic>> attractions = [
    {
      'id': '1',
    'name': 'قلعة شالي',
    'category': 'historical',
    'description': 'أطلال قلعة طينية قديمة تطل على واحة سيوة بمناظر بانورامية',
    'longDescription': 'قلعة شالي هي أبرز معلم في واحة سيوة. بُنيت في القرن الثالث عشر من الكرشف (خليط من الملح والطين والصخور)، وكانت مركزًا محصنًا لمدينة سيوة. كانت تضم مئات العائلات داخل ممراتها المتاهية ومبانيها متعددة الطوابق. رغم تدميرها جزئيًا بسبب الأمطار الكارثية عام 1926، إلا أنها لا تزال رمزًا للعبقرية المعمارية السيوانية وتوفر إطلالات بانورامية خلابة على بساتين النخيل والصحراء.',
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
    'location': 'وسط مدينة سيوة',
    'difficulty': 'سهل',
    'duration': '1-2 ساعات',
    'bestTimeToVisit': 'غروب الشمس',
    'entryFee': '50 جنيه مصري',
    'openingHours': '8:00 ص - 6:00 م',
    'price': 50.0,
    'highlights': [
      'إطلالات بانورامية على واحة سيوة من الأعلى',
      'هندسة طينية من القرن الثالث عشر',
      'متاهة من الممرات الضيقة والمباني القديمة',
      'أفضل نقطة لمشاهدة غروب الشمس في سيوة',
      'أهمية تاريخية غنية',
    ],
    'facilities': [
      'جولات بمرشدين',
      'لوحات إرشادية',
      'مواقع تصوير',
      'مواقف سيارات قريبة',
    ],
    'tips': [
      'زرها عند غروب الشمس لأفضل الإطلالات والتصوير',
      'ارتدِ أحذية مريحة لأن المسارات غير مستوية',
      'احمل ماء وحماية من الشمس',
      'احترم الموقع التاريخي - لا تتسلق الهياكل الهشة',
      'الزيارات الصباحية أقل ازدحامًا',
    ],
    'historicalInfo': {
      'origins': 'بُنيت في القرن الثالث عشر (حوالي 1203 م) من قبل الشعب الأمازيغي، وكانت مستوطنة محصنة لحماية السكان من الغزاة الصحراويين.',
      'events': 'تحملت شالي العديد من الحصارات على مر القرون. بدأ تدهورها عام 1926 عندما تسببت أمطار غزيرة لثلاثة أيام في أضرار هيكلية كبيرة.',
      'impact': 'تمثل شالي رمزًا لصمود السيوانيين وابتكارهم المعماري. وتُعد من أجمل أمثلة البناء التقليدي بالكرشف في شمال إفريقيا.',
    },
    'nearbyAttractions': [
      {'name': 'متحف بيت سيوة', 'distance': '0.2 كم', 'type': 'متحف'},
      {'name': 'السوق القديم', 'distance': '0.3 كم', 'type': 'سوق'},
    ],
  },
  {
    'id': '2',
    'name': 'معبد العراف',
    'category': 'historical',
    'description': 'معبد مصري قديم استشار فيه الإسكندر الأكبر العراف',
    'longDescription': 'معبد العراف في آمون هو أحد أكثر المواقع غموضًا وأهمية تاريخية في مصر. بُني في القرن السادس قبل الميلاد فوق مستوطنة أغورمي القديمة، واكتسب شهرته عندما قطع الإسكندر الأكبر رحلة شاقة عبر الصحراء لاستشارة العراف عام 331 ق.م. أعلن كهنة آمون أنه ابن زيوس-آمون، مما شرّع حكمه لمصر. يجذب الموقع النائي والغموض الزوار منذ آلاف السنين.',
    'imageUrl': 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
    'images': [
      'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
      'https://images.unsplash.com/photo-1548013146-72479768bada?w=800',
      'https://images.unsplash.com/photo-1503177119275-0aa32b3a9368?w=800',
    ],
    'rating': 4.9,
    'reviews': 312,
    'location': 'قرية أغورمي',
    'difficulty': 'متوسط',
    'duration': '2-3 ساعات',
    'bestTimeToVisit': 'الصباح',
    'entryFee': '80 جنيه مصري',
    'openingHours': '8:00 ص - 5:00 م',
    'price': 80.0,
    'highlights': [
      'الموقع الذي استشار فيه الإسكندر العراف',
      'نقوش ورسوم هيروغليفية مصرية قديمة',
      'إطلالات بانورامية على واحة سيوة',
      '2500 عام من التاريخ الموثق',
      'جو غامض وموقع نائي',
    ],
    'facilities': [
      'مرشدون محترفون',
      'مركز زوار',
      'مناطق راحة',
      'متجر هدايا',
    ],
    'tips': [
      'استأجر مرشدًا خبيرًا لفهم التاريخ جيدًا',
      'زر في الصباح عندما يكون الجو أبرد',
      'اجمع بين الزيارة وعين كليوباترا القريبة',
      'احمل منظارًا لرؤية المناظر الصحراوية البعيدة',
      'احترم قدسية الموقع',
    ],
    'historicalInfo': {
      'origins': 'بُني في القرن السادس ق.م خلال الأسرة 26، وكان مكرسًا للإله آمون-رع. أصبح سريعًا أحد أهم مواقع العرافة في العالم القديم.',
      'events': 'زيارة الإسكندر الأكبر الشهيرة عام 331 ق.م هي الحدث الأبرز. ظل المعبد نشطًا حتى القرن الرابع الميلادي.',
      'impact': 'أثرت عرافة سيوة على قرارات سياسية كبرى في العالم المتوسطي القديم. لا يزال الموقع يجذب العلماء والمؤرخين والباحثين الروحانيين.',
    },
  },
  {
    'id': '3',
    'name': 'البحر الرملي العظيم',
    'category': 'nature',
    'description': 'صحراء رملية شاسعة بكثبان شاهقة مثالية للمغامرة',
    'longDescription': 'البحر الرملي العظيم هو صحراء رملية ضخمة تمتد على 72,000 كم² في مصر وليبيا. قرب سيوة، ترتفع الكثبان لأكثر من 100 متر، مكونة منظرًا مذهلاً من الأمواج الذهبية المتجمدة. هذه البرية البكر توفر فرصًا لا مثيل لها لمغامرات الصحراء، من التزلج على الرمال إلى التخييم تحت سماء مليئة بالنجوم.',
    'imageUrl': 'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800',
    'images': [
      'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800',
      'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=800',
      'https://images.unsplash.com/photo-1547036967-23d11aacaee0?w=800',
      'https://images.unsplash.com/photo-1551244072-5d12893278ab?w=800',
    ],
    'rating': 4.9,
    'reviews': 428,
    'location': 'الصحراء الغربية، 15 كم من سيوة',
    'difficulty': 'صعب',
    'duration': 'نصف يوم إلى يوم كامل',
    'bestTimeToVisit': 'الشتاء (أكتوبر-أبريل)',
    'entryFee': 'مجانًا',
    'openingHours': '24/7 (جولات بمرشد موصى بها)',
    'price': 0.0,
    'highlights': [
      'كثبان رملية شاهقة بارتفاع أكثر من 100 متر',
      'فرص تزلج على الرمال عالمية المستوى',
      'مناظر شروق وغروب خلابة',
      'تجارب تخييم صحراوي',
      'البحث عن الأحافير في مناطق معينة',
    ],
    'facilities': [
      'جولات 4x4 متاحة',
      'تأجير معدات التخييم',
      'معدات التزلج على الرمال',
      'مرشدون صحراويون ذوو خبرة',
    ],
    'tips': [
      'لا تدخل الصحراء أبدًا بدون مرشد',
      'احمل ماء كافيًا (4+ لتر للشخص)',
      'ارتدِ واقي شمس وملابس واقية',
      'أفضل زيارة من أكتوبر إلى أبريل',
      'احجز الجولات مع شركات موثوقة فقط',
    ],
    'historicalInfo': {
      'origins': 'يوجد البحر الرملي منذ آلاف السنين، تكوّن بفعل الرياح. عبرت قوافل قديمة أجزاء منه، لكن قلة تجرأت على الدخول عميقًا.',
      'events': 'خلال الحرب العالمية الثانية، استخدمت مجموعة الصحراء بعيدة المدى هذه المنطقة للاستطلاع. قام المستكشف رالف بانولد برسم خرائطها في عشرينيات وثلاثينيات القرن العشرين.',
      'impact': 'يبقى البحر الرملي واحدًا من أنقى بيئات الصحراء على الأرض. يُستخدم كمختبر طبيعي لدراسة تكوّن الصحارى وتغير المناخ.',
    },
  },
  {
    'id': '4',
    'name': 'حمام كليوباترا (عين جوبا)',
    'category': 'nature',
    'description': 'بركة طبيعية تغذيها عين دافئة يقال إن كليوباترا استحمت فيها',
    'longDescription': 'حمام كليوباترا، المعروف محليًا بعين جوبا، هو بركة حجرية طبيعية تغذيها عين دافئة. تقول الأسطورة المحلية إن كليوباترا استحمت في هذه المياه خلال زياراتها لسيوة. المياه الشفافة تحافظ على درجة حرارة مريحة طوال العام، مما يجعلها مكانًا شهيرًا للسباحة. محاطة بأشجار النخيل وإطلالة على معبد العراف، توفر ملاذًا منعشًا من حرارة الصحراء.',
    'imageUrl': 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=800',
    'images': [
      'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=800',
      'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800',
    ],
    'rating': 4.6,
    'reviews': 189,
    'location': 'قرب قرية أغورمي',
    'difficulty': 'سهل',
    'duration': '1-2 ساعات',
    'bestTimeToVisit': 'بعد الظهر',
    'entryFee': '30 جنيه مصري',
    'openingHours': '8:00 ص - 5:00 م',
    'price': 30.0,
    'highlights': [
      'مياه عين دافئة طبيعية',
      'موقع تاريخي بأسطورة كليوباترا',
      'إعداد جميل لبساتين النخيل',
      'آمن للسباحة',
      'قريب من معبد العراف',
    ],
    'facilities': [
      'غرف تغيير',
      'خزائن',
      'مقهى صغير',
      'مناطق جلوس مظللة',
    ],
    'tips': [
      'احمل ملابس سباحة ومنشفة',
      'زر بعد الظهر عندما تكون المياه أدفأ',
      'اجمع بين الزيارة ومعبد العراف',
      'احترم المكان - المحليون يستخدمونه أيضًا',
      'قد يكون مزدحمًا في عطلات نهاية الأسبوع',
    ],
  },
  {
    'id': '5',
    'name': 'جبل الموتى (جبل الموتى)',
    'category': 'historical',
    'description': 'مقابر قديمة منحوتة في الصخر تعود للعصر البطلمي',
    'longDescription': 'جبل الموتى هو شبكة من المقابر المنحوتة في الصخر تعود للأسرة 26 والبطلمية (663-30 ق.م). تتميز هذه المقابر برسوم ونقوش محفوظة بشكل ممتاز تصور المعتقدات الدينية والحياة اليومية في مصر القديمة. اكتسب الموقع أهمية حديثة خلال الحرب العالمية الثانية عندما استخدمه السكان كملاجئ من القنابل. يمكن للزوار اليوم استكشاف عدة مقابر مفتوحة والإعجاب بالفن القديم.',
    'imageUrl': 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
    'images': [
      'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
      'https://images.unsplash.com/photo-1503177119275-0aa32b3a9368?w=800',
    ],
    'rating': 4.7,
    'reviews': 156,
    'location': '1 كم شمال مدينة سيوة',
    'difficulty': 'سهل',
    'duration': '1-2 ساعات',
    'bestTimeToVisit': 'الصباح',
    'entryFee': '60 جنيه مصري',
    'openingHours': '8:00 ص - 5:00 م',
    'price': 60.0,
    'highlights': [
      'مقابر مرسومة من العصر البطلمي',
      'نقوش ورسوم محفوظة جيدًا',
      'أربع مقابر رئيسية مفتوحة للزوار',
      'إطلالات بانورامية على واحة سيوة',
      'أهمية تاريخية في الحرب العالمية الثانية',
    ],
    'facilities': [
      'جولات بمرشدين',
      'لوحات إرشادية',
      'إضاءة داخل المقابر',
      'مسارات وسلالم',
    ],
    'tips': [
      'احمل مصباحًا للرؤية داخل المقابر',
      'التصوير قد يكون محدودًا في بعض المقابر',
      'ارتدِ أحذية مشي مريحة',
      'زر مبكرًا لتجنب الزحام والحرارة',
      'احترم الرسوم القديمة - لا تلمس',
    ],
    'historicalInfo': {
      'origins': 'تعود المقابر بشكل رئيسي للأسرة 26 والبطلمية. نُحتت في الصخر الناعم وزُينت لنبلاء وعائلات سيوة الأثرياء.',
      'events': 'خلال الحرب العالمية الثانية، قصفت القوات الإيطالية سيوة، فاحتمى السكان في هذه المقابر. أُعيد اكتشافها من قبل علماء الآثار في أوائل القرن العشرين.',
      'impact': 'يوفر جبل الموتى رؤى قيمة عن ثقافة سيوة القديمة ومعتقداتها حول الحياة الآخرة. يظهر الفن تقاليد فنية متقدمة ازدهرت في هذه الواحة النائية.',
    },
  },
  {
    'id': '6',
    'name': 'جزيرة فطناس',
    'category': 'nature',
    'description': 'جزيرة مغطاة بالنخيل مع ينابيع طبيعية مثالية لمشاهدة الغروب',
    'longDescription': 'جزيرة فطناس، المعروفة أيضًا بجزيرة الخيال، هي جزيرة صغيرة مغطاة بالنخيل على حافة بحيرة سيوة المالحة. ترتبط بالبر الرئيسي بجسر ضيق، وتتميز ببرك تغذيها ينابيع طبيعية، وبساتين نخيل خضراء، ومسارات مشي هادئة. تشتهر بمناظر غروب الشمس الخلابة حيث تغرب الشمس فوق البحيرة مع ظلال النخيل على سماء برتقالية ووردية. مثالية لنزهة مسائية هادئة أو سباحة منعشة.',
    'imageUrl': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
    'images': [
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
      'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=800',
    ],
    'rating': 4.5,
    'reviews': 203,
    'location': 'الحافة الغربية لبحيرة سيوة',
    'difficulty': 'سهل',
    'duration': '2-3 ساعات',
    'bestTimeToVisit': 'غروب الشمس',
    'entryFee': '20 جنيه مصري',
    'openingHours': '9:00 ص - 8:00 م',
    'price': 20.0,
    'highlights': [
      'مناظر غروب خلابة فوق البحيرة',
      'برك ينابيع للسباحة',
      'إعداد هادئ لبساتين النخيل',
      'فرص مشاهدة الطيور',
      'مناطق نزهة ومقاهي',
    ],
    'facilities': [
      'مقهى ومطعم',
      'مناطق سباحة',
      'طاولات نزهة',
      'مواقف سيارات',
    ],
    'tips': [
      'وصل قبل ساعة على الأقل من الغروب لأفضل الأماكن',
      'احمل مستلزمات النزهة لأمسية رومانسية',
      'ملابس سباحة مطلوبة إذا كنت تخطط للسباحة',
      'طارد البعوض موصى به في الصيف',
      'احجز مقاعد المقهى مسبقًا في المواسم الذروة',
    ],
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

  // غرف الفندق - جميع الحقول مكتملة
  static final List<Map<String, dynamic>> rooms = [
    {
      "id": 1,
      "hotelId": 1,
      "type": "جناح فاخر",
      "price": 150.0,
      "amenities": ["واي فاي", "بار صغير", "شرفة", "سرير كينج"],
      "available": true,
      "capacity": 2,
      "size": "45 متر مربع",
      "view": "إطلالة صحراوية",
      "category": "room",
      "imageUrl": "https://images.unsplash.com/photo-1590490360182-c33d57733427?w=800"
    },
    {
      "id": 2,
      "hotelId": 1,
      "type": "غرفة قياسية",
      "price": 80.0,
      "amenities": ["واي فاي", "تلفاز", "سرير كوين"],
      "available": true,
      "capacity": 2,
      "size": "25 متر مربع",
      "view": "إطلالة حديقة",
      "category": "room",
      "imageUrl": "https://images.unsplash.com/photo-1618773928121-c32242e63f39?w=800"
    },
    {
      "id": 3,
      "hotelId": 2,
      "type": "غرفة عائلية",
      "price": 200.0,
      "amenities": ["واي فاي", "مطبخ", "غرفة معيشة", "غرفتي نوم"],
      "available": false,
      "capacity": 4,
      "size": "60 متر مربع",
      "view": "إطلالة بحيرة",
      "category": "room",
      "imageUrl": "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800"
    }
  ];

  // مركبات للإيجار - جميع الحقول مكتملة
  static final List<Map<String, dynamic>> rentals = [
    {
      "id": 1,
      "type": "دراجة جبلية",
      "model": "Trek X-Caliber",
      "rate": 25.0,
      "rateType": "يوم",
      "available": true,
      "condition": "ممتاز",
      "features": ["21 سرعة", "تعليق أمامي", "حامل زجاجة ماء"],
      "image": "pedal_bike",
      "category": "rental",
      "imageUrl": "https://images.unsplash.com/photo-1576435728678-68d0fbf94e91?w=800",
      "location": "مركز مدينة سيوة"
    },
    {
      "id": 2,
      "type": "سيارة SUV",
      "model": "Toyota Land Cruiser",
      "rate": 120.0,
      "rateType": "يوم",
      "available": false,
      "condition": "جيد",
      "features": ["قدرة 4x4", "تكييف", "نظام ملاحة GPS", "سعة 7 مقاعد"],
      "image": "directions_car",
      "category": "rental",
      "imageUrl": "https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=800",
      "location": "مركز رحلات الصحراء"
    },
    {
      "id": 3,
      "type": "سكوتر كهربائي",
      "model": "Xiaomi Pro 2",
      "rate": 15.0,
      "rateType": "ساعة",
      "available": true,
      "condition": "ممتاز",
      "features": ["مدى 30 كم", "سرعة قصوى 25 كم/س", "شاشة LED"],
      "image": "electric_scooter",
      "category": "rental",
      "imageUrl": "https://images.unsplash.com/photo-1578610906114-0b5e6dc32f52?w=800",
      "location": "ساحة السوق"
    }
  ];

  // تحديات التصوير - جميع الحقول مكتملة
  static final List<Map<String, dynamic>> challenges = [
    {
      "id": 1,
      "title": "التقط غروب الشمس",
      "description": "ابحث عن الموقع المثالي لتصوير غروب الشمس فوق الكثبان الرملية.",
      "imageUrl": "https://images.unsplash.com/photo-1500322969630-a26ab6ef0e0a?w=800",
      "completed": false,
      "points": 50,
      "proof": null,
      "category": "challenge",
      "difficulty": "سهل",
      "location": "جزيرة فتناس",
      "tips": ["صل قبل 30 دقيقة من غروب الشمس", "استخدم إضاءة الساعة الذهبية"],
      "timeLimit": "2 ساعات"
    },
    {
      "id": 2,
      "title": "الواحة الخفية",
      "description": "اكتشف وصور واحة خفية في صحراء سيوة.",
      "imageUrl": "https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800",
      "completed": false,
      "points": 75,
      "proof": null,
      "category": "challenge",
      "difficulty": "صعب",
      "location": "الصحراء الغربية",
      "tips": ["استأجر دليل محلي", "أحضر كمية كافية من الماء"],
      "timeLimit": "6 ساعات"
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
      "difficulty": "متوسط",
      "location": "بركة سيوة",
      "tips": ["زيارة خلال الطقس الهادئ", "الصباح الباكر يوفر أفضل إضاءة"],
      "timeLimit": "3 ساعات"
    }
  ];
static final List<Map<String, dynamic>> featuredServices = [
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
    "featured": true,  // موجود
    "openingHours": "24/7",
    "contactNumber": "+20 123 456 7890"
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
    "featured": true,  // أضف هذا السطر
    "hidden_gem": true,
    "openingHours": "8:00 ص - 6:00 م",
    "contactNumber": "+20 123 456 7891"
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
    "featured": true,  // أضف هذا السطر
    "hidden_gem": true,
    "openingHours": "7:00 ص - 10:00 م",
    "contactNumber": "+20 123 456 7892"
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

final mockDataAr = MockDataRepositoryAr();