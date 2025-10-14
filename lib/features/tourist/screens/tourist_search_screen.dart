// lib/features/tourist/screens/tourist_search_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/search_filter_provider.dart';
import 'package:siwa/features/tourist/widgets/service_card.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

class TouristSearchScreen extends StatefulWidget {
  final bool? featuredOnly;
  final bool? hiddenGemsOnly;

  const TouristSearchScreen({
    super.key,
    this.featuredOnly,
    this.hiddenGemsOnly,
  });

  @override
  State<TouristSearchScreen> createState() => _TouristSearchScreenState();
}

class _TouristSearchScreenState extends State<TouristSearchScreen> {
  final _searchController = TextEditingController();
  Timer? _debounceTimer;
  bool _showFilterPanel = false;

  // Sample data - Replace with actual data from backend/provider
  final List<Map<String, dynamic>> _allServices = [
    {
      'name': 'Siwa Shali Resort',
      'price': 120.0,
      'rating': 4.5,
      'location': 'Siwa, Egypt',
      'imageUrl': 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg?w=900&h=500&s=1',
      'eco_friendly': true,
      'reviews': 125,
      'category': 'accommodation',
      'description': 'Luxury eco-resort with traditional architecture',
      'tags': ['luxury', 'eco', 'pool', 'spa'],
      'featured': true,
    },
    {
      'name': 'Adrar Amellal',
      'price': 150.0,
      'rating': 4.7,
      'location': 'Siwa, Egypt',
      'imageUrl': 'https://www.adrereamellal.com/adrere/wp-content/uploads/2019/09/Adrere-amellal-siwa-oasis-eco-lodge-Omar-Hikal.jpg',
      'eco_friendly': true,
      'reviews': 98,
      'category': 'accommodation',
      'description': 'Candlelit eco-lodge without electricity',
      'tags': ['eco', 'unique', 'romantic'],
      'featured': true,
    },
    {
      'name': 'Taziry Ecolodge Siwa',
      'price': 90.0,
      'rating': 4.3,
      'location': 'Siwa, Egypt',
      'eco_friendly': true,
      'reviews': 67,
      'category': 'accommodation',
      'description': 'Budget-friendly eco-lodge',
      'tags': ['eco', 'budget'],
    },
    {
      'name': 'Desert Safari Adventure',
      'price': 80.0,
      'rating': 4.6,
      'location': 'Siwa Desert',
      'imageUrl': 'https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800',
      'reviews': 128,
      'category': 'attraction',
      'description': 'Thrilling 4x4 desert safari',
      'tags': ['adventure', 'desert', 'safari'],
      'hidden_gem': true,
    },
    {
      'name': 'Abdu Restaurant',
      'price': 25.0,
      'rating': 4.8,
      'location': 'Market Square, Siwa',
      'imageUrl': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800',
      'reviews': 234,
      'category': 'restaurant',
      'description': 'Traditional Siwan cuisine',
      'tags': ['traditional', 'local', 'authentic'],
      'hidden_gem': true,
    },
    {
      'name': 'Siwa Express Bus',
      'price': 150.0,
      'rating': 4.5,
      'location': 'Cairo - Siwa',
      'reviews': 234,
      'category': 'transportation',
      'description': 'Comfortable express bus service',
      'tags': ['bus', 'transport', 'comfortable'],
    },
  ];

