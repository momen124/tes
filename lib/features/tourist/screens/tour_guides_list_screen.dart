import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

class TourGuidesListScreen extends StatefulWidget {
  const TourGuidesListScreen({super.key});

  @override
  State<TourGuidesListScreen> createState() => _TourGuidesListScreenState();
}

class _TourGuidesListScreenState extends State<TourGuidesListScreen> {
  String _selectedSpecialty = 'all';
  String _selectedLanguage = 'all';
  
  final List<Map<String, dynamic>> _tourGuides = [
    {
      'id': 1,
      'name': 'Ahmed Hassan',
      'specialty': 'history',
      'experience': 15,
      'rating': 4.9,
      'reviews': 234,
      'hourlyRate': 150.0,
      'imageUrl': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      'bio': 'Expert in Siwan history and ancient Egyptian archaeology with over 15 years of experience',
      'languages': ['Arabic', 'English', 'German'],
      'certifications': ['Licensed Tour Guide', 'First Aid Certified', 'History Degree'],
      'specialties': ['Ancient Egypt', 'Archaeology', 'Temple Tours'],
      'availability': {
        'Mon': true,
        'Tue': true,
        'Wed': false,
        'Thu': true,
        'Fri': true,
        'Sat': true,
        'Sun': true,
      },
      'verified': true,
      'responseTime': '< 1 hour',
    },
    {
      'id': 2,
      'name': 'Fatima Al-Siwy',
      'specialty': 'culture',
      'experience': 10,
      'rating': 4.8,
      'reviews': 189,
      'hourlyRate': 120.0,
      'imageUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
      'bio': 'Native Siwan guide specializing in local culture, traditions, and handicrafts',
      'languages': ['Arabic', 'English', 'French'],
      'certifications': ['Licensed Tour Guide', 'Cultural Heritage Specialist'],
      'specialties': ['Siwan Culture', 'Handicrafts', 'Traditional Cooking'],
      'availability': {
        'Mon': true,
        'Tue': true,
        'Wed': true,
        'Thu': true,
        'Fri': false,
        'Sat': true,
        'Sun': true,
      },
      'verified': true,
      'responseTime': '< 2 hours',
    },
    {
      'id': 3,
      'name': 'Mohamed Saeed',
      'specialty': 'adventure',
      'experience': 8,
      'rating': 4.9,
      'reviews': 312,
      'hourlyRate': 180.0,
      'imageUrl': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
      'bio': 'Adventure specialist for desert safaris, sandboarding, and extreme sports',
      'languages': ['Arabic', 'English', 'Italian'],
      'certifications': ['Licensed Tour Guide', 'Wilderness First Responder', '4x4 Driver'],
      'specialties': ['Desert Safari', 'Sandboarding', 'Camping'],
      'availability': {
        'Mon': true,
        'Tue': true,
        'Wed': true,
        'Thu': true,
        'Fri': true,
        'Sat': true,
        'Sun': false,
      },
      'verified': true,
      'responseTime': '< 30 min',
    },
    {
      'id': 4,
      'name': 'Sara Ibrahim',
      'specialty': 'nature',
      'experience': 6,
      'rating': 4.7,
      'reviews': 156,
      'hourlyRate': 100.0,
      'imageUrl': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
      'bio': 'Eco-tourism specialist focusing on Siwa\'s natural springs, lakes, and wildlife',
      'languages': ['Arabic', 'English', 'Spanish'],
      'certifications': ['Licensed Tour Guide', 'Environmental Science Degree'],
      'specialties': ['Bird Watching', 'Nature Walks', 'Photography Tours'],
      'availability': {
        'Mon': true,
        'Tue': false,
        'Wed': true,
        'Thu': true,
        'Fri': true,
        'Sat': true,
        'Sun': true,
      },
      'verified': true,
      'responseTime': '< 3 hours',
    },
    {
      'id': 5,
      'name': 'Khaled Mustafa',
      'specialty': 'photography',
      'experience': 12,
      'rating': 4.8,
      'reviews': 267,
      'hourlyRate': 200.0,
      'imageUrl': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400',
      'bio': 'Professional photographer and guide specializing in landscape and cultural photography',
      'languages': ['Arabic', 'English', 'Japanese'],
      'certifications': ['Licensed Tour Guide', 'Professional Photographer'],
      'specialties': ['Landscape Photography', 'Sunset Tours', 'Astro-photography'],
      'availability': {
        'Mon': true,
        'Tue': true,
        'Wed': true,
        'Thu': false,
        'Fri': true,
        'Sat': true,
        'Sun': true,
      },
      'verified': true,
      'responseTime': '< 1 hour',
    },
  ];

