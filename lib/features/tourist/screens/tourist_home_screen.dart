import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/service_card.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/data/mock_data_repository_ar.dart';
import 'package:easy_localization/easy_localization.dart';

/// ---------------------------------------------------------------
/// Defensive-programming helpers
/// ---------------------------------------------------------------
String? safeString(dynamic v) => v is String 
    ? v.trim() 
    : (v != null ? v.toString().trim() : null);double? safeDouble(dynamic v) => v is num ? v.toDouble() : null;
int? safeInt(dynamic v) => v is int
    ? v
    : (v is double ? v.toInt() : null);

/// ---------------------------------------------------------------
/// Safe image widget (404, loading, invalid URLs)
/// ---------------------------------------------------------------
Widget buildSafeImage(
  String? url, {
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  BorderRadius? borderRadius,
}) {
  final String imageUrl = url?.trim() ?? '';
  final bool valid = imageUrl.isNotEmpty &&
      (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'));

  if (!valid) {
    return _placeholder(
        width: width, height: height, borderRadius: borderRadius);
  }

  return ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.circular(12),
    child: Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (c, child, progress) =>
          progress == null ? child : _placeholder(
              width: width,
              height: height,
              borderRadius: borderRadius,
              loading: true),
      errorBuilder: (c, e, s) {
        debugPrint('Image error: $imageUrl → $e');
        return _placeholder(width: width, height: height, borderRadius: borderRadius);
      },
    ),
  );
}

Widget _placeholder({
  double? width,
  double? height,
  BorderRadius? borderRadius,
  bool loading = false,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: AppTheme.lightBlueGray.withOpacity(0.6),
      borderRadius: borderRadius ?? BorderRadius.circular(12),
    ),
    child: Center(
      child: loading
          ? const CircularProgressIndicator(
              color: AppTheme.primaryOrange, strokeWidth: 2)
          : const Icon(Icons.image_not_supported_outlined,
              color: Colors.grey, size: 28),
    ),
  );
}

/// ---------------------------------------------------------------
/// TouristHomeScreen – fully defensive
/// ---------------------------------------------------------------
class TouristHomeScreen extends StatelessWidget {
  const TouristHomeScreen({super.key});

  // -----------------------------------------------------------------
  // Category chip (unchanged)
  // -----------------------------------------------------------------
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
                Icon(icon,
                    size: 18,
                    color: isSelected ? Colors.white : AppTheme.primaryOrange),
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

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    // -----------------------------------------------------------------
    // Load mock data (language-aware)
    // -----------------------------------------------------------------
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

    // -----------------------------------------------------------------
    // Featured experiences (only items that have id + name)
    // -----------------------------------------------------------------
    final List<Map<String, dynamic>> featuredExperiences = [];

    for (var h in hotels.take(3)) {
      if (safeString(h['id']) != null && safeString(h['name']) != null) {
        featuredExperiences
            .add({...h, 'category': 'accommodation', 'featured': true});
      }
    }
    for (var r in restaurants.take(3)) {
      if (safeString(r['id']) != null && safeString(r['name']) != null) {
        featuredExperiences
            .add({...r, 'category': 'restaurant', 'featured': true});
      }
    }
    for (var a in attractions.take(3)) {
      if (safeString(a['id']) != null && safeString(a['name']) != null) {
        featuredExperiences
            .add({...a, 'category': 'attraction', 'featured': true});
      }
    }

    // -----------------------------------------------------------------
    // Hidden gems (filter + safety)
    // -----------------------------------------------------------------
    final hiddenGems = allServices
        .where((item) =>
            item['hidden_gem'] == true &&
            item['category'] != 'challenge' &&
            safeString(item['id']) != null &&
            safeString(item['name']) != null)
        .take(8)
        .toList();

