import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/service_card.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';

class TouristSearchScreen extends StatefulWidget {
  const TouristSearchScreen({super.key});

  @override
  State<TouristSearchScreen> createState() => _TouristSearchScreenState();
}

class _TouristSearchScreenState extends State<TouristSearchScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _priceFilter = 'all';
  bool _ecoTourism = false;

  final List<Map<String, dynamic>> _allServices = [
    {
      'name': 'Siwa Shali Resort',
      'price': 120.0,
      'rating': 4.5,
      'location': 'Siwa, Egypt',
      'imageUrl': 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg?w=900&h=500&s=1',
      'eco_friendly': true,
      'reviews': 125,
    },
    {
      'name': 'Adrar Amellal',
      'price': 150.0,
      'rating': 4.7,
      'location': 'Siwa, Egypt',
      'imageUrl': 'https://www.adrereamellal.com/adrere/wp-content/uploads/2019/09/Adrere-amellal-siwa-oasis-eco-lodge-Omar-Hikal.jpg',
      'eco_friendly': true,
      'reviews': 98,
    },
    {
      'name': 'Taziry Ecolodge Siwa',
      'price': 90.0,
      'rating': 4.3,
      'location': 'Siwa, Egypt',
      'eco_friendly': true,
      'reviews': 67,
    },
    {
      'name': 'Siwa Safari Gardens Hotel',
      'price': 100.0,
      'rating': 4.4,
      'location': 'Siwa, Egypt',
      'imageUrl': 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/19/99/b2/30/siwa-safari-gardens-hotel.jpg',
      'eco_friendly': false,
      'reviews': 88,
    },
  ];

  List<Map<String, dynamic>> get _filteredServices {
    return _allServices.where((service) {
      final matchesSearch = service['name']
        .toString()
        .toLowerCase()
        .contains(_searchQuery.toLowerCase());
      
      final matchesPrice = _priceFilter == 'all' ||
        _getPriceRange(service['price']) == _priceFilter;
      
      final matchesEco = !_ecoTourism || (service['eco_friendly'] ?? false);
      
      return matchesSearch && matchesPrice && matchesEco;
    }).toList();
  }

  String _getPriceRange(double price) {
    if (price < 100) return 'budget';
    if (price < 150) return 'mid';
    return 'luxury';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        title: const Text('Search'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search, color: AppTheme.primaryOrange),
                suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
                filled: true,
                fillColor: AppTheme.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppTheme.secondaryGray.withOpacity(0.3)),
                ),
              ),
            ),
          ),
          
          // Filters
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _priceFilter,
                  underline: const SizedBox(),
                  items: const [
                   DropdownMenuItem(value: 'all', child: Text('All Prices')),
DropdownMenuItem(value: 'budget', child: Text('Budget (<\$100)')),
DropdownMenuItem(value: 'mid', child: Text('Mid (\$100-\$150)')),
DropdownMenuItem(value: 'luxury', child: Text('Luxury (>\$150)')),
                  ],
                  onChanged: (value) {
                    setState(() => _priceFilter = value!);
                  },
                ),
                FilterChip(
                  label: const Text('Eco-tourism'),
                  selected: _ecoTourism,
                  onSelected: (selected) {
                    setState(() => _ecoTourism = selected);
                  },
                  selectedColor: AppTheme.primaryOrange.withOpacity(0.2),
                  checkmarkColor: AppTheme.primaryOrange,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Results
          Expanded(
            child: _filteredServices.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: AppTheme.gray.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No services found',
                        style: AppTheme.titleMedium.copyWith(color: AppTheme.gray),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                            _priceFilter = 'all';
                            _ecoTourism = false;
                            _searchController.clear();
                          });
                        },
                        child: const Text('Clear Filters'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredServices.length,
                  itemBuilder: (context, index) {
                    final service = _filteredServices[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ServiceCard(
                        name: service['name'],
                        price: service['price'],
                        rating: service['rating'],
                        location: service['location'],
                        imageUrl: service['imageUrl'],
                        reviews: service['reviews'],
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
      bottomNavigationBar: const TouristBottomNav(currentIndex: 1),
    );
  }
}