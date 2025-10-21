// lib/features/tourist/screens/tours_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToursListScreen extends ConsumerStatefulWidget {
  const ToursListScreen({super.key});

  @override
  ConsumerState<ToursListScreen> createState() => _ToursListScreenState();
}

class _ToursListScreenState extends ConsumerState<ToursListScreen> {
  String _selectedDuration = 'all';
  String _selectedType = 'all';

  // Mock complete tour packages
  final List<Map<String, dynamic>> _tours = [
    {
      'id': '1',
      'name': 'Classic Siwa Discovery',
      'nameAr': 'استكشاف سيوة الكلاسيكي',
      'duration': '3 days',
      'durationAr': '3 أيام',
      'type': 'cultural',
      'price': 2500.0,
      'description': 'Complete 3-day tour covering all major attractions',
      'descriptionAr': 'جولة كاملة لمدة 3 أيام تغطي جميع المعالم الرئيسية',
      'imageUrl': 'https://images.unsplash.com/photo-1589993464410-6c55678afc12?w=800',
      'rating': 4.8,
      'reviews': 156,
      'groupSize': '4-12 people',
      'includes': [
        'Accommodation (2 nights)',
        'All meals',
        'Transportation',
        'Professional guide',
        'Entry fees',
        'Desert safari',
      ],
      'includesAr': [
        'الإقامة (ليلتان)',
        'جميع الوجبات',
        'المواصلات',
        'مرشد محترف',
        'رسوم الدخول',
        'سفاري صحراوي',
      ],
      'itinerary': [
        {
          'day': 1,
          'title': 'Arrival & Ancient Sites',
          'titleAr': 'الوصول والمواقع الأثرية',
          'activities': [
            'Pick up from Marsa Matrouh',
            'Visit Shali Fortress',
            'Explore Temple of the Oracle',
            'Sunset at Fatnas Island',
          ],
        },
        {
          'day': 2,
          'title': 'Desert Adventure',
          'titleAr': 'مغامرة صحراوية',
          'activities': [
            'Visit Great Sand Sea',
            'Hot spring swim',
            'Bedouin lunch',
            'Sandboarding',
          ],
        },
        {
          'day': 3,
          'title': 'Culture & Departure',
          'titleAr': 'الثقافة والمغادرة',
          'activities': [
            'Siwa market visit',
            'Salt lakes',
            'Traditional crafts workshop',
            'Return journey',
          ],
        },
      ],
      'highlights': [
        'Visit ancient Shali Fortress',
        'Swim in Cleopatra\'s Bath',
        'Desert camping experience',
        'Traditional Siwan dinner',
      ],
      'whatToBring': [
        'Comfortable walking shoes',
        'Sunscreen and hat',
        'Light jacket for evenings',
        'Camera',
        'Personal medications',
      ],
    },
    {
      'id': '2',
      'name': 'Desert Adventure Package',
      'nameAr': 'باقة المغامرة الصحراوية',
      'duration': '2 days',
      'durationAr': 'يومان',
      'type': 'adventure',
      'price': 1800.0,
      'description': 'Action-packed desert safari and camping experience',
      'descriptionAr': 'سفاري صحراوي مليء بالمغامرات وتجربة التخييم',
      'imageUrl': 'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800',
      'rating': 4.7,
      'reviews': 98,
      'groupSize': '6-15 people',
      'includes': [
        'Desert camping (1 night)',
        'All meals',
        '4x4 desert safari',
        'Sandboarding equipment',
        'Bedouin guide',
      ],
      'includesAr': [
        'التخييم الصحراوي (ليلة واحدة)',
        'جميع الوجبات',
        'سفاري صحراوي بسيارة 4x4',
        'معدات التزلج على الرمال',
        'مرشد بدوي',
      ],
      'highlights': [
        'Great Sand Sea exploration',
        'Desert camping under stars',
        'Sandboarding on dunes',
        'Traditional Bedouin tea',
      ],
    },
    {
      'id': '3',
      'name': 'Wellness & Relaxation Retreat',
      'nameAr': 'خلوة العافية والاسترخاء',
      'duration': '4 days',
      'durationAr': '4 أيام',
      'type': 'wellness',
      'price': 3200.0,
      'description': 'Rejuvenating experience with hot springs and spa treatments',
      'descriptionAr': 'تجربة تجديد النشاط مع الينابيع الساخنة والعلاجات الصحية',
      'imageUrl': 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=800',
      'rating': 4.9,
      'reviews': 87,
      'groupSize': '2-8 people',
      'includes': [
        'Luxury eco-lodge (3 nights)',
        'Organic meals',
        'Daily spa treatments',
        'Hot spring visits',
        'Yoga sessions',
        'Meditation sessions',
      ],
      'includesAr': [
        'نزل بيئي فاخر (3 ليالٍ)',
        'وجبات عضوية',
        'علاجات سبا يومية',
        'زيارات الينابيع الساخنة',
        'جلسات يوغا',
        'جلسات تأمل',
      ],
      'highlights': [
        'Natural hot springs therapy',
        'Siwan organic meals',
        'Desert meditation',
        'Spa with local products',
      ],
    },
    {
      'id': '4',
      'name': 'Photography Expedition',
      'nameAr': 'رحلة التصوير الفوتوغرافي',
      'duration': '5 days',
      'durationAr': '5 أيام',
      'type': 'photography',
      'price': 4500.0,
      'description': 'Capture Siwa\'s beauty with professional photography guidance',
      'descriptionAr': 'التقط جمال سيوة مع إرشاد التصوير المحترف',
      'imageUrl': 'https://images.unsplash.com/photo-1452587925148-ce544e77e70d?w=800',
      'rating': 4.9,
      'reviews': 45,
      'groupSize': '3-6 people',
      'includes': [
        'Boutique hotel (4 nights)',
        'All meals',
        'Professional photographer guide',
        'Transportation to photo spots',
        'Photo editing workshop',
        'Sunrise/sunset shoots',
      ],
      'includesAr': [
        'فندق بوتيك (4 ليالٍ)',
        'جميع الوجبات',
        'مرشد مصور محترف',
        'النقل لمواقع التصوير',
        'ورشة تحرير الصور',
        'جلسات تصوير شروق وغروب الشمس',
      ],
      'highlights': [
        'Golden hour desert shoots',
        'Ancient architecture photography',
        'Local portrait sessions',
        'Night sky photography',
      ],
    },
    {
      'id': '5',
      'name': 'Family Fun Package',
      'nameAr': 'باقة المرح العائلي',
      'duration': '3 days',
      'durationAr': '3 أيام',
      'type': 'family',
      'price': 2200.0,
      'description': 'Perfect family vacation with kid-friendly activities',
      'descriptionAr': 'عطلة عائلية مثالية مع أنشطة مناسبة للأطفال',
      'imageUrl': 'https://images.unsplash.com/photo-1511895426328-dc8714191300?w=800',
      'rating': 4.6,
      'reviews': 112,
      'groupSize': '4-20 people',
      'includes': [
        'Family rooms (2 nights)',
        'Kid-friendly meals',
        'Transportation',
        'Family guide',
        'Activities for all ages',
        'Swimming pool access',
      ],
      'includesAr': [
        'غرف عائلية (ليلتان)',
        'وجبات مناسبة للأطفال',
        'المواصلات',
        'مرشد عائلي',
        'أنشطة لجميع الأعمار',
        'الوصول إلى حمام السباحة',
      ],
      'highlights': [
        'Safe desert adventures',
        'Swimming in salt lakes',
        'Donkey cart rides',
        'Traditional crafts for kids',
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredTours {
    return _tours.where((tour) {
      final durationMatch = _selectedDuration == 'all' || 
          tour['duration'].toString().startsWith(_selectedDuration);
      final typeMatch = _selectedType == 'all' || tour['type'] == _selectedType;
      return durationMatch && typeMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tourist_home'),
        ),
        title: Text(isArabic ? 'الجولات الكاملة' : 'Complete Tours'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filters
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    isArabic ? 'المدة' : 'Duration',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.gray),
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildDurationChip(isArabic ? 'الكل' : 'All', 'all', isArabic),
                      _buildDurationChip(isArabic ? 'يومان' : '2 Days', '2', isArabic),
                      _buildDurationChip(isArabic ? '3 أيام' : '3 Days', '3', isArabic),
                      _buildDurationChip(isArabic ? '4 أيام' : '4 Days', '4', isArabic),
                      _buildDurationChip(isArabic ? '5+ أيام' : '5+ Days', '5', isArabic),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    isArabic ? 'النوع' : 'Type',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.gray),
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildTypeChip(isArabic ? 'الكل' : 'All', 'all', Icons.explore, isArabic),
                      _buildTypeChip(isArabic ? 'ثقافي' : 'Cultural', 'cultural', Icons.museum, isArabic),
                      _buildTypeChip(isArabic ? 'مغامرة' : 'Adventure', 'adventure', Icons.terrain, isArabic),
                      _buildTypeChip(isArabic ? 'عافية' : 'Wellness', 'wellness', Icons.spa, isArabic),
                      _buildTypeChip(isArabic ? 'تصوير' : 'Photography', 'photography', Icons.camera_alt, isArabic),
                      _buildTypeChip(isArabic ? 'عائلي' : 'Family', 'family', Icons.family_restroom, isArabic),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Tours List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              itemCount: _filteredTours.length,
              itemBuilder: (context, index) {
                final tour = _filteredTours[index];
                return _buildTourCard(tour, isArabic);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const SafeArea(
        child: TouristBottomNav(currentIndex: 1),
      ),
    );
  }

  Widget _buildDurationChip(String label, String value, bool isArabic) {
    final isSelected = _selectedDuration == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => setState(() => _selectedDuration = value),
        selectedColor: AppTheme.primaryOrange,
        backgroundColor: AppTheme.lightBlueGray,
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.white : AppTheme.darkGray,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTypeChip(String label, String value, IconData icon, bool isArabic) {
    final isSelected = _selectedType == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: isSelected ? AppTheme.white : AppTheme.primaryOrange),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        onSelected: (_) => setState(() => _selectedType = value),
        selectedColor: AppTheme.primaryOrange,
        backgroundColor: AppTheme.white,
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.white : AppTheme.darkGray,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTourCard(Map<String, dynamic> tour, bool isArabic) {
    final name = isArabic ? tour['nameAr'] : tour['name'];
    final duration = isArabic ? tour['durationAr'] : tour['duration'];
    final description = isArabic ? tour['descriptionAr'] : tour['description'];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showTourDetails(tour, isArabic),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with badges
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: NetworkImage(tour['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryOrange.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: AppTheme.primaryOrange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${tour['rating']}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: AppTheme.gray),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.people, size: 16, color: AppTheme.gray),
                      const SizedBox(width: 4),
                      Text(
                        tour['groupSize'],
                        style: const TextStyle(fontSize: 13, color: AppTheme.gray),
                      ),
                      const Spacer(),
                      Text(
                        'EGP ${tour['price'].toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTourDetails(Map<String, dynamic> tour, bool isArabic) {
    final name = isArabic ? tour['nameAr'] : tour['name'];
    final duration = isArabic ? tour['durationAr'] : tour['duration'];
    final description = isArabic ? tour['descriptionAr'] : tour['description'];
    final includes = isArabic ? tour['includesAr'] : tour['includes'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: controller,
            padding: EdgeInsets.zero,
            children: [
              // Image
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage(tour['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(backgroundColor: Colors.black45),
                    ),
                  ),
                ],
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppTheme.primaryOrange, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${tour['rating']} (${tour['reviews']} reviews)',
                          style: const TextStyle(fontSize: 14, color: AppTheme.gray),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(description, style: const TextStyle(fontSize: 16, height: 1.5)),
                    const SizedBox(height: 24),

                    // Tour Info
                    Row(
                      children: [
                        Expanded(child: _buildInfoBox(Icons.access_time, isArabic ? 'المدة' : 'Duration', duration)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildInfoBox(Icons.people, isArabic ? 'الحجم' : 'Group Size', tour['groupSize'])),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // What's Included
                    Text(
                      isArabic ? 'ما يشمله' : 'What\'s Included',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...includes.map<Widget>((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: AppTheme.successGreen, size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text(item, style: const TextStyle(fontSize: 15))),
                        ],
                      ),
                    )),

                    const SizedBox(height: 24),

                    // Itinerary
                    if (tour['itinerary'] != null) ...[
                      Text(
                        isArabic ? 'البرنامج' : 'Itinerary',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ...((tour['itinerary'] as List).map<Widget>((day) {
                        final title = isArabic ? day['titleAr'] : day['title'];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: AppTheme.primaryOrange,
                              child: Text('${day['day']}', style: const TextStyle(color: Colors.white)),
                            ),
                            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                            children: (day['activities'] as List).map<Widget>((activity) => 
                              ListTile(
                                dense: true,
                                leading: const Icon(Icons.arrow_right, color: AppTheme.primaryOrange, size: 20),
                                title: Text(activity, style: const TextStyle(fontSize: 14)),
                              )
                            ).toList(),
                          ),
                        );
                      })),
                      const SizedBox(height: 24),
                    ],

                    // Book Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.push('/booking_form?type=tour', extra: {'serviceData': tour});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryOrange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          '${isArabic ? "احجز مقابل" : "Book for"} EGP ${tour['price'].toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.lightBlueGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryOrange, size: 24),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.gray)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}