    // -----------------------------------------------------------------
    // UI
    // -----------------------------------------------------------------
    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      body: CustomScrollView(
        slivers: [
          // ------------------- AppBar -------------------
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
                    child: const Icon(Icons.beach_access,
                        color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Text('app.name'.tr(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
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

          // ------------------- Search bar -------------------
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
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      const Icon(Icons.search, color: AppTheme.primaryOrange),
                      const SizedBox(width: 12),
                      Text('tourist.where_to'.tr(),
                          style: const TextStyle(
                              color: AppTheme.gray, fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ------------------- Categories -------------------
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                reverse: isArabic,
                children: [
                  _buildCategoryChip(context, 'accommodations'.tr(),
                      Icons.hotel, false, '/accommodations'),
                  _buildCategoryChip(context, 'transportation'.tr(),
                      Icons.directions_car, false, '/transportation'),
                  _buildCategoryChip(context, 'attractions'.tr(),
                      Icons.attractions, false, '/attractions'),
                  _buildCategoryChip(
                      context, 'tours'.tr(), Icons.tour, false, '/tours'),
                  _buildCategoryChip(context, 'food'.tr(),
                      Icons.restaurant, false, '/restaurants'),
                  _buildCategoryChip(context, 'services'.tr(),
                      Icons.medical_services, false, '/services'),
                ],
              ),
            ),
          ),

          // ------------------- Featured title -------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('tourist.featured_experiences'.tr(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () =>
                        context.push('/tourist_search?featured=true'),
                    child: Text('tourist.see_all'.tr(),
                        style:
                            const TextStyle(color: AppTheme.primaryOrange)),
                  ),
                ],
              ),
            ),
          ),

          // ------------------- Featured carousel -------------------
          SliverToBoxAdapter(
            child: SizedBox(
              height: 340,
              child: featuredExperiences.isEmpty
                  ? Center(child: Text('common.loading'.tr()))
                  : CarouselSlider(
                      options: CarouselOptions(
                        height: 320,
                        viewportFraction: 0.85,
                        enableInfiniteScroll:
                            featuredExperiences.length > 1,
                        autoPlay: featuredExperiences.length > 1,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        reverse: isArabic,
                      ),
                      items: featuredExperiences.map((service) {
                        // ----- clean map for navigation -----
                        final clean = Map<String, dynamic>.from(service);
                        clean.removeWhere((k, v) => v == null);

                        return ServiceCard(
                          id: safeString(service['id']) ?? '0',
                          name: safeString(service['name']) ?? 'Unknown',
                          price: safeDouble(service['price']) ??
                              safeDouble(service['pricePerNight']) ??
                              0.0,
                          rating: safeDouble(service['rating']) ?? 0.0,
                          description:
                              safeString(service['description']) ?? '',
                          imageUrl: safeString(service['imageUrl']) ?? '',
                          reviews: safeInt(service['reviews']) ?? 0,
                          isFeatured: true,
                          serviceType:
                              safeString(service['category']) ?? 'service',
                          
                          onTap: () =>
                              context.push('/service_detail', extra: clean),
                        );
                      }).toList(),
                    ),
            ),
          ),

  // ------------------- Hidden gems title -------------------
SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.fromLTRB(16, 5, 12, 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('tourist.hidden_gems'.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        TextButton(
          onPressed: () => context.push('/tourist_search?hidden_gems=true'),
          child: Text('tourist.discover_more'.tr(),
              style: const TextStyle(color: AppTheme.primaryOrange)),
        ),
      ],
    ),
  ),
),

// ------------------- Hidden gems grid -------------------
SliverPadding(
  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
  sliver: hiddenGems.isEmpty
      ? SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                'No hidden gems found.',
                style: TextStyle(color: AppTheme.gray, fontSize: 16),
              ),
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
              final clean = Map<String, dynamic>.from(gem)..removeWhere((k, v) => v == null);

              return ServiceCard(
                id: safeString(gem['id']) ?? '0',
                name: safeString(gem['name']) ?? 'Unknown',
                price: safeDouble(gem['price']) ?? 0.0,
                rating: safeDouble(gem['rating']) ?? 0.0,
                description: safeString(gem['description']) ?? '',
                imageUrl: safeString(gem['imageUrl']) ?? '',
                reviews: safeInt(gem['reviews']) ?? 0,
                serviceType: safeString(gem['category']) ?? 'service',
                isFeatured: false,
                // imageBuilder: (_) => buildSafeImage(
                //   safeString(gem['imageUrl']),
                //   width: double.infinity,
                //   height: 140,
                //   borderRadius: BorderRadius.circular(12),
                // ),
                onTap: () => context.push('/service_detail', extra: clean),
              );
            },
            childCount: hiddenGems.length,  // ← Just use length
          ),
        ),
),
        ],
      ),
      bottomNavigationBar:
          const SafeArea(child: TouristBottomNav(currentIndex: 0)),
    );
  }
}