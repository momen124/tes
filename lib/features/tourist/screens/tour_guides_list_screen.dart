import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/providers/mock_data_provider.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/data/mock_data_repository_ar.dart';

class TourGuidesListScreen extends ConsumerStatefulWidget {
  const TourGuidesListScreen({super.key});

  @override
  ConsumerState<TourGuidesListScreen> createState() => _TourGuidesListScreenState();
}

class _TourGuidesListScreenState extends ConsumerState<TourGuidesListScreen> {
  String _selectedSpecialty = 'all';
  String _selectedLanguage = 'all';

  List<Map<String, dynamic>> get _filteredGuides {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    
    final allGuides = isArabic 
        ? MockDataRepositoryAr().getAllTourGuides()
        : MockDataRepository().getAllTourGuides();
    
    return (allGuides ?? []).where((guide) {
      final specialtyMatch =
          _selectedSpecialty == 'all' ||
          (guide['specialty']?.toString() ?? '').toLowerCase() == _selectedSpecialty.toLowerCase();
      final languageMatch =
          _selectedLanguage == 'all' ||
          (((guide['languages'] as List?)?.cast<String>() ?? <String>[]).any(
            (lang) => lang.toLowerCase() == _selectedLanguage.toLowerCase(),
          ));
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
        title: Text('tour_guides.title'.tr()),
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
                          style: AppTheme.titleMedium.copyWith(
                            color: AppTheme.gray,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedSpecialty = 'all';
                              _selectedLanguage = 'all';
                            });
                          },
                          child: Text('tourist.search.clear_filters'.tr()),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    itemCount: _filteredGuides.length,
                    itemBuilder: (context, index) {
                      final guide = _filteredGuides[index];
                      return _buildGuideCard(guide);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: const TouristBottomNav(currentIndex: 1),
      ),
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
    // Null-safe defaults
    final imageUrl = guide['imageUrl']?.toString() ?? 'https://via.placeholder.com/80';
    final name = guide['name']?.toString() ?? 'Unknown Guide';
    final rating = guide['rating'] as num? ?? 0;
    final reviews = guide['reviews']?.toString() ?? '0';
    final experience = guide['experience'] as num? ?? 0;
    final bio = guide['bio']?.toString() ?? 'No bio available';
    final languages = (guide['languages'] as List?)?.cast<String>() ?? <String>[];
    final hourlyRate = guide['hourlyRate'] as num? ?? 0;
    final verified = guide['verified'] as bool? ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) => const AssetImage('assets/placeholder.png'),
                      ),
                    ),
                  ),
                  if (verified)
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
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.lightBlueGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppTheme.primaryOrange,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating.toString(),
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
                      '$experience years experience • $reviews reviews',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.gray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bio,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: languages.take(3).map(
                            (lang) => Container(
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
                            ),
                          ).toList(),
                    ),
                    const SizedBox(height: 12),
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
                              'EGP ${hourlyRate.toStringAsFixed(0)}/hr',
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
                          child: Text('tour_guides.view_profile'.tr()),
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
    // Implementation continues in next message due to length
    // ... (rest of the modal implementation from original file)
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppTheme.gray),
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
                color: isAvailable
                    ? AppTheme.successGreen
                    : AppTheme.lightBlueGray,
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
            Text(day, style: const TextStyle(fontSize: 10)),
          ],
        );
      }).toList(),
    );
  }
}