import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/service_card.dart';
import 'package:siwa/widgets/unified_bottom_nav.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/data/mock_data_repository_ar.dart';

class TouristHomeScreen extends StatelessWidget {
  const TouristHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect current locale
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    
    // Get data from appropriate repository based on locale
    final allOther = isArabic 
        ? MockDataRepositoryAr().getAllOther()
        : MockDataRepository().getAllOther();
    
    final featuredServices = allOther
        .where((item) => item['featured'] == true && item['category'] != 'challenge')
        .toList();
    
    final hiddenGems = allOther
        .where((item) => item['hidden_gem'] == true && item['category'] != 'challenge')
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
                    _t(context, 'app.name'),
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
                        _t(context, 'tourist.where_to'),
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
                reverse: isArabic, // Reverse for RTL
                children: [
                  _buildCategoryChip(
                    context,
                    _t(context, 'tourist.categories.accommodations'),
                    Icons.hotel,
                    true,
                    '/tourist_search',
                  ),
                  _buildCategoryChip(
                    context,
                    _t(context, 'tourist.categories.transportation'),
                    Icons.directions_car,
                    false,
                    '/transportation',
                  ),
                  _buildCategoryChip(
                    context,
                    _t(context, 'tourist.categories.attractions'),
                    Icons.attractions,
                    false,
                    '/attractions',
                  ),
                  _buildCategoryChip(
                    context,
                    _t(context, 'tourist.categories.tours'),
                    Icons.tour,
                    false,
                    '/tour_guides',
                  ),
                  _buildCategoryChip(
                    context,
                    _t(context, 'tourist.categories.food'),
                    Icons.restaurant,
                    false,
                    '/restaurants',
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
                    _t(context, 'tourist.featured_experiences'),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/tourist_search?featured=true');
                    },
                    child: Text(
                      _t(context, 'tourist.see_all'),
                      style: const TextStyle(color: AppTheme.primaryOrange),
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
              child: featuredServices.isEmpty
                  ? Center(
                      child: Text(_t(context, 'common.loading')),
                    )
                  : CarouselSlider(
                      options: CarouselOptions(
                        height: 340,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.85,
                        enableInfiniteScroll: featuredServices.length > 1,
                        autoPlay: featuredServices.length > 1,
                        autoPlayInterval: const Duration(seconds: 4),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        reverse: isArabic, // Reverse for RTL
                      ),
                      items: featuredServices.take(5).map((service) {
                        return ServiceCard(
                          id: service['id'].toString(),
                          name: service['name'] as String,
                          price: (service['price'] as num).toDouble(),
                          rating: (service['rating'] as num).toDouble(),
                          description: service['description'] as String,
                          imageUrl: service['imageUrl'] as String,
                          reviews: service['reviews'] as int,
                          isFeatured: true,
                          serviceType: service['category'] as String,
                          onTap: () => context.push(
                            '/product_detail',
                            extra: service,
                          ),
                        );
                      }).toList(),
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
                  Text(
                    _t(context, 'tourist.hidden_gems'),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/tourist_search?hidden_gems=true');
                    },
                    child: Text(
                      _t(context, 'tourist.discover_more'),
                      style: const TextStyle(color: AppTheme.primaryOrange),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Hidden Gems Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: hiddenGems.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(_t(context, 'common.loading')),
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
                          onTap: () => context.push('/product_detail', extra: gem),
                        );
                      },
                      childCount: hiddenGems.length > 4 ? 4 : hiddenGems.length,
                    ),
                  ),
          ),

          // Bottom Spacing
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),

      bottomNavigationBar: const UnifiedBottomNav(
        currentIndex: 0,
        type: NavBarType.tourist,
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

  // Translation helper - replace with your actual translation method
  String _t(BuildContext context, String key) {
    // TODO: Replace with your actual translation implementation
    // Example for easy_localization:
    // return context.tr(key);
    
    // Fallback: return last part of key
    return key.split('.').last;
  }
}