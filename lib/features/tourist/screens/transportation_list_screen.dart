// lib/features/tourist/screens/transportation_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/providers/mock_data_provider.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/data/mock_data_repository_ar.dart';

class TransportationListScreen extends ConsumerStatefulWidget {
  const TransportationListScreen({super.key});

  @override
  ConsumerState<TransportationListScreen> createState() =>
      _TransportationListScreenState();
}

class _TransportationListScreenState extends ConsumerState<TransportationListScreen> {
  String _selectedType = 'all';
  String _selectedLocation = 'inside'; // Default to inside Siwa
  String _selectedRentalType = 'all'; // with_driver or self_drive

  List<Map<String, dynamic>> get _filteredServices {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final allTransportation = isArabic
        ? MockDataRepositoryAr().getAllTransportation()
        : MockDataRepository().getAllTransportation();

    return allTransportation.where((service) {
      // Location filter (inside/outside Siwa)
      final serviceLocation = service['serviceLocation']?.toString() ?? 'inside';
      final locationMatch = _selectedLocation == 'all' || serviceLocation == _selectedLocation;
      
      // Type filter
      final typeMatch = _selectedType == 'all' || service['type'] == _selectedType;
      
      // Rental type filter (only for inside Siwa rentals)
      if (_selectedLocation == 'inside' && _selectedRentalType != 'all') {
        final rentalType = service['rentalType']?.toString() ?? '';
        final rentalMatch = rentalType == _selectedRentalType;
        return locationMatch && typeMatch && rentalMatch;
      }
      
      return locationMatch && typeMatch;
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
        title: Text(isArabic ? 'المواصلات' : 'Transportation'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Location Filter (Inside/Outside Siwa)
          Container(
            color: AppTheme.primaryOrange.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppTheme.primaryOrange, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      isArabic ? 'الموقع' : 'Location',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildLocationChip(
                        isArabic ? 'داخل سيوة' : 'Inside Siwa',
                        'inside',
                        Icons.location_city,
                        isArabic,
                      ),
                      _buildLocationChip(
                        isArabic ? 'خارج سيوة' : 'To/From Siwa',
                        'outside',
                        Icons.flight_takeoff,
                        isArabic,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Type Filter (changes based on location)
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? 'النوع' : 'Type',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.gray,
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _selectedLocation == 'inside'
                        ? _buildInsideSiwaFilters(isArabic)
                        : _buildOutsideSiwaFilters(isArabic),
                  ),
                ),
              ],
            ),
          ),

          // Rental Type Filter (only for inside Siwa)
          if (_selectedLocation == 'inside')
            Container(
              color: AppTheme.lightBlueGray,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'نوع الاستئجار' : 'Rental Type',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildRentalTypeChip(
                          isArabic ? 'الكل' : 'All',
                          'all',
                          Icons.all_inclusive,
                          isArabic,
                        ),
                        _buildRentalTypeChip(
                          isArabic ? 'مع سائق' : 'With Driver',
                          'with_driver',
                          Icons.person,
                          isArabic,
                        ),
                        _buildRentalTypeChip(
                          isArabic ? 'قيادة ذاتية' : 'Self Drive',
                          'self_drive',
                          Icons.key,
                          isArabic,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // Transportation List
          Expanded(
            child: _filteredServices.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_car_outlined,
                          size: 64,
                          color: AppTheme.gray.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isArabic ? 'لا توجد خدمات متاحة' : 'No services available',
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
                              _selectedRentalType = 'all';
                            });
                          },
                          child: Text(isArabic ? 'مسح الفلاتر' : 'Clear Filters'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    itemCount: _filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = _filteredServices[index];
                      return _buildTransportCard(service, isArabic);
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

  List<Widget> _buildInsideSiwaFilters(bool isArabic) {
    return [
      _buildFilterChip(isArabic ? 'الكل' : 'All', 'all', Icons.apps, isArabic),
      _buildFilterChip(isArabic ? 'دراجة' : 'Bicycle', 'bicycle', Icons.pedal_bike, isArabic),
      _buildFilterChip(isArabic ? 'عربة حمار' : 'Donkey Cart', 'donkey_cart', Icons.agriculture, isArabic),
      _buildFilterChip(isArabic ? 'توك توك' : 'Tuk-Tuk', 'tuk_tuk', Icons.electric_rickshaw, isArabic),
      _buildFilterChip(isArabic ? 'تاكسي محلي' : 'Local Taxi', 'local_taxi', Icons.local_taxi, isArabic),
    ];
  }

  List<Widget> _buildOutsideSiwaFilters(bool isArabic) {
    return [
      _buildFilterChip(isArabic ? 'الكل' : 'All', 'all', Icons.apps, isArabic),
      _buildFilterChip(isArabic ? 'باص' : 'Bus', 'bus', Icons.directions_bus, isArabic),
      _buildFilterChip(isArabic ? 'تاكسي خاص' : 'Private Taxi', 'private_taxi', Icons.local_taxi, isArabic),
      _buildFilterChip(isArabic ? 'سيارة خاصة' : 'Private Car', 'private_car', Icons.directions_car, isArabic),
      _buildFilterChip(isArabic ? 'طائرة' : 'Flight', 'flight', Icons.flight, isArabic),
    ];
  }

  Widget _buildLocationChip(String label, String value, IconData icon, bool isArabic) {
    final isSelected = _selectedLocation == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
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
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 13)),
          ],
        ),
        onSelected: (selected) {
          setState(() {
            _selectedLocation = value;
            _selectedType = 'all';
            _selectedRentalType = 'all';
          });
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

  Widget _buildFilterChip(String label, String value, IconData icon, bool isArabic) {
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
            Text(label, style: const TextStyle(fontSize: 12)),
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

  Widget _buildRentalTypeChip(String label, String value, IconData icon, bool isArabic) {
    final isSelected = _selectedRentalType == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
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
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
        onSelected: (selected) {
          setState(() => _selectedRentalType = value);
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

  Widget _buildTransportCard(Map<String, dynamic> service, bool isArabic) {
    final name = isArabic ? (service['nameAr'] ?? service['name']) : service['name'];
    final description = isArabic ? (service['descriptionAr'] ?? service['description']) : service['description'];
    final serviceLocation = service['serviceLocation']?.toString() ?? 'inside';
    final rentalType = service['rentalType']?.toString();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          context.push(
            '/booking_form?type=transportation',
            extra: {'serviceData': service},
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Badges
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(service['imageUrl'] ?? 'https://via.placeholder.com/400x200'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Type Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryOrange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_getTypeIcon(service['type']), size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          (service['type'] ?? 'transport').toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Rental Type Badge (only for inside Siwa with rental type)
                if (serviceLocation == 'inside' && rentalType != null)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: rentalType == 'with_driver' ? Colors.blue : Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            rentalType == 'with_driver' ? Icons.person : Icons.key,
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rentalType == 'with_driver'
                                ? (isArabic ? 'مع سائق' : 'With Driver')
                                : (isArabic ? 'قيادة ذاتية' : 'Self Drive'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                // Rating Badge (for outside services)
                if (serviceLocation == 'outside')
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
                            (service['rating'] ?? 4.5).toString(),
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
                  Text(
                    name ?? 'Transportation Service',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  
                  if (description != null)
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: AppTheme.gray),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  
                  const SizedBox(height: 12),

                  // Route info (for outside services)
                  if (service['route'] != null) ...[
                    Row(
                      children: [
                        const Icon(Icons.route, size: 16, color: AppTheme.gray),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            service['route'],
                            style: const TextStyle(fontSize: 13, color: AppTheme.darkGray),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],

                  // Duration and seats
                  Row(
                    children: [
                      if (service['duration'] != null) ...[
                        const Icon(Icons.access_time, size: 16, color: AppTheme.gray),
                        const SizedBox(width: 4),
                        Text(
                          service['duration'],
                          style: const TextStyle(fontSize: 13, color: AppTheme.gray),
                        ),
                      ],
                      if (service['seats'] != null) ...[
                        const SizedBox(width: 16),
                        const Icon(Icons.event_seat, size: 16, color: AppTheme.gray),
                        const SizedBox(width: 4),
                        Text(
                          '${service['seats']} ${isArabic ? "مقاعد" : "seats"}',
                          style: const TextStyle(fontSize: 13, color: AppTheme.gray),
                        ),
                      ],
                    ],
                  ),
                  
                  const SizedBox(height: 12),

                  // Amenities
                  if (service['amenities'] != null)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ((service['amenities'] as List?)?.cast<String>() ?? [])
                          .take(3)
                          .map((amenity) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.lightBlueGray,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  amenity,
                                  style: const TextStyle(fontSize: 11, color: AppTheme.darkGray),
                                ),
                              ))
                          .toList(),
                    ),
                  
                  const SizedBox(height: 12),

                  // Price and Book Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic ? 'من' : 'From',
                            style: const TextStyle(fontSize: 12, color: AppTheme.gray),
                          ),
                          Text(
                            'EGP ${((service['price'] ?? 0) as num).toDouble().toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryOrange,
                            ),
                          ),
                          if (service['priceUnit'] != null)
                            Text(
                              service['priceUnit'],
                              style: const TextStyle(fontSize: 11, color: AppTheme.gray),
                            ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.push(
                            '/booking_form?type=transportation',
                            extra: {'serviceData': service},
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryOrange,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(isArabic ? 'احجز الآن' : 'Book Now'),
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

  IconData _getTypeIcon(String? type) {
    switch (type) {
      case 'bicycle':
        return Icons.pedal_bike;
      case 'donkey_cart':
        return Icons.agriculture;
      case 'tuk_tuk':
        return Icons.electric_rickshaw;
      case 'local_taxi':
        return Icons.local_taxi;
      case 'bus':
        return Icons.directions_bus;
      case 'private_taxi':
        return Icons.local_taxi;
      case 'private_car':
        return Icons.directions_car;
      case 'flight':
        return Icons.flight;
      default:
        return Icons.directions;
    }
  }
}