// lib/features/tourist/providers/search_filter_provider.dart
import 'package:flutter/foundation.dart';

class SearchFilterProvider extends ChangeNotifier {
  // Search query
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Price range filter
  double _minPrice = 0;
  double _maxPrice = 500;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;

  // Category filters
  final Set<String> _selectedCategories = {};
  Set<String> get selectedCategories => Set.unmodifiable(_selectedCategories);

  // Eco-tourism filter
  bool _ecoFriendlyOnly = false;
  bool get ecoFriendlyOnly => _ecoFriendlyOnly;

  // Rating filter
  double _minRating = 0;
  double get minRating => _minRating;

  // Sort options
  String _sortBy = 'recommended'; // 'recommended', 'price_low', 'price_high', 'rating'
  String get sortBy => _sortBy;

  // Featured/Hidden Gem filters
  bool _featuredOnly = false;
  bool _hiddenGemsOnly = false;
  bool get featuredOnly => _featuredOnly;
  bool get hiddenGemsOnly => _hiddenGemsOnly;

  // Active filter count
  int get activeFilterCount {
    int count = 0;
    if (_searchQuery.isNotEmpty) count++;
    if (_minPrice > 0 || _maxPrice < 500) count++;
    if (_selectedCategories.isNotEmpty) count++;
    if (_ecoFriendlyOnly) count++;
    if (_minRating > 0) count++;
    if (_featuredOnly) count++;
    if (_hiddenGemsOnly) count++;
    if (_sortBy != 'recommended') count++;
    return count;
  }

  // Update search query
  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  // Update price range
  void setPriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
  }

  // Toggle category
  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  // Set categories
  void setCategories(Set<String> categories) {
    _selectedCategories.clear();
    _selectedCategories.addAll(categories);
    notifyListeners();
  }

  // Toggle eco-friendly filter
  void toggleEcoFriendly() {
    _ecoFriendlyOnly = !_ecoFriendlyOnly;
    notifyListeners();
  }

  void setEcoFriendly(bool value) {
    _ecoFriendlyOnly = value;
    notifyListeners();
  }

  // Update minimum rating
  void setMinRating(double rating) {
    _minRating = rating;
    notifyListeners();
  }

  // Update sort option
  void setSortBy(String sortOption) {
    _sortBy = sortOption;
    notifyListeners();
  }

  // Set featured filter
  void setFeaturedOnly(bool value) {
    _featuredOnly = value;
    if (value) _hiddenGemsOnly = false;
    notifyListeners();
  }

  // Set hidden gems filter
  void setHiddenGemsOnly(bool value) {
    _hiddenGemsOnly = value;
    if (value) _featuredOnly = false;
    notifyListeners();
  }

  // Clear all filters
  void clearAllFilters() {
    _searchQuery = '';
    _minPrice = 0;
    _maxPrice = 500;
    _selectedCategories.clear();
    _ecoFriendlyOnly = false;
    _minRating = 0;
    _sortBy = 'recommended';
    _featuredOnly = false;
    _hiddenGemsOnly = false;
    notifyListeners();
  }

  // Filter services based on current filters
  List<Map<String, dynamic>> filterServices(List<Map<String, dynamic>> services) {
    var filtered = services.where((service) {
      // Search query filter
      if (_searchQuery.isNotEmpty) {
        final searchLower = _searchQuery.toLowerCase();
        final name = (service['name'] ?? '').toString().toLowerCase();
        final description = (service['description'] ?? '').toString().toLowerCase();
        final location = (service['location'] ?? '').toString().toLowerCase();
        final tags = (service['tags'] as List<String>?)?.join(' ').toLowerCase() ?? '';
        
        if (!name.contains(searchLower) && 
            !description.contains(searchLower) && 
            !location.contains(searchLower) &&
            !tags.contains(searchLower)) {
          return false;
        }
      }

      // Price range filter
      final price = (service['price'] ?? service['hourlyRate'] ?? service['pricePerNight'] ?? 0.0) as double;
      if (price < _minPrice || price > _maxPrice) {
        return false;
      }

      // Category filter
      if (_selectedCategories.isNotEmpty) {
        final category = service['category']?.toString() ?? '';
        if (!_selectedCategories.contains(category)) {
          return false;
        }
      }

      // Eco-friendly filter
      if (_ecoFriendlyOnly) {
        if (service['eco_friendly'] != true) {
          return false;
        }
      }

      // Rating filter
      final rating = (service['rating'] ?? 0.0) as double;
      if (rating < _minRating) {
        return false;
      }

      // Featured filter
      if (_featuredOnly) {
        if (service['featured'] != true) {
          return false;
        }
      }

      // Hidden gems filter
      if (_hiddenGemsOnly) {
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

  // Sort services
  List<Map<String, dynamic>> _sortServices(List<Map<String, dynamic>> services) {
    switch (_sortBy) {
      case 'price_low':
        services.sort((a, b) {
          final priceA = (a['price'] ?? a['hourlyRate'] ?? a['pricePerNight'] ?? 0.0) as double;
          final priceB = (b['price'] ?? b['hourlyRate'] ?? b['pricePerNight'] ?? 0.0) as double;
          return priceA.compareTo(priceB);
        });
        break;
      case 'price_high':
        services.sort((a, b) {
          final priceA = (a['price'] ?? a['hourlyRate'] ?? a['pricePerNight'] ?? 0.0) as double;
          final priceB = (b['price'] ?? b['hourlyRate'] ?? b['pricePerNight'] ?? 0.0) as double;
          return priceB.compareTo(priceA);
        });
        break;
      case 'rating':
        services.sort((a, b) {
          final ratingA = (a['rating'] ?? 0.0) as double;
          final ratingB = (b['rating'] ?? 0.0) as double;
          return ratingB.compareTo(ratingA);
        });
        break;
      case 'recommended':
      default:
        // Keep original order or implement custom recommendation logic
        break;
    }
    return services;
  }

  // Get price range label
  String getPriceRangeLabel() {
    if (_minPrice == 0 && _maxPrice == 500) {
      return 'All Prices';
    }
    return 'EGP ${_minPrice.toInt()} - ${_maxPrice.toInt()}';
  }

  // Get sort label
  String getSortLabel() {
    switch (_sortBy) {
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