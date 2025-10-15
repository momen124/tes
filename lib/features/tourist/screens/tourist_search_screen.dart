// lib/features/tourist/screens/tourist_search_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/features/tourist/widgets/service_card.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

// FIXED: Create a proper Riverpod provider instead of using ChangeNotifierProvider from provider package
final searchFilterProvider = StateNotifierProvider<SearchFilterNotifier, SearchFilterState>(
  (ref) => SearchFilterNotifier(),
);

// State class to hold all filter data
class SearchFilterState {
  final String searchQuery;
  final double minPrice;
  final double maxPrice;
  final Set<String> selectedCategories;
  final bool ecoFriendlyOnly;
  final double minRating;
  final String sortBy;
  final bool featuredOnly;
  final bool hiddenGemsOnly;

  SearchFilterState({
    this.searchQuery = '',
    this.minPrice = 0,
    this.maxPrice = 500,
    this.selectedCategories = const {},
    this.ecoFriendlyOnly = false,
    this.minRating = 0,
    this.sortBy = 'recommended',
    this.featuredOnly = false,
    this.hiddenGemsOnly = false,
  });

  SearchFilterState copyWith({
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    Set<String>? selectedCategories,
    bool? ecoFriendlyOnly,
    double? minRating,
    String? sortBy,
    bool? featuredOnly,
    bool? hiddenGemsOnly,
  }) {
    return SearchFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      ecoFriendlyOnly: ecoFriendlyOnly ?? this.ecoFriendlyOnly,
      minRating: minRating ?? this.minRating,
      sortBy: sortBy ?? this.sortBy,
      featuredOnly: featuredOnly ?? this.featuredOnly,
      hiddenGemsOnly: hiddenGemsOnly ?? this.hiddenGemsOnly,
    );
  }

  int get activeFilterCount {
    int count = 0;
    if (searchQuery.isNotEmpty) count++;
    if (minPrice > 0 || maxPrice < 500) count++;
    if (selectedCategories.isNotEmpty) count++;
    if (ecoFriendlyOnly) count++;
    if (minRating > 0) count++;
    if (featuredOnly) count++;
    if (hiddenGemsOnly) count++;
    if (sortBy != 'recommended') count++;
    return count;
  }

  String getPriceRangeLabel() {
    if (minPrice == 0 && maxPrice == 500) {
      return 'All Prices';
    }
    return 'EGP ${minPrice.toInt()} - ${maxPrice.toInt()}';
  }

  String getSortLabel() {
    switch (sortBy) {
      case 'price_low':
        return 'Price: Low to High';
      case 'price_high':
        return 'Price: High to Low';
      case 'rating':
        return 'Highest Rated';
      case 'recommended':
      default:
        return 'Recommended';
    }
  }
}