  List<Map<String, dynamic>> get _filteredGuides {
    return _tourGuides.where((guide) {
      final specialtyMatch = _selectedSpecialty == 'all' || guide['specialty'] == _selectedSpecialty;
      final languageMatch = _selectedLanguage == 'all' || 
          (guide['languages'] as List<String>).any((lang) => lang.toLowerCase() == _selectedLanguage.toLowerCase());
      return specialtyMatch && languageMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tourist_home'),
        ),
        title: Text('Tour Guides'.tr()),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Specialty',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gray,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildSpecialtyChip('All', 'all', Icons.star),
                      _buildSpecialtyChip('History', 'history', Icons.account_balance),
                      _buildSpecialtyChip('Culture', 'culture', Icons.museum),
                      _buildSpecialtyChip('Adventure', 'adventure', Icons.terrain),
                      _buildSpecialtyChip('Nature', 'nature', Icons.nature),
                      _buildSpecialtyChip('Photography', 'photography', Icons.camera_alt),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Language',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gray,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildLanguageChip('All', 'all'),
                      _buildLanguageChip('English', 'english'),
                      _buildLanguageChip('Arabic', 'arabic'),
                      _buildLanguageChip('French', 'french'),
                      _buildLanguageChip('German', 'german'),
                      _buildLanguageChip('Spanish', 'spanish'),
                      _buildLanguageChip('Italian', 'italian'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Tour Guides List
          Expanded(
            child: _filteredGuides.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 64,
                          color: AppTheme.gray.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No guides found',
                          style: AppTheme.titleMedium.copyWith(color: AppTheme.gray),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedSpecialty = 'all';
                              _selectedLanguage = 'all';
                            });
                          },
                          child: Text('Clear Filters'.tr()),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredGuides.length,
                    itemBuilder: (context, index) {
                      final guide = _filteredGuides[index];
                      return _buildGuideCard(guide);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const TouristBottomNav(currentIndex: 1),
    );
  }

  Widget _buildSpecialtyChip(String label, String value, IconData icon) {
    final isSelected = _selectedSpecialty == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected ? AppTheme.white : AppTheme.primaryOrange,
            ),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        onSelected: (selected) {
          setState(() => _selectedSpecialty = value);
        },
        selectedColor: AppTheme.primaryOrange,
        backgroundColor: AppTheme.white,
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.white : AppTheme.darkGray,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLanguageChip(String label, String value) {
    final isSelected = _selectedLanguage == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _selectedLanguage = value);
        },
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

  Widget _buildGuideCard(Map<String, dynamic> guide) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          _showGuideProfile(guide);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(guide['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (guide['verified'])
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppTheme.successGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              
              // Guide Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            guide['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.lightBlueGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: AppTheme.primaryOrange, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                guide['rating'].toString(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    Text(
                      '${guide['experience']} years experience • ${guide['reviews']} reviews',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.gray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    Text(
                      guide['bio'],
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Languages
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: (guide['languages'] as List<String>)
                          .take(3)
                          .map((lang) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  lang,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    
                    // Rate and Book Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'From',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppTheme.gray,
                              ),
                            ),
                            Text(
                              'EGP ${guide['hourlyRate'].toStringAsFixed(0)}/hr',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryOrange,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showGuideProfile(guide);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryOrange,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text('View Profile'.tr()),
                        ),
                      ],
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

  void _showGuideProfile(Map<String, dynamic> guide) {
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
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 40),
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                image: DecorationImage(
                                  image: NetworkImage(guide['imageUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (guide['verified'])
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: AppTheme.successGreen,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.verified,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      guide['name'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${guide['rating']} (${guide['reviews']} reviews)',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Stats
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            Icons.work_outline,
                            '${guide['experience']} years',
                            'Experience',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            Icons.timer_outlined,
                            guide['responseTime'],
                            'Response',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Bio
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      guide['bio'],
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    
                    // Languages
                    const Text(
                      'Languages',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: (guide['languages'] as List<String>)
                          .map((lang) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.lightBlueGray,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.language, size: 16, color: AppTheme.primaryOrange),
                                    const SizedBox(width: 6),
                                    Text(
                                      lang,
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    
                    // Certifications
                    const Text(
                      'Certifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...(guide['certifications'] as List<String>).map(
                      (cert) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.verified, color: AppTheme.successGreen, size: 20),
                            const SizedBox(width: 8),
                            Text(cert, style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Specialties
                    const Text(
                      'Specialties',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: (guide['specialties'] as List<String>)
                          .map((specialty) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  specialty,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    
                    // Availability
                    const Text(
                      'Weekly Availability',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildAvailabilityCalendar(guide['availability']),
                    const SizedBox(height: 24),
                    
                    // Book Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.push(
                            '/booking_form?type=tourguide',
                            extra: {'serviceData': guide},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryOrange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Book for EGP ${guide['hourlyRate'].toStringAsFixed(0)}/hour',
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

  Widget _buildStatCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightBlueGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryOrange, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.gray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityCalendar(Map<String, bool> availability) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days.map((day) {
        final isAvailable = availability[day] ?? false;
        return Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isAvailable ? AppTheme.successGreen : AppTheme.lightBlueGray,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  day[0],
                  style: TextStyle(
                    color: isAvailable ? Colors.white : AppTheme.gray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              day,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        );
      }).toList(),
    );
  }
}
