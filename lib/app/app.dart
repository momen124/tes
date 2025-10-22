import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/features/tourist/screens/service_detail_screen.dart';
import 'dart:ui' as ui;
import 'package:siwa/providers/mock_data_provider.dart';

// Import all screens
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/tourist/screens/splash_screen.dart';
import '../features/tourist/screens/tourist_home_screen.dart';
import '../features/tourist/screens/tourist_bookings_screen.dart';
import '../features/tourist/screens/tourist_challenges_screen.dart';
import '../features/tourist/screens/tourist_profile_screen.dart';
import '../features/tourist/screens/tourist_search_screen.dart';
import '../features/tourist/screens/booking_form_screen.dart';
import '../features/tourist/screens/siwa_info_screen.dart';
import '../features/tourist/screens/transportation_list_screen.dart';
import '../features/tourist/screens/attractions_list_screen.dart';
import '../features/tourist/screens/restaurants_list_screen.dart';
import '../features/tourist/screens/tour_guides_list_screen.dart';
import '../features/tourist/screens/accommodations_list_screen.dart';  
import '../features/tourist/screens/services_list_screen.dart';       
import '../features/tourist/screens/payment_screen.dart';              
import '../features/tourist/screens/booking_confirmation_screen.dart'; 
// import '../models/booking.dart';                                       