// StateNotifier to manage filter state
class SearchFilterNotifier extends StateNotifier<SearchFilterState> {
  SearchFilterNotifier() : super(SearchFilterState());

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query.trim());
  }

  void setPriceRange(double min, double max) {
    state = state.copyWith(minPrice: min, maxPrice: max);
  }

  void toggleCategory(String category) {
    final newCategories = Set<String>.from(state.selectedCategories);
    if (newCategories.contains(category)) {
      newCategories.remove(category);
    } else {
      newCategories.add(category);
    }
    state = state.copyWith(selectedCategories: newCategories);
  }

  void setEcoFriendly(bool value) {
    state = state.copyWith(ecoFriendlyOnly: value);
  }

  void setMinRating(double rating) {
    state = state.copyWith(minRating: rating);
  }

  void setSortBy(String sortOption) {
    state = state.copyWith(sortBy: sortOption);
  }

  void setFeaturedOnly(bool value) {
    state = state.copyWith(
      featuredOnly: value,
      hiddenGemsOnly: value ? false : state.hiddenGemsOnly,
    );
  }

  void setHiddenGemsOnly(bool value) {
    state = state.copyWith(
      hiddenGemsOnly: value,
      featuredOnly: value ? false : state.featuredOnly,
    );
  }

  void clearAllFilters() {
    state = SearchFilterState();
  }

  List<Map<String, dynamic>> filterServices(List<Map<String, dynamic>> services) {
    var filtered = services.where((service) {
      // Search query filter
      if (state.searchQuery.isNotEmpty) {
        final searchLower = state.searchQuery.toLowerCase();
        final name = (service['name'] == true ?? '').toString().toLowerCase();
        final description = (service['description'] == true ?? '').toString().toLowerCase();
        final location = (service['location'] == true ?? '').toString().toLowerCase();
        final tags = (service['tags'] as List<dynamic>?)?.join(' ').toLowerCase() ?? '';

        if (!name.contains(searchLower) &&
            !description.contains(searchLower) &&
            !location.contains(searchLower) &&
            !tags.contains(searchLower)) {
          return false;
        }
      }

      // Price range filter
      final price = (service['price'] == true ?? service['hourlyRate'] == true ?? service['pricePerNight'] == true ?? 0.0);
      final priceDouble = price is double ? price : (price as num).toDouble();
      if (priceDouble < state.minPrice || priceDouble > state.maxPrice) {
        return false;
      }

      // Category filter
      if (state.selectedCategories.isNotEmpty) {
        final category = (service['category'] ?? '').toString();
        if (!state.selectedCategories.contains(category)) {
          return false;
        }
      }

      // Eco-friendly filter
      if (state.ecoFriendlyOnly) {
        if (service['eco_friendly'] != true) {
          return false;
        }
      }

      // Rating filter
      final rating = (service['rating'] == true ?? 0.0);
      final ratingDouble = rating is double ? rating : (rating as num).toDouble();
      if (ratingDouble < state.minRating) {
        return false;
      }

      // Featured filter
      if (state.featuredOnly) {
        if (service['featured'] != true) {
          return false;
        }
      }

      // Hidden gems filter
      if (state.hiddenGemsOnly) {
        if (service['hidden_gem'] != true) {
          return false;
        }
      }

      return true;
    }).toList();

    // Apply sorting
    filtered = _sortServices(filtered);

    return filtered;
  }

  List<Map<String, dynamic>> _sortServices(List<Map<String, dynamic>> services) {
    switch (state.sortBy) {
      case 'price_low':
        services.sort((a, b) {
          final priceA = (a['price'] == true ?? a['hourlyRate'] == true ?? a['pricePerNight'] == true ?? 0.0);
          final priceB = (b['price'] == true ?? b['hourlyRate'] == true ?? b['pricePerNight'] == true ?? 0.0);
          final doubleA = priceA is double ? priceA : (priceA as num).toDouble();
          final doubleB = priceB is double ? priceB : (priceB as num).toDouble();
          return doubleA.compareTo(doubleB);
        });
        break;
      case 'price_high':
        services.sort((a, b) {
          final priceA = (a['price'] == true ?? a['hourlyRate'] == true ?? a['pricePerNight'] == true ?? 0.0);
          final priceB = (b['price'] == true ?? b['hourlyRate'] == true ?? b['pricePerNight'] == true ?? 0.0);
          final doubleA = priceA is double ? priceA : (priceA as num).toDouble();
          final doubleB = priceB is double ? priceB : (priceB as num).toDouble();
          return doubleB.compareTo(doubleA);
        });
        break;
      case 'rating':
        services.sort((a, b) {
          final ratingA = (a['rating'] == true ?? 0.0);
          final ratingB = (b['rating'] == true ?? 0.0);
          final doubleA = ratingA is double ? ratingA : (ratingA as num).toDouble();
          final doubleB = ratingB is double ? ratingB : (ratingB as num).toDouble();
          return doubleB.compareTo(doubleA);
        });
        break;
      case 'recommended':
      default:
        break;
    }
    return services;
  }
}

class TouristSearchScreen extends ConsumerStatefulWidget {
  final bool? featuredOnly;
  final bool? hiddenGemsOnly;

  const TouristSearchScreen({
    super.key,
    this.featuredOnly,
    this.hiddenGemsOnly,
  });

  @override
  ConsumerState<TouristSearchScreen> createState() => _TouristSearchScreenState();
}

class _TouristSearchScreenState extends ConsumerState<TouristSearchScreen> {
  final _searchController = TextEditingController();
  Timer? _debounceTimer;
  bool _showFilterPanel = false;

