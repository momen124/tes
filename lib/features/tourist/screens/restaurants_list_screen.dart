import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';

class RestaurantsListScreen extends StatefulWidget {
  const RestaurantsListScreen({super.key});

  @override
  State<RestaurantsListScreen> createState() => _RestaurantsListScreenState();
}

class _RestaurantsListScreenState extends State<RestaurantsListScreen> {
  String _selectedCuisine = 'all';
  String _priceRange = 'all';
  
  final List<Map<String, dynamic>> _restaurants = [
    {
      'id': 1,
      'name': 'Aghurmi Restaurant',
      'cuisine': 'egyptian',
      'description': 'Authentic Siwan and Egyptian cuisine',
      'priceRange': 'medium',
      'rating': 4.7,
      'reviews': 234,
      'deliveryTime': '30-45 min',
      'minOrder': 50.0,
      'imageUrl': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
      'specialties': ['Siwan Dates', 'Tagine', 'Fresh Bread'],
      'openNow': true,
      'openingHours': '8:00 AM - 11:00 PM',
      'deliveryFee': 15.0,
    },
    {
      'id': 2,
      'name': 'Abdu\'s Kitchen',
      'cuisine': 'traditional',
      'description': 'Traditional Siwan home-cooked meals',
      'priceRange': 'low',
      'rating': 4.9,
      'reviews': 456,
      'deliveryTime': '20-30 min',
      'minOrder': 30.0,
      'imageUrl': 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800',
      'specialties': ['Siwan Pizza', 'Local Olives', 'Honey'],
      'openNow': true,
      'openingHours': '7:00 AM - 10:00 PM',
      'deliveryFee': 10.0,
    },
    {
      'id': 3,
      'name': 'Oasis Bistro',
      'cuisine': 'international',
      'description': 'International fusion with local ingredients',
      'priceRange': 'high',
      'rating': 4.6,
      'reviews': 189,
      'deliveryTime': '40-60 min',
      'minOrder': 100.0,
      'imageUrl': 'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=800',
      'specialties': ['Gourmet Burgers', 'Pasta', 'Steaks'],
      'openNow': true,
      'openingHours': '12:00 PM - 12:00 AM',
      'deliveryFee': 25.0,
    },
    {
      'id': 4,
      'name': 'Siwa Dates Café',
      'cuisine': 'cafe',
      'description': 'Specialty coffee and local date desserts',
      'priceRange': 'low',
      'rating': 4.8,
      'reviews': 345,
      'deliveryTime': '15-25 min',
      'minOrder': 25.0,
      'imageUrl': 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800',
      'specialties': ['Date Coffee', 'Pastries', 'Fresh Juice'],
      'openNow': true,
      'openingHours': '6:00 AM - 9:00 PM',
      'deliveryFee': 10.0,
    },
    {
      'id': 5,
      'name': 'Desert Grill House',
      'cuisine': 'grill',
      'description': 'Grilled meats and BBQ specialties',
      'priceRange': 'medium',
      'rating': 4.5,
      'reviews': 278,
      'deliveryTime': '35-50 min',
      'minOrder': 80.0,
      'imageUrl': 'https://images.unsplash.com/photo-1544025162-d76694265947?w=800',
      'specialties': ['Kebab', 'Kofta', 'Grilled Chicken'],
      'openNow': false,
      'openingHours': '5:00 PM - 12:00 AM',
      'deliveryFee': 20.0,
    },
    {
      'id': 6,
      'name': 'Palm Tree Restaurant',
      'cuisine': 'mediterranean',
      'description': 'Mediterranean flavors with Egyptian touch',
      'priceRange': 'medium',
      'rating': 4.7,
      'reviews': 312,
      'deliveryTime': '30-40 min',
      'minOrder': 60.0,
      'imageUrl': 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800',
      'specialties': ['Mezze Platter', 'Seafood', 'Salads'],
      'openNow': true,
      'openingHours': '11:00 AM - 11:00 PM',
      'deliveryFee': 15.0,
    },
  ];

  List<Map<String, dynamic>> get _filteredRestaurants {
    return _restaurants.where((restaurant) {
      final cuisineMatch = _selectedCuisine == 'all' || restaurant['cuisine'] == _selectedCuisine;
      final priceMatch = _priceRange == 'all' || restaurant['priceRange'] == _priceRange;
      return cuisineMatch && priceMatch;
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
        title: const Text('Restaurants'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Cuisine Filter
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildCuisineChip('All', 'all', Icons.restaurant),
                      _buildCuisineChip('Egyptian', 'egyptian', Icons.food_bank),
                      _buildCuisineChip('Traditional', 'traditional', Icons.local_dining),
                      _buildCuisineChip('International', 'international', Icons.public),
                      _buildCuisineChip('Café', 'cafe', Icons.local_cafe),
                      _buildCuisineChip('Grill', 'grill', Icons.outdoor_grill),
                      _buildCuisineChip('Mediterranean', 'mediterranean', Icons.set_meal),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text('Price: ', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 8),
                      _buildPriceFilter('All', 'all'),
                      _buildPriceFilter('Budget', 'low'),
                      _buildPriceFilter('Medium', 'medium'),
                      _buildPriceFilter('Fine Dining', 'high'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Restaurants List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = _filteredRestaurants[index];
                return _buildRestaurantCard(restaurant);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const TouristBottomNav(currentIndex: 1),
    );
  }

  Widget _buildCuisineChip(String label, String value, IconData icon) {
    final isSelected = _selectedCuisine == value;
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
          setState(() => _selectedCuisine = value);
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

  Widget _buildPriceFilter(String label, String value) {
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

  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          _showRestaurantMenu(restaurant);
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Status Badge
            Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: NetworkImage(restaurant['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (restaurant['openNow'])
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.successGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time, size: 12, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Open Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.errorRed,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Closed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
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
                          restaurant['rating'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          restaurant['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildPriceIndicator(restaurant['priceRange']),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  Text(
                    restaurant['description'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.gray,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Info Row
                  Row(
                    children: [
                      const Icon(Icons.delivery_dining, size: 16, color: AppTheme.gray),
                      const SizedBox(width: 4),
                      Text(
                        '${restaurant['deliveryTime']} • ',
                        style: const TextStyle(fontSize: 13, color: AppTheme.gray),
                      ),
                      const Icon(Icons.payments, size: 16, color: AppTheme.gray),
                      const SizedBox(width: 4),
                      Text(
                        'Min EGP ${restaurant['minOrder'].toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 13, color: AppTheme.gray),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Specialties
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (restaurant['specialties'] as List<String>)
                        .take(3)
                        .map((specialty) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.lightBlueGray,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                specialty,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.darkGray,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceIndicator(String priceRange) {
    int count;
    switch (priceRange) {
      case 'low':
        count = 1;
        break;
      case 'medium':
        count = 2;
        break;
      case 'high':
        count = 3;
        break;
      default:
        count = 1;
    }
    
    return Row(
      children: List.generate(
        3,
        (index) => Text(
          'EGP',
          style: TextStyle(
            fontSize: 12,
            color: index < count ? AppTheme.primaryOrange : AppTheme.gray,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showRestaurantMenu(Map<String, dynamic> restaurant) {
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
              // Header Image
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage(restaurant['imageUrl']),
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
              
              // Restaurant Info
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            restaurant['name'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: restaurant['openNow'] ? AppTheme.successGreen : AppTheme.errorRed,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            restaurant['openNow'] ? 'Open' : 'Closed',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppTheme.primaryOrange, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${restaurant['rating']} (${restaurant['reviews']} reviews)',
                          style: const TextStyle(fontSize: 14, color: AppTheme.gray),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    Text(
                      restaurant['description'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    
                    // Delivery Info
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoBox(
                            Icons.delivery_dining,
                            'Delivery',
                            restaurant['deliveryTime'],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoBox(
                            Icons.payments,
                            'Min Order',
                            'EGP ${restaurant['minOrder'].toStringAsFixed(0)}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoBox(
                            Icons.local_shipping,
                            'Delivery Fee',
                            'EGP ${restaurant['deliveryFee'].toStringAsFixed(0)}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoBox(
                            Icons.schedule,
                            'Hours',
                            restaurant['openingHours'],
                          ),
                        ),
                      ],
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
                      children: (restaurant['specialties'] as List<String>)
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
                    
                    // Order Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: restaurant['openNow']
                            ? () {
                                Navigator.pop(context);
                                context.push(
                                  '/booking_form?type=restaurant',
                                  extra: {'serviceData': restaurant},
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryOrange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'View Menu & Order',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.gray,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