import '../features/business/screens/business_app_main.dart';
import '../features/business/models/business_type.dart';
import '../features/admin/screens/admin_dashboard_screen.dart';
import '../features/admin/screens/admin_logs_screen.dart';
import '../features/admin/screens/admin_moderation_screen.dart';
import '../features/common/screens/debug_navigator_screen.dart';
import 'theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'errors.route_not_found'.tr(namedArgs: {'route': state.uri.toString()}),
      ),
    ),
  ),
  routes: [
    // ==================== Core & Auth ====================
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        final userType = state.uri.queryParameters['type'] ?? 'tourist';
        return RegisterScreen(userType: userType);
      },
    ),

    // ==================== Tourist Core ====================
    GoRoute(path: '/tourist_home', builder: (context, state) => const TouristHomeScreen()),
    GoRoute(path: '/tourist_bookings', builder: (context, state) => const TouristBookingsScreen()),
    GoRoute(path: '/tourist_challenges', builder: (context, state) => const TouristChallengesScreen()),
    GoRoute(path: '/tourist_profile', builder: (context, state) => const TouristProfileScreen()),
    GoRoute(path: '/tourist_search', builder: (context, state) => const TouristSearchScreen()),

    // ==================== Booking Flow ====================
    GoRoute(
      path: '/booking_form',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final serviceData = extra?['serviceData'] as Map<String, dynamic>? ?? {};
        return BookingFormScreen(
          serviceName: serviceData['name']?.toString() ?? 'common.unknown_service'.tr(),
          serviceType: state.uri.queryParameters['type'] ?? 'default',
          basePrice: (serviceData['price'] as num?)?.toDouble() ?? 0.0,
          imageUrl: serviceData['imageUrl']?.toString(),
        );
      },
    ),

    // Service Detail
    GoRoute(
      path: '/service_detail',
      builder: (context, state) {
        final serviceData = state.extra as Map<String, dynamic>?;
        debugPrint('Service Detail Route - Received data: ${serviceData?.keys}');
        return ServiceDetailScreen(serviceData: serviceData);
      },
    ),
    GoRoute(
      path: '/product_detail',
      builder: (context, state) {
        final serviceData = state.extra as Map<String, dynamic>?;
        return ServiceDetailScreen(serviceData: serviceData);
      },
    ),

    // Info
    GoRoute(path: '/siwa_info', builder: (context, state) => const SiwaInfoScreen()),

    // ==================== List Screens ====================
    GoRoute(path: '/transportation', builder: (context, state) => const TransportationListScreen()),
    GoRoute(path: '/attractions', builder: (context, state) => const AttractionsListScreen()),
    GoRoute(path: '/restaurants', builder: (context, state) => const RestaurantsListScreen()),
    GoRoute(path: '/tour_guides', builder: (context, state) => const TourGuidesListScreen()),

    // NEW: Dedicated Category Screens
    GoRoute(path: '/tours', builder: (context, state) => const TourGuidesListScreen()),
    GoRoute(path: '/accommodations', builder: (context, state) => const AccommodationsListScreen()),
    GoRoute(path: '/services', builder: (context, state) => const ServicesListScreen()),

    // ==================== Booking Completion Flow ====================
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final booking = state.extra as Booking;
        return PaymentScreen(booking: booking);
      },
    ),
    GoRoute(
      path: '/booking_confirmation',
      builder: (context, state) {
        final booking = state.extra as Booking;
        return BookingConfirmationScreen(booking: booking);
      },
    ),
    GoRoute(
      path: '/booking_detail',
      builder: (context, state) {
        final bookingData = state.extra as Map<String, dynamic>?;
        return Scaffold(
          appBar: AppBar(title: Text('booking.details.title'.tr())),
          body: Center(
            child: Text('booking.details.implement_ui'.tr()),
          ),
        );
      },
    ),

    // ==================== Business Dashboard & Type-Specific ====================
    GoRoute(
      path: '/business_dashboard',
      builder: (context, state) {
        final businessType = state.uri.queryParameters['type'] ?? 'hotel';
        final type = BusinessType.values.firstWhere(
          (e) => e.name == businessType,
          orElse: () => BusinessType.hotel,
        );
        return BusinessAppMain(businessType: type, onBack: () => context.go('/login'));
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
        return BusinessAppMain(businessType: type, onBack: () => context.go('/login'));
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
        return BusinessAppMain(businessType: type, onBack: () => context.go('/login'));
      },
    ),

    // Business Type-Specific Routes
    GoRoute(
      path: '/hotel_management',
      builder: (context, state) => BusinessAppMain(
        businessType: BusinessType.hotel,
        onBack: () => context.go('/business_dashboard?type=hotel'),
      ),
    ),
    GoRoute(
      path: '/rental_fleet',
      builder: (context, state) => BusinessAppMain(
        businessType: BusinessType.rental,
        onBack: () => context.go('/business_dashboard?type=rental'),
      ),
    ),
    GoRoute(
      path: '/route_management',
      builder: (context, state) => BusinessAppMain(
        businessType: BusinessType.transportation,
        onBack: () => context.go('/business_dashboard?type=transportation'),
      ),
    ),
    GoRoute(
      path: '/trip_itinerary',
      builder: (context, state) => BusinessAppMain(
        businessType: BusinessType.tripBooking,
        onBack: () => context.go('/business_dashboard?type=tripBooking'),
      ),
    ),
    GoRoute(
      path: '/menu_management',
      builder: (context, state) => BusinessAppMain(
        businessType: BusinessType.restaurant,
        onBack: () => context.go('/business_dashboard?type=restaurant'),
      ),
    ),
    GoRoute(
      path: '/store_inventory',
      builder: (context, state) => BusinessAppMain(
        businessType: BusinessType.store,
        onBack: () => context.go('/business_dashboard?type=store'),
      ),
    ),
    GoRoute(
      path: '/guide_schedule',
      builder: (context, state) => BusinessAppMain(
        businessType: BusinessType.tourGuide,
        onBack: () => context.go('/business_dashboard?type=tourGuide'),
      ),
    ),

    // ==================== Admin ====================
    GoRoute(path: '/admin_dashboard', builder: (context, state) => const AdminDashboardScreen()),
    GoRoute(path: '/admin_logs', builder: (context, state) => const AdminLogsScreen()),
    GoRoute(path: '/admin_moderation', builder: (context, state) => const AdminModerationScreen()),

    // ==================== Debug ====================
    GoRoute(path: '/debug_navigator', builder: (context, state) => const DebugNavigatorScreen()),
  ],
);

/// Main application widget
class SiwaApp extends ConsumerWidget {
  const SiwaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = context.locale;
    final isArabic = currentLocale.languageCode == 'ar';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currentLocaleProvider.notifier).state = currentLocale;
    });

    return MaterialApp.router(
      routerConfig: _router,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'app.name'.tr(),
      supportedLocales: context.supportedLocales,
      locale: currentLocale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        EasyLocalization.of(context)!.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}

final currentLocaleProvider = StateProvider<Locale>((ref) {
  return const Locale('en');
});