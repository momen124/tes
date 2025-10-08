// lib/features/tourist/screens/tourist_home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/service_card.dart';

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
                    child: const Icon(Icons.palm_tree, color: Colors.white, size: 24),
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
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Where to?',
                    hintStyle: TextStyle(color: AppTheme.gray),
                    prefixIcon: Icon(Icons.search, color: AppTheme.primaryOrange),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  _buildCategoryChip('Accommodations', Icons.hotel, true),
                  _buildCategoryChip('Transportation', Icons.directions_car, false),
                  _buildCategoryChip('Attractions', Icons.attractions, false),
                  _buildCategoryChip('Tours', Icons.tour, false),
                  _buildCategoryChip('Food', Icons.restaurant, false),
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
                    onPressed: () {},
                    child: Text(
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
              height: 220,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 220,
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
                    name: 'Desert Safari Adventure',
                    price: 80.0,
                    rating: 4.6,
                    description: 'Explore the vast golden dunes of Siwa desert with expert guides',
                    imageUrl: 'https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=800',
                    reviews: 128,
                    isFeatured: true,
                  ),
                  ServiceCard(
                    name: 'Oasis Retreat & Spa',
                    price: 110.0,
                    rating: 4.8,
                    description: 'Relax in luxurious oasis accommodation with natural hot springs',
                    imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
                    reviews: 95,
                    isFeatured: true,
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
                    onPressed: () {},
                    child: Text(
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
                      'name': 'Abo Ali\'s Pottery',
                      'price': 40.0,
                      'rating': 4.8,
                      'description': 'Traditional pottery workshop',
                      'imageUrl': 'https://images.unsplash.com/photo-1574737331253-33d0be6d1e7a?w=400',
                      'reviews': 23,
                    },
                    {
                      'name': 'Fatma\'s Weaving',
                      'price': 35.0,
                      'rating': 4.7,
                      'description': 'Handmade textile crafts',
                      'imageUrl': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
                      'reviews': 18,
                    },
                    {
                      'name': 'Salt Lake Therapy',
                      'price': 25.0,
                      'rating': 4.9,
                      'description': 'Natural salt therapy sessions',
                      'imageUrl': 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
                      'reviews': 42,
                    },
                    {
                      'name': 'Desert Stargazing',
                      'price': 55.0,
                      'rating': 4.8,
                      'description': 'Night sky observation tours',
                      'imageUrl': 'https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?w=400',
                      'reviews': 31,
                    },
                  ];
                  final gem = gems[index];
                  return ServiceCard(
                    name: gem['name'] as String,
                    price: gem['price'] as double,
                    rating: gem['rating'] as double,
                    description: gem['description'] as String,
                    imageUrl: gem['imageUrl'] as String,
                    reviews: gem['reviews'] as int,
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

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: AppTheme.primaryOrange,
            unselectedItemColor: AppTheme.gray,
            backgroundColor: AppTheme.white,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_outlined),
                activeIcon: Icon(Icons.camera_alt),
                label: 'Challenges',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                activeIcon: Icon(Icons.bookmark),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 1:
                  context.go('/tourist_search');
                  break;
                case 2:
                  context.go('/tourist_challenges');
                  break;
                case 3:
                  context.go('/tourist_bookings');
                  break;
                case 4:
                  context.go('/tourist_profile');
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String title, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Material(
        color: isSelected ? AppTheme.primaryOrange : AppTheme.white,
        borderRadius: BorderRadius.circular(25),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {},
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
  }
}