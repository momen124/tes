// lib/features/tourist/screens/accommodations_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/data/mock_data_repository_ar.dart';

class AccommodationsListScreen extends ConsumerStatefulWidget {
  const AccommodationsListScreen({super.key});

  @override
  ConsumerState<AccommodationsListScreen> createState() => _AccommodationsListScreenState();
}

class _AccommodationsListScreenState extends ConsumerState<AccommodationsListScreen> {
  String _selectedType = 'all';
  String _priceRange = 'all';

  List<Map<String, dynamic>> get _filteredAccommodations {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final allHotels = isArabic
        ? MockDataRepositoryAr().getAllHotels()
        : MockDataRepository().getAllHotels();

    return allHotels.where((hotel) {
      // Type filter
      final typeMatch = _selectedType == 'all' || 
          (hotel['accommodationType']?.toString().toLowerCase() ?? 'hotel') == _selectedType;
      
      // Price range filter
      final price = (hotel['pricePerNight'] as num?)?.toDouble() ?? 0.0;
      bool priceMatch = true;
      
      if (_priceRange == 'budget') {
        priceMatch = price < 500;
      } else if (_priceRange == 'mid') {
        priceMatch = price >= 500 && price < 1000;
      } else if (_priceRange == 'luxury') {
        priceMatch = price >= 1000;
      }
      
      return typeMatch && priceMatch;
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
        title: Text(isArabic ? 'الإقامة' : 'Accommodations'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Type Filter
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    isArabic ? 'النوع' : 'Type',
                    style: const TextStyle(
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
                      _buildTypeChip(
                        isArabic ? 'الكل' : 'All',
                        'all',
                        Icons.hotel,
                        isArabic,
                      ),
                      _buildTypeChip(
                        isArabic ? 'فنادق' : 'Hotels',
                        'hotel',
                        Icons.hotel,
                        isArabic,
                      ),
                      _buildTypeChip(
                        isArabic ? 'نزل بيئية' : 'Eco-Lodges',
                        'eco-lodge',
                        Icons.cabin,
                        isArabic,
                      ),
                      _buildTypeChip(
                        isArabic ? 'بيوت الضيافة' : 'Guesthouses',
                        'guesthouse',
                        Icons.home,
                        isArabic,
                      ),
                      _buildTypeChip(
                        isArabic ? 'مخيمات' : 'Camps',
                        'camp',
                        Icons.terrain,
                        isArabic,
                      ),
                      _buildTypeChip(
                        isArabic ? 'منتجعات' : 'Resorts',
                        'resort',
                        Icons.beach_access,
                        isArabic,
                      ),
                      _buildTypeChip(
                        isArabic ? 'بيوت ريفية' : 'Villas',
                        'villa',
                        Icons.villa,
                        isArabic,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    isArabic ? 'السعر' : 'Price Range',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gray,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildPriceFilter(isArabic ? 'الكل' : 'All', 'all', isArabic),
                      _buildPriceFilter(isArabic ? 'ميزانية' : 'Budget', 'budget', isArabic),
                      _buildPriceFilter(isArabic ? 'متوسط' : 'Mid-Range', 'mid', isArabic),
                      _buildPriceFilter(isArabic ? 'فاخر' : 'Luxury', 'luxury', isArabic),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Accommodations Grid
          Expanded(
            child: _filteredAccommodations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hotel_outlined,
                          size: 64,
                          color: AppTheme.gray.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isArabic ? 'لا توجد إقامة متاحة' : 'No accommodations found',
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppTheme.gray,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedType = 'all';
                              _priceRange = 'all';
                            });
                          },
                          child: Text(isArabic ? 'مسح الفلاتر' : 'Clear Filters'),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _filteredAccommodations.length,
                    itemBuilder: (context, index) {
                      final accommodation = _filteredAccommodations[index];
                      return _buildAccommodationCard(accommodation, isArabic);
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

  Widget _buildTypeChip(String label, String value, IconData icon, bool isArabic) {
    final isSelected = _selectedType == value;
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
            Text(label, style: const TextStyle(fontSize: 13)),
          ],
        ),
        onSelected: (selected) {
          setState(() => _selectedType = value);
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

  Widget _buildPriceFilter(String label, String value, bool isArabic) {
    final isSelected = _priceRange == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() => _priceRange = value);
        },
        selectedColor: AppTheme.primaryOrange,
        backgroundColor: AppTheme.lightBlueGray,
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.white : AppTheme.darkGray,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildAccommodationCard(Map<String, dynamic> accommodation, bool isArabic) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          context.push('/service_detail', extra: accommodation);
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
                      image: NetworkImage(accommodation['imageUrl'] ?? ''),
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
                          (accommodation['rating'] ?? 0).toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Type Badge
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(accommodation['accommodationType']?.toString() ?? 'hotel'),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getTypeLabel(accommodation['accommodationType']?.toString() ?? 'hotel', isArabic),
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
                      accommodation['name'] ?? '',
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
                          Icons.location_on,
                          size: 12,
                          color: AppTheme.gray,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            accommodation['location'] ?? '',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.gray,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EGP ${((accommodation['pricePerNight'] ?? 0) as num).toDouble().toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                        Text(
                          isArabic ? '/ليلة' : '/night',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.gray,
                          ),
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

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'eco-lodge':
        return Colors.green;
      case 'guesthouse':
        return Colors.blue;
      case 'camp':
        return Colors.orange;
      case 'resort':
        return Colors.purple;
      case 'villa':
        return Colors.teal;
      default: // hotel
        return AppTheme.primaryOrange;
    }
  }

  String _getTypeLabel(String type, bool isArabic) {
    switch (type.toLowerCase()) {
      case 'eco-lodge':
        return isArabic ? 'نزل بيئي' : 'Eco-Lodge';
      case 'guesthouse':
        return isArabic ? 'بيت ضيافة' : 'Guesthouse';
      case 'camp':
        return isArabic ? 'مخيم' : 'Camp';
      case 'resort':
        return isArabic ? 'منتجع' : 'Resort';
      case 'villa':
        return isArabic ? 'بيت ريفي' : 'Villa';
      default:
        return isArabic ? 'فندق' : 'Hotel';
    }
  }
}