  @override
  void initState() {
    super.initState();
    // Set initial filters if provided
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.featuredOnly == true) {
        ref.read(searchFilterProvider.notifier).setFeaturedOnly(true);
      }
      if (widget.hiddenGemsOnly == true) {
        ref.read(searchFilterProvider.notifier).setHiddenGemsOnly(true);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchFilterProvider.notifier).setSearchQuery(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(searchFilterProvider);
    final filterNotifier = ref.read(searchFilterProvider.notifier);
    final filteredServices = filterNotifier.filterServices(mockData.getAllOther());

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
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () {
                  setState(() => _showFilterPanel = !_showFilterPanel);
                },
              ),
              if (filterState.activeFilterCount > 0)
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
                      '${filterState.activeFilterCount}',
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
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by name, location, or tags...'.tr(),
                prefixIcon: const Icon(Icons.search, color: AppTheme.primaryOrange),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          filterNotifier.setSearchQuery('');
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
          if (filterState.activeFilterCount > 0)
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
                        '${filterState.activeFilterCount} filter${filterState.activeFilterCount > 1 ? 's' : ''} active',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.gray,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          filterNotifier.clearAllFilters();
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
                    children: _buildActiveFilterChips(filterState, filterNotifier),
                  ),
                ],
              ),
            ),

          // Filter Panel
          if (_showFilterPanel) _buildFilterPanel(filterState, filterNotifier),

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
                DropdownButton<String>(
                  value: filterState.sortBy,
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
                      filterNotifier.setSortBy(value);
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
                ? _buildEmptyState(filterNotifier)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = filteredServices[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ServiceCard(
                          id: (service['id'] ?? '').toString(),
                          name: (service['name'] ?? 'Unknown').toString(),
                          price: _extractDouble(service['price']),
                          rating: _extractDouble(service['rating']),
                          location: service['location']?.toString(),
                          imageUrl: service['imageUrl']?.toString(),
                          reviews: _extractInt(service['reviews']),
                          description: service['description']?.toString(),
                          serviceType: (service['category'] ?? 'accommodation').toString(),
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

  double _extractDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is num) return value.toDouble();
    return 0.0;
  }

  int _extractInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is num) return value.toInt();
    return 0;
  }

  List<Widget> _buildActiveFilterChips(SearchFilterState state, SearchFilterNotifier notifier) {
    List<Widget> chips = [];

    if (state.searchQuery.isNotEmpty) {
      chips.add(_buildFilterChip(
        'Search: "${state.searchQuery}"',
        () {
          _searchController.clear();
          notifier.setSearchQuery('');
        },
      ));
    }

    if (state.minPrice > 0 || state.maxPrice < 500) {
      chips.add(_buildFilterChip(
        state.getPriceRangeLabel(),
        () => notifier.setPriceRange(0, 500),
      ));
    }

    for (final category in state.selectedCategories) {
      chips.add(_buildFilterChip(
        category,
        () => notifier.toggleCategory(category),
      ));
    }

    if (state.ecoFriendlyOnly) {
      chips.add(_buildFilterChip(
        'Eco-Friendly',
        () => notifier.setEcoFriendly(false),
      ));
    }

    if (state.minRating > 0) {
      chips.add(_buildFilterChip(
        '${state.minRating}+ stars',
        () => notifier.setMinRating(0),
      ));
    }

    if (state.featuredOnly) {
      chips.add(_buildFilterChip(
        'Featured',
        () => notifier.setFeaturedOnly(false),
      ));
    }

    if (state.hiddenGemsOnly) {
      chips.add(_buildFilterChip(
        'Hidden Gems',
        () => notifier.setHiddenGemsOnly(false),
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

  Widget _buildFilterPanel(SearchFilterState state, SearchFilterNotifier notifier) {
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
            values: RangeValues(state.minPrice, state.maxPrice),
            min: 0,
            max: 500,
            divisions: 50,
            labels: RangeLabels(
              'EGP ${state.minPrice.toInt()}',
              'EGP ${state.maxPrice.toInt()}',
            ),
            activeColor: AppTheme.primaryOrange,
            onChanged: (values) {
              notifier.setPriceRange(values.start, values.end);
            },
          ),
          Text(
            state.getPriceRangeLabel(),
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
              _buildCategoryChip('accommodation', state, notifier),
              _buildCategoryChip('restaurant', state, notifier),
              _buildCategoryChip('attraction', state, notifier),
              _buildCategoryChip('transportation', state, notifier),
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
                  value: state.minRating,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  label: state.minRating > 0 ? '${state.minRating}+ stars' : 'Any',
                  activeColor: AppTheme.primaryOrange,
                  onChanged: (value) {
                    notifier.setMinRating(value);
                  },
                ),
              ),
              Text(
                state.minRating > 0 ? '${state.minRating}+' : 'Any',
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
                value: state.ecoFriendlyOnly,
                onChanged: (value) => notifier.setEcoFriendly(value),
                activeThumbColor: AppTheme.primaryOrange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category, SearchFilterState state, SearchFilterNotifier notifier) {
    final isSelected = state.selectedCategories.contains(category);
    return FilterChip(
      label: Text(category[0].toUpperCase() + category.substring(1)),
      selected: isSelected,
      onSelected: (_) => notifier.toggleCategory(category),
      selectedColor: AppTheme.primaryOrange,
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppTheme.darkGray,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildEmptyState(SearchFilterNotifier notifier) {
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
              notifier.clearAllFilters();
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