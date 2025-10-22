import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/service_card.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/data/mock_data_repository_ar.dart';
import 'package:easy_localization/easy_localization.dart';

class TouristHomeScreen extends StatelessWidget {
  const TouristHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    // Get data from repositories
    final hotels = isArabic 
        ? MockDataRepositoryAr().getAllHotels() 
        : MockDataRepository().getAllHotels();
    
    final restaurants = isArabic 
        ? MockDataRepositoryAr().getAllRestaurants() 
        : MockDataRepository().getAllRestaurants();
    
    final attractions = isArabic 
        ? MockDataRepositoryAr().getAllAttractions() 
        : MockDataRepository().getAllAttractions();

    final allServices = isArabic
        ? MockDataRepositoryAr().getAllFeaturedServices()
        : MockDataRepository().getAllFeaturedServices();

    // Create featured experiences from all sources
    final List<Map<String, dynamic>> featuredExperiences = [];
    
    // Add featured hotels (all hotels as featured)
    for (var hotel in hotels.take(3)) {
      featuredExperiences.add({
        ...hotel,
        'category': 'accommodation',
        'featured': true,
      });
    }
    
    // Add featured restaurants (top rated)
    for (var restaurant in restaurants.take(3)) {
      featuredExperiences.add({
        ...restaurant,
        'category': 'restaurant',
        'featured': true,
      });
    }
    
    // Add featured attractions (top rated)
    for (var attraction in attractions.take(3)) {
      featuredExperiences.add({
        ...attraction,
        'category': 'attraction',
        'featured': true,
      });
    }

    // Hidden Gems - Get from all sources
    final hiddenGems = allServices
        .where((item) => item['hidden_gem'] == true && item['category'] != 'challenge')
        .take(8)
        .toList();

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
                    child: const Icon(
                      Icons.beach_access,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'app.name'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              centerTitle: false,
              titlePadding: EdgeInsets.only(
                left: isArabic ? 0 : 16,
                right: isArabic ? 16 : 0,
                bottom: 16,
              ),
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
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      const Icon(Icons.search, color: AppTheme.primaryOrange),
                      const SizedBox(width: 12),
                      Text(
                        'tourist.where_to'.tr(),
                        style: const TextStyle(color: AppTheme.gray, fontSize: 16),
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
                reverse: isArabic,
                children: [
                  _buildCategoryChip(
                    context,
                    'accommodations'.tr(),
                    Icons.hotel,
                    false,
                    '/accommodations',
                  ),
                  _buildCategoryChip(
                    context,
                    'transportation'.tr(),
                    Icons.directions_car,
                    false,
                    '/transportation',
                  ),
                  _buildCategoryChip(
                    context,
                    'attractions'.tr(),
                    Icons.attractions,
                    false,
                    '/attractions',
                  ),
                  _buildCategoryChip(
                    context,
                    'tours'.tr(),
                    Icons.tour,
                    false,
                    '/tours',
                  ),
                  _buildCategoryChip(
                    context,
                    'food'.tr(),
                    Icons.restaurant,
                    false,
                    '/restaurants',
                  ),
                  _buildCategoryChip(
                    context,
                    'services'.tr(),
                    Icons.medical_services,
                    false,
                    '/services',
                  ),
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
                  Text(
                    'tourist.featured_experiences'.tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => context.push('/tourist_search?featured=true'),
                    child: Text(
                      'tourist.see_all'.tr(),
                      style: const TextStyle(color: AppTheme.primaryOrange),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Featured Carousel - IMPROVED
          SliverToBoxAdapter(
            child: SizedBox(
              height: 340,
              child: featuredExperiences.isEmpty
                  ? Center(child: Text('common.loading'.tr()))
                  : CarouselSlider(
                      options: CarouselOptions(
                        height: 320,
                        viewportFraction: 0.85,
                        enableInfiniteScroll: featuredExperiences.length > 1,
                        autoPlay: featuredExperiences.length > 1,
                        autoPlayInterval: const Duration(seconds: 5),  // Increased from 4 to 5
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        reverse: isArabic,
                      ),
                      items: featuredExperiences.map((service) {
                        return ServiceCard(
                          id: service['id']?.toString() ?? '0',
                          name: service['name'] as String? ?? 'Unknown',
                          price: (service['price'] as num?)?.toDouble() ?? (service['pricePerNight'] as num?)?.toDouble() ?? 0.0,
                          rating: (service['rating'] as num?)?.toDouble() ?? 0.0,
                          description: service['description'] as String? ?? '',
                          imageUrl: service['imageUrl'] as String? ?? '',
                          reviews: service['reviews'] as int? ?? 0,
                          isFeatured: true,
                          serviceType: service['category'] as String? ?? 'service',
                          onTap: () => context.push('/service_detail', extra: service),
                        );
                      }).toList(),
                    ),
            ),
          ),

          // Hidden Gems Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 12, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'tourist.hidden_gems'.tr(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => context.push('/tourist_search?hidden_gems=true'),
                    child: Text(
                      'tourist.discover_more'.tr(),
                      style: const TextStyle(color: AppTheme.primaryOrange),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Hidden Gems Grid - SHOW MORE ITEMS
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            sliver: hiddenGems.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text('common.loading'.tr()),
                      ),
                    ),
                  )
                : SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final gem = hiddenGems[index];
                        return ServiceCard(
                          id: gem['id'].toString(),
                          name: gem['name'] as String,
                          price: (gem['price'] as num).toDouble(),
                          rating: (gem['rating'] as num).toDouble(),
                          description: gem['description'] as String,
                          imageUrl: gem['imageUrl'] as String,
                          reviews: gem['reviews'] as int,
                          serviceType: gem['category'] as String,
                          onTap: () => context.push('/service_detail', extra: gem),
                        );
                      },
                      childCount: hiddenGems.length > 6 ? 6 : hiddenGems.length,  // Increased from 4 to 6
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const SafeArea(
        child: TouristBottomNav(currentIndex: 0),
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    String title,
    IconData icon,
    bool isSelected,
    String route,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Material(
        color: isSelected ? AppTheme.primaryOrange : AppTheme.white,
        borderRadius: BorderRadius.circular(25),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () => context.push(route),
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