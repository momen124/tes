import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/providers/mock_data_provider.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/data/mock_data_repository_ar.dart';

class AttractionsListScreen extends ConsumerStatefulWidget {
  const AttractionsListScreen({super.key});

  @override
  ConsumerState<AttractionsListScreen> createState() => _AttractionsListScreenState();
}

class _AttractionsListScreenState extends ConsumerState<AttractionsListScreen> {
  String _selectedCategory = 'all';

  List<Map<String, dynamic>> get _filteredAttractions {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final allAttractions = isArabic
        ? MockDataRepositoryAr().getAllAttractions()
        : MockDataRepository().getAllAttractions();

    if (_selectedCategory == 'all') {
      return allAttractions;
    }
    return allAttractions
        .where((attraction) => attraction['category'] == _selectedCategory)
        .toList();
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
        title: Text('attractions.title'.tr()),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildCategoryChip('All', 'all', Icons.explore),
                  _buildCategoryChip(
                    'Historical',
                    'historical',
                    Icons.account_balance,
                  ),
                  _buildCategoryChip('Nature', 'nature', Icons.nature),
                  _buildCategoryChip('Adventure', 'adventure', Icons.terrain),
                  _buildCategoryChip('Culture', 'culture', Icons.museum),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Attractions Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: _filteredAttractions.length,
              itemBuilder: (context, index) {
                final attraction = _filteredAttractions[index];
                return _buildAttractionCard(attraction);
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

Widget _buildCategoryChip(String label, String value, IconData icon) {
  final isSelected = _selectedCategory == value;
  return Padding(
    padding: const EdgeInsets.only(right: 8, bottom: 8),
    child: FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? AppTheme.white : AppTheme.primaryOrange,
          ),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      onSelected: (selected) {
        setState(() => _selectedCategory = value);
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

  Widget _buildAttractionCard(Map<String, dynamic> attraction) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          _showAttractionDetails(attraction);
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(attraction['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppTheme.primaryOrange,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              (attraction['rating'] ?? 0).toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(attraction['category']),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      attraction['difficulty'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attraction['name'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: AppTheme.gray,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            attraction['duration'],
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.gray,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EGP ${(attraction['price'] ?? 0).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: AppTheme.primaryOrange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'historical':
        return Colors.brown;
      case 'nature':
        return Colors.green;
      case 'adventure':
        return Colors.red;
      case 'culture':
        return Colors.purple;
      default:
        return AppTheme.primaryOrange;
    }
  }

  void _showAttractionDetails(Map<String, dynamic> attraction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, controller) {
            return Container(
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
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(attraction['imageUrl']),
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
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black45,
                          ),
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
                        Text(
                          attraction['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppTheme.primaryOrange,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${attraction['rating'] ?? ''} (${attraction['reviews'] ?? ''} reviews)',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.gray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // ADDED: Before You Book Information Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppTheme.primaryOrange.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: AppTheme.primaryOrange,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Before You Book',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryOrange,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildInfoPoint(
                                Icons.check_circle_outline,
                                'Comfortable walking shoes recommended',
                              ),
                              _buildInfoPoint(
                                Icons.water_drop_outlined,
                                'Bring water and sun protection',
                              ),
                              _buildInfoPoint(
                                Icons.camera_alt_outlined,
                                'Photography allowed in designated areas',
                              ),
                              _buildInfoPoint(
                                Icons.access_time_outlined,
                                'Arrive 15 minutes before tour starts',
                              ),
                            ],
                          ),
                        ),

                        // Description
                        Text(
                          attraction['description'],
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                        const SizedBox(height: 24),

                        // Info Cards
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoCard(
                                Icons.access_time,
                                'Duration',
                                attraction['duration'],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildInfoCard(
                                Icons.fitness_center,
                                'Difficulty',
                                attraction['difficulty'],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoCard(
                                Icons.location_on,
                                'Location',
                                attraction['location'],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildInfoCard(
                                Icons.schedule,
                                'Hours',
                                attraction['openingHours'],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Highlights
                        const Text(
                          'Highlights',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...((attraction['highlights'] as List?)?.cast<String>() ?? <String>[]).map(
                          (highlight) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: AppTheme.successGreen,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  highlight,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Book Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.push(
                                '/booking_form?type=attraction',
                                extra: {'serviceData': attraction},
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryOrange,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'Book for EGP ${(attraction['price'] ?? 0).toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  Widget _buildInfoCard(IconData icon, String label, String value) {
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
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppTheme.gray),
          ),
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

  // NEW: Helper for info points in "Before You Book"
  Widget _buildInfoPoint(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppTheme.primaryOrange,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
