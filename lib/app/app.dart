import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/tourist/screens/splash_screen.dart';
import '../features/tourist/screens/tourist_home_screen.dart';
import '../features/tourist/screens/tourist_bookings_screen.dart';
import '../features/tourist/screens/tourist_challenges_screen.dart';
import '../features/tourist/screens/tourist_profile_screen.dart';
import '../features/tourist/screens/tourist_search_screen.dart';
import '../features/tourist/screens/booking_form_screen.dart';
import '../features/tourist/screens/product_detail_screen.dart';
import '../features/tourist/screens/service_detail_screen.dart';
import '../features/tourist/screens/siwa_info_screen.dart';
import '../features/tourist/screens/transportation_list_screen.dart';
import '../features/tourist/screens/attractions_list_screen.dart';
import '../features/tourist/screens/restaurants_list_screen.dart';
import '../features/tourist/screens/tour_guides_list_screen.dart';
import '../features/business/screens/business_app_main.dart';
import '../features/admin/screens/admin_dashboard_screen.dart';
import '../features/admin/screens/admin_logs_screen.dart';
import '../features/admin/screens/admin_moderation_screen.dart';
import 'theme.dart';
import '../features/business/models/business_type.dart';
import '../features/common/screens/debug_navigator_screen.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        final userType = state.uri.queryParameters['type'] ?? 'tourist';
        return RegisterScreen(userType: userType);
      },
    ),
    GoRoute(path: '/tourist_home', builder: (context, state) => const TouristHomeScreen()),
    GoRoute(path: '/tourist_bookings', builder: (context, state) => const TouristBookingsScreen()),
    GoRoute(path: '/tourist_challenges', builder: (context, state) => const TouristChallengesScreen()),
    GoRoute(path: '/tourist_profile', builder: (context, state) => const TouristProfileScreen()),
    GoRoute(path: '/tourist_search', builder: (context, state) => const TouristSearchScreen()),
    GoRoute(
      path: '/booking_form',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final serviceData = extra?['serviceData'] as Map<String, dynamic>? ?? {};
        return BookingFormScreen(
          serviceName: serviceData['name']?.toString() ?? 'Unknown Service',
          serviceType: state.uri.queryParameters['type'] ?? 'default',
          basePrice: (serviceData['price'] as num?)?.toDouble() ?? 0.0,
          imageUrl: serviceData['imageUrl']?.toString(),
        );
      },
    ),
    GoRoute(
      path: '/debug_navigator',
      builder: (context, state) => const DebugNavigatorScreen(),
    ),
    GoRoute(path: '/product_detail', builder: (context, state) => const ProductDetailScreen()),
    GoRoute(path: '/service_detail', builder: (context, state) => const ServiceDetailScreen()),
    GoRoute(path: '/siwa_info', builder: (context, state) => const SiwaInfoScreen()),
    GoRoute(
      path: '/transportation',
      builder: (context, state) => const TransportationListScreen(),
    ),
    GoRoute(
      path: '/attractions',
      builder: (context, state) => const AttractionsListScreen(),
    ),
    GoRoute(
      path: '/restaurants',
      builder: (context, state) => const RestaurantsListScreen(),
    ),
    GoRoute(
      path: '/tour_guides',
      builder: (context, state) => const TourGuidesListScreen(),
    ),
    GoRoute(
      path: '/business_dashboard',
      builder: (context, state) {
        final businessType = state.uri.queryParameters['type'] ?? 'hotel';
        final type = BusinessType.values.firstWhere(
          (e) => e.name == businessType,
          orElse: () => BusinessType.hotel,
        );
        return BusinessAppMain(
          businessType: type,
          onBack: () => context.go('/login'),
        );
      },
    ),
    GoRoute(
      path: '/business_listings',
      builder: (context, state) {
        final businessType = state.uri.queryParameters['type'] ?? 'hotel';
        final type = BusinessType.values.firstWhere(
          (e) => e.name == businessType,
          orElse: () => BusinessType.hotel,
        );
        return BusinessAppMain(
          businessType: type,
          onBack: () => context.go('/login'),
        );
      },
    ),
    GoRoute(
      path: '/business_profile',
      builder: (context, state) {
        final businessType = state.uri.queryParameters['type'] ?? 'hotel';
        final type = BusinessType.values.firstWhere(
          (e) => e.name == businessType,
          orElse: () => BusinessType.hotel,
        );
        return BusinessAppMain(
          businessType: type,
          onBack: () => context.go('/login'),
        );
      },
    ),
    GoRoute(
      path: '/hotel_management',
      builder: (context, state) {
        return BusinessAppMain(
          businessType: BusinessType.hotel,
          onBack: () => context.go('/business_dashboard?type=hotel'),
        );
      },
    ),
    GoRoute(
      path: '/rental_fleet',
      builder: (context, state) {
        return BusinessAppMain(
          businessType: BusinessType.rental,
          onBack: () => context.go('/business_dashboard?type=rental'),
        );
      },
    ),
    GoRoute(
      path: '/route_management',
      builder: (context, state) {
        return BusinessAppMain(
          businessType: BusinessType.transportation,
          onBack: () => context.go('/business_dashboard?type=transportation'),
        );
      },
    ),
    GoRoute(
      path: '/trip_itinerary',
      builder: (context, state) {
        return BusinessAppMain(
          businessType: BusinessType.tripBooking,
          onBack: () => context.go('/business_dashboard?type=tripBooking'),
        );
      },
    ),
    GoRoute(
      path: '/menu_management',
      builder: (context, state) {
        return BusinessAppMain(
          businessType: BusinessType.restaurant,
          onBack: () => context.go('/business_dashboard?type=restaurant'),
        );
      },
    ),
    GoRoute(
      path: '/store_inventory',
      builder: (context, state) {
        return BusinessAppMain(
          businessType: BusinessType.store,
          onBack: () => context.go('/business_dashboard?type=store'),
        );
      },
    ),
    GoRoute(
      path: '/guide_schedule',
      builder: (context, state) {
        return BusinessAppMain(
          businessType: BusinessType.tourGuide,
          onBack: () => context.go('/business_dashboard?type=tourGuide'),
        );
      },
    ),
    GoRoute(path: '/admin_dashboard', builder: (context, state) => const AdminDashboardScreen()),
    GoRoute(path: '/admin_logs', builder: (context, state) => const AdminLogsScreen()),
    GoRoute(path: '/admin_moderation', builder: (context, state) => const AdminModerationScreen()),
  ],
);

class SiwaApp extends ConsumerWidget {
  const SiwaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Siwa Oasis',
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}