import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/service_card.dart';
import 'package:siwa/widgets/unified_bottom_nav.dart';

class TouristHomeScreen extends StatelessWidget {
  const TouristHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: AppTheme.white,
            elevation: 0,
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF9500), Color(0xFFFFB143)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.beach_access, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Siwa Oasis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => context.go('/tourist_search'),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.search, color: AppTheme.primaryOrange),
                      SizedBox(width: 12),
                      Text(
                        'Where to?',
                        style: TextStyle(
                          color: AppTheme.gray,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Categories
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryChip(context, 'Accommodations', Icons.hotel, true, '/tourist_search'),
                  _buildCategoryChip(context, 'Transportation', Icons.directions_car, false, '/transportation'),
                  _buildCategoryChip(context, 'Attractions', Icons.attractions, false, '/attractions'),
                  _buildCategoryChip(context, 'Tours', Icons.tour, false, '/tour_guides'),
                  _buildCategoryChip(context, 'Food', Icons.restaurant, false, '/restaurants'),
                ],
              ),
            ),
          ),

          // Featured Section
SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Featured Experiences',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigate to search with featured filter
            context.push('/tourist_search?featured=true');
          },
          child: const Text(
            'See All',
            style: TextStyle(color: AppTheme.primaryOrange),
          ),
        ),
      ],
    ),
  ),
),

          // Featured Carousel
          SliverToBoxAdapter(
            child: SizedBox(
              height: 340,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 340,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.85,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  ServiceCard(
                    id: 'safari-1',
                    name: 'Desert Safari Adventure',
                    price: 80.0,
                    rating: 4.6,
                    description: 'Explore the vast golden dunes of Siwa desert with expert guides',
                    imageUrl: 'https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800',
                    reviews: 128,
                    isFeatured: true,
                    serviceType: 'tour',
                    onTap: () => context.push('/product_detail', extra: {
                      'id': 'safari-1',
                      'name': 'Desert Safari Adventure',
                      'price': 80.0,
                      'rating': 4.6,
                      'description': 'Explore the vast golden dunes of Siwa desert with expert guides. Experience the thrill of dune bashing, camel riding, and witness the breathtaking sunset over the endless desert landscape.',
                      'imageUrl': 'https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800',
                      'reviews': 128,
                      'serviceType': 'tour',
                    }),
                  ),
                  ServiceCard(
                    id: 'oasis-1',
                    name: 'Oasis Retreat & Spa',
                    price: 110.0,
                    rating: 4.8,
                    description: 'Relax in luxurious oasis accommodation with natural hot springs',
                    imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
                    reviews: 95,
                    isFeatured: true,
                    serviceType: 'hotel',
                    onTap: () => context.push('/product_detail', extra: {
                      'id': 'oasis-1',
                      'name': 'Oasis Retreat & Spa',
                      'price': 110.0,
                      'rating': 4.8,
                      'description': 'Relax in luxurious oasis accommodation with natural hot springs. Our eco-friendly resort offers traditional mud-brick architecture combined with modern amenities.',
                      'imageUrl': 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
                      'reviews': 95,
                      'serviceType': 'hotel',
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Hidden Gems Section
          SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Hidden Gems',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigate to search with hidden gems filter
            context.push('/tourist_search?hidden_gems=true');
          },
          child: const Text(
            'Discover More',
            style: TextStyle(color: AppTheme.primaryOrange),
          ),
        ),
      ],
    ),
  ),
),

          // Hidden Gems Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final gems = [
                    {
                      'id': 'pottery-1',
                      'name': 'Abo Ali\'s Pottery',
                      'price': 40.0,
                      'rating': 4.8,
                      'description': 'Traditional pottery workshop',
                      'imageUrl': 'https://images.unsplash.com/photo-1574737331253-33d0be6d1e7a?w=400',
                      'reviews': 23,
                      'serviceType': 'activity',
                    },
                    {
                      'id': 'weaving-1',
                      'name': 'Fatma\'s Weaving',
                      'price': 35.0,
                      'rating': 4.7,
                      'description': 'Handmade textile crafts',
                      'imageUrl': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
                      'reviews': 18,
                      'serviceType': 'activity',
                    },
                    {
                      'id': 'salt-therapy-1',
                      'name': 'Salt Lake Therapy',
                      'price': 25.0,
                      'rating': 4.9,
                      'description': 'Natural salt therapy sessions',
                      'imageUrl': 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
                      'reviews': 42,
                      'serviceType': 'activity',
                    },
                    {
                      'id': 'stargazing-1',
                      'name': 'Desert Stargazing',
                      'price': 55.0,
                      'rating': 4.8,
                      'description': 'Night sky observation tours',
                      'imageUrl': 'https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?w=400',
                      'reviews': 31,
                      'serviceType': 'tour',
                    },
                  ];
                  final gem = gems[index];
                  return ServiceCard(
                    id: gem['id'] as String,
                    name: gem['name'] as String,
                    price: gem['price'] as double,
                    rating: gem['rating'] as double,
                    description: gem['description'] as String,
                    imageUrl: gem['imageUrl'] as String,
                    reviews: gem['reviews'] as int,
                    serviceType: gem['serviceType'] as String,
                    onTap: () => context.push('/product_detail', extra: gem),
                  );
                },
                childCount: 4,
              ),
            ),
          ),

          // Bottom Spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),

      bottomNavigationBar: const UnifiedBottomNav(
        currentIndex: 0,
        type: NavBarType.tourist,
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String title, IconData icon, bool isSelected, String route) {
  return Container(
    margin: const EdgeInsets.only(right: 12),
    child: Material(
      color: isSelected ? AppTheme.primaryOrange : AppTheme.white,
      borderRadius: BorderRadius.circular(25),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          // Handle navigation based on category
          switch (title) {
            case 'Accommodations':
              context.push('/tourist_search'); // or '/accommodations' when list screen is ready
              break;
            case 'Transportation':
              context.push('/transportation');
              break;
            case 'Attractions':
              context.push('/attractions'); // when attractions list screen is ready
              break;
            case 'Tours':
              context.push('/tour_guides');
              break;
            case 'Food':
              context.push('/restaurants'); // when restaurants list screen is ready
              break;
            default:
              context.push('/tourist_search');
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : AppTheme.primaryOrange,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.gray,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}}