  @override
  void initState() {
    super.initState();
    // Set initial filters if provided
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SearchFilterProvider>(context, listen: false);
      if (widget.featuredOnly == true) {
        provider.setFeaturedOnly(true);
      }
      if (widget.hiddenGemsOnly == true) {
        provider.setHiddenGemsOnly(true);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query, SearchFilterProvider provider) {
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    // Start new timer (300ms debounce)
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      provider.setSearchQuery(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchFilterProvider(),
      child: Consumer<SearchFilterProvider>(
        builder: (context, filterProvider, child) {
          final filteredServices = filterProvider.filterServices(_allServices);
          
          return Scaffold(
            backgroundColor: AppTheme.lightBlueGray,
            appBar: AppBar(
              backgroundColor: AppTheme.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/tourist_home'),
              ),
              title: Text('Search'.tr()),
              elevation: 0,
              actions: [
                // Filter toggle button
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.tune),
                      onPressed: () {
                        setState(() => _showFilterPanel = !_showFilterPanel);
                      },
                    ),
                    if (filterProvider.activeFilterCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${filterProvider.activeFilterCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            body: Column(
              children: [
                // Search Bar
                Container(
                  color: AppTheme.white,
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => _onSearchChanged(value, filterProvider),
                    decoration: InputDecoration(
                      hintText: 'Search by name, location, or tags...'.tr(),
                      prefixIcon: const Icon(Icons.search, color: AppTheme.primaryOrange),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchController.clear();
                                filterProvider.setSearchQuery('');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppTheme.lightBlueGray,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // Active Filters Display
                if (filterProvider.activeFilterCount > 0)
                  Container(
                    color: AppTheme.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${filterProvider.activeFilterCount} filter${filterProvider.activeFilterCount > 1 ? 's' : ''} active',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.gray,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                filterProvider.clearAllFilters();
                                _searchController.clear();
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Clear All',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _buildActiveFilterChips(filterProvider),
                        ),
                      ],
                    ),
                  ),

                // Filter Panel
                if (_showFilterPanel) _buildFilterPanel(filterProvider),

                // Results Header
                Container(
                  color: AppTheme.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${filteredServices.length} result${filteredServices.length != 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Sort Dropdown
                      DropdownButton<String>(
                        value: filterProvider.sortBy,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.sort, size: 20),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.darkGray,
                        ),
                        items: [
                          DropdownMenuItem(value: 'recommended', child: Text('Recommended'.tr())),
                          DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High'.tr())),
                          DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low'.tr())),
                          DropdownMenuItem(value: 'rating', child: Text('Highest Rated'.tr())),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            filterProvider.setSortBy(value);
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Results List
                Expanded(
                  child: filteredServices.isEmpty
                      ? _buildEmptyState(filterProvider)
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredServices.length,
                          itemBuilder: (context, index) {
                            final service = filteredServices[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ServiceCard(
                                name: service['name'],
                                price: service['price'],
                                rating: service['rating'],
                                location: service['location'],
                                imageUrl: service['imageUrl'],
                                reviews: service['reviews'],
                                description: service['description'],
                                serviceType: service['category'] ?? 'accommodation',
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
            bottomNavigationBar: const TouristBottomNav(currentIndex: 1),
          );
        },
      ),
    );
  }

  List<Widget> _buildActiveFilterChips(SearchFilterProvider provider) {
    List<Widget> chips = [];

    if (provider.searchQuery.isNotEmpty) {
      chips.add(_buildFilterChip(
        'Search: "${provider.searchQuery}"',
        () {
          _searchController.clear();
          provider.setSearchQuery('');
        },
      ));
    }

    if (provider.minPrice > 0 || provider.maxPrice < 500) {
      chips.add(_buildFilterChip(
        provider.getPriceRangeLabel(),
        () => provider.setPriceRange(0, 500),
      ));
    }

    for (final category in provider.selectedCategories) {
      chips.add(_buildFilterChip(
        category,
        () => provider.toggleCategory(category),
      ));
    }

    if (provider.ecoFriendlyOnly) {
      chips.add(_buildFilterChip(
        'Eco-Friendly',
        () => provider.setEcoFriendly(false),
      ));
    }

    if (provider.minRating > 0) {
      chips.add(_buildFilterChip(
        '${provider.minRating}+ stars',
        () => provider.setMinRating(0),
      ));
    }

    if (provider.featuredOnly) {
      chips.add(_buildFilterChip(
        'Featured',
        () => provider.setFeaturedOnly(false),
      ));
    }

    if (provider.hiddenGemsOnly) {
      chips.add(_buildFilterChip(
        'Hidden Gems',
        () => provider.setHiddenGemsOnly(false),
      ));
    }

    return chips;
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      deleteIcon: const Icon(Icons.close, size: 16),
      onDeleted: onRemove,
      backgroundColor: AppTheme.primaryOrange.withOpacity(0.1),
      deleteIconColor: AppTheme.primaryOrange,
      labelStyle: const TextStyle(color: AppTheme.primaryOrange),
    );
  }

  Widget _buildFilterPanel(SearchFilterProvider provider) {
    return Container(
      color: AppTheme.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price Range
          const Text(
            'Price Range',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          RangeSlider(
            values: RangeValues(provider.minPrice, provider.maxPrice),
            min: 0,
            max: 500,
            divisions: 50,
            labels: RangeLabels(
              'EGP ${provider.minPrice.toInt()}',
              'EGP ${provider.maxPrice.toInt()}',
            ),
            activeColor: AppTheme.primaryOrange,
            onChanged: (values) {
              provider.setPriceRange(values.start, values.end);
            },
          ),
          Text(
            provider.getPriceRangeLabel(),
            style: const TextStyle(fontSize: 12, color: AppTheme.gray),
          ),
          const SizedBox(height: 16),

          // Categories
          const Text(
            'Categories',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCategoryChip('accommodation', provider),
              _buildCategoryChip('restaurant', provider),
              _buildCategoryChip('attraction', provider),
              _buildCategoryChip('transportation', provider),
            ],
          ),
          const SizedBox(height: 16),

          // Minimum Rating
          const Text(
            'Minimum Rating',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: provider.minRating,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  label: provider.minRating > 0 ? '${provider.minRating}+ stars' : 'Any',
                  activeColor: AppTheme.primaryOrange,
                  onChanged: (value) {
                    provider.setMinRating(value);
                  },
                ),
              ),
              Text(
                provider.minRating > 0 ? '${provider.minRating}+' : 'Any',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Eco-Friendly Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.eco, color: AppTheme.successGreen, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Eco-Friendly Only',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Switch(
                value: provider.ecoFriendlyOnly,
                onChanged: (value) => provider.setEcoFriendly(value),
                activeThumbColor: AppTheme.primaryOrange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category, SearchFilterProvider provider) {
    final isSelected = provider.selectedCategories.contains(category);
    return FilterChip(
      label: Text(category[0].toUpperCase() + category.substring(1)),
      selected: isSelected,
      onSelected: (_) => provider.toggleCategory(category),
      selectedColor: AppTheme.primaryOrange,
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppTheme.darkGray,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildEmptyState(SearchFilterProvider provider) {
    return Center(
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
          const Text(
            'Try adjusting your filters',
            style: TextStyle(fontSize: 14, color: AppTheme.gray),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              provider.clearAllFilters();
              _searchController.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryOrange,
            ),
            child: Text('Clear All Filters'.tr()),
          ),
        ],
      ),
    );
  }
}