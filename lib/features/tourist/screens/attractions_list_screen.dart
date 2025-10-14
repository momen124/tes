import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

class AttractionsListScreen extends StatefulWidget {
  const AttractionsListScreen({super.key});

  @override
  State<AttractionsListScreen> createState() => _AttractionsListScreenState();
}

class _AttractionsListScreenState extends State<AttractionsListScreen> {
  String _selectedCategory = 'all';
  
  final List<Map<String, dynamic>> _attractions = [
    {
      'id': 1,
      'name': 'Temple of the Oracle',
      'category': 'historical',
      'description': 'Ancient temple where Alexander the Great consulted the oracle',
      'price': 50.0,
      'duration': '2 hours',
      'rating': 4.8,
      'reviews': 456,
      'imageUrl': 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=800',
      'location': 'Aghurmi Village',
      'highlights': ['Ancient ruins', 'Historical significance', 'Photo opportunity'],
      'openingHours': '8:00 AM - 5:00 PM',
      'difficulty': 'Easy',
    },
    {
      'id': 2,
      'name': 'Siwa Salt Lakes',
      'category': 'nature',
      'description': 'Crystal-clear salt lakes with therapeutic properties',
      'price': 30.0,
      'duration': '3 hours',
      'rating': 4.9,
      'reviews': 789,
      'imageUrl': 'https://visitegypt.com/wp-content/uploads/2025/07/the-salt-lake-siwa-oasis.webp',
      'location': 'Birket Siwa',
      'highlights': ['Swimming', 'Floating experience', 'Sunset views'],
      'openingHours': '24/7',
      'difficulty': 'Easy',
    },
    {
      'id': 3,
      'name': 'Shali Fortress',
      'category': 'historical',
      'description': 'Ancient mud-brick fortress with panoramic oasis views',
      'price': 25.0,
      'duration': '1.5 hours',
      'rating': 4.6,
      'reviews': 324,
      'imageUrl': 'https://images.unsplash.com/photo-1548013146-72479768bada?w=800',
      'location': 'Siwa Town Center',
      'highlights': ['Architecture', 'City views', 'Sunset spot'],
      'openingHours': '8:00 AM - 6:00 PM',
      'difficulty': 'Moderate',
    },
    {
      'id': 4,
      'name': 'Cleopatra\'s Bath',
      'category': 'nature',
      'description': 'Natural spring pool with crystal-clear water',
      'price': 20.0,
      'duration': '2 hours',
      'rating': 4.7,
      'reviews': 612,
      'imageUrl': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
      'location': 'Near Siwa Town',
      'highlights': ['Swimming', 'Natural spring', 'Relaxation'],
      'openingHours': '7:00 AM - 7:00 PM',
      'difficulty': 'Easy',
    },
    {
      'id': 5,
      'name': 'Great Sand Sea Safari',
      'category': 'adventure',
      'description': 'Thrilling 4x4 desert adventure through massive dunes',
      'price': 200.0,
      'duration': '6 hours',
      'rating': 4.9,
      'reviews': 234,
      'imageUrl': 'https://www.kemetexperience.com/wp-content/uploads/2019/09/incredible-white-desert-960x636.jpg',
      'location': 'Western Desert',
      'highlights': ['Sandboarding', 'Dune bashing', 'Desert camping'],
      'openingHours': 'By appointment',
      'difficulty': 'Challenging',
    },
    {
      'id': 6,
      'name': 'Fatnas Island Sunset',
      'category': 'nature',
      'description': 'Peaceful palm-covered island perfect for sunset viewing',
      'price': 15.0,
      'duration': '2 hours',
      'rating': 4.8,
      'reviews': 445,
      'imageUrl': 'https://www.heatheronhertravels.com/wp-content/uploads/2011/09/Sunset-at-Fatnas-Island-in-Siwa-in-Egypt-2.jpg.webp',
      'location': 'Birket Siwa',
      'highlights': ['Sunset views', 'Picnic spot', 'Bird watching'],
      'openingHours': '4:00 PM - 7:00 PM',
      'difficulty': 'Easy',
    },
    {
      'id': 7,
      'name': 'Mountain of the Dead',
      'category': 'historical',
      'description': 'Ancient necropolis with well-preserved tomb paintings',
      'price': 40.0,
      'duration': '1.5 hours',
      'rating': 4.5,
      'reviews': 267,
      'imageUrl': 'https://images.unsplash.com/photo-1503756234508-e32369269deb?w=800',
      'location': 'Gebel al-Mawta',
      'highlights': ['Ancient tombs', 'Wall paintings', 'History'],
      'openingHours': '8:00 AM - 5:00 PM',
      'difficulty': 'Moderate',
    },
    {
      'id': 8,
      'name': 'Siwa House Museum',
      'category': 'culture',
      'description': 'Traditional Siwan house showcasing local culture and crafts',
      'price': 35.0,
      'duration': '1 hour',
      'rating': 4.4,
      'reviews': 189,
      'imageUrl': 'https://images.unsplash.com/photo-1565711561500-691d9ec04506?w=800',
      'location': 'Siwa Town',
      'highlights': ['Traditional architecture', 'Local crafts', 'Cultural insight'],
      'openingHours': '9:00 AM - 4:00 PM',
      'difficulty': 'Easy',
    },
  ];

  List<Map<String, dynamic>> get _filteredAttractions {
    if (_selectedCategory == 'all') {
      return _attractions;
    }
    return _attractions.where((attraction) => attraction['category'] == _selectedCategory).toList();
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
        title: Text('Attractions & Tours'.tr()),
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
                  _buildCategoryChip('Historical', 'historical', Icons.account_balance),
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
              padding: const EdgeInsets.all(16),
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
      bottomNavigationBar: const TouristBottomNav(currentIndex: 1),
    );
  }

  Widget _buildCategoryChip(String label, String value, IconData icon) {
    final isSelected = _selectedCategory == value;
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: AppTheme.primaryOrange, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          attraction['rating'].toString(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        const Icon(Icons.access_time, size: 12, color: AppTheme.gray),
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
                          'EGP ${attraction['price'].toStringAsFixed(0)}',
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
              // Image
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                        const Icon(Icons.star, color: AppTheme.primaryOrange, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${attraction['rating']} (${attraction['reviews']} reviews)',
                          style: const TextStyle(fontSize: 14, color: AppTheme.gray),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    Text(
                      attraction['description'],
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    
                    // Info Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(Icons.access_time, 'Duration', attraction['duration']),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoCard(Icons.fitness_center, 'Difficulty', attraction['difficulty']),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(Icons.location_on, 'Location', attraction['location']),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoCard(Icons.schedule, 'Hours', attraction['openingHours']),
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
                    ...(attraction['highlights'] as List<String>).map(
                      (highlight) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: AppTheme.successGreen, size: 20),
                            const SizedBox(width: 8),
                            Text(highlight, style: const TextStyle(fontSize: 15)),
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
                          'Book for EGP ${attraction['price'].toStringAsFixed(0)}',
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
