import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/features/auth/screens/login_screen.dart';
import 'package:siwa/features/auth/screens/register_screen.dart';
import 'package:siwa/features/tourist/screens/tourist_home_screen.dart';
import 'package:siwa/features/tourist/screens/tourist_bookings_screen.dart';
import 'package:siwa/features/tourist/screens/tourist_challenges_screen.dart';
import 'package:siwa/features/tourist/screens/tourist_profile_screen.dart';
import 'package:siwa/features/tourist/screens/tourist_search_screen.dart';
import 'package:siwa/features/tourist/screens/booking_form_screen.dart';
import 'package:siwa/features/tourist/screens/product_detail_screen.dart';
import 'package:siwa/features/tourist/screens/service_detail_screen.dart';
import 'package:siwa/features/tourist/screens/siwa_info_screen.dart';
import 'package:siwa/features/tourist/screens/splash_screen.dart';
import 'package:siwa/features/business/screens/vehicle_management_screen.dart';
import 'package:siwa/features/business/screens/business_dashboard_screen.dart';
import 'package:siwa/features/business/screens/business_listings_screen.dart';
import 'package:siwa/features/business/screens/business_product_management_screen.dart';
import 'package:siwa/features/business/screens/business_profile_screen.dart';
import 'package:siwa/features/business/screens/business_vehicle_management_screen.dart';

// Business Type-Specific Screens
import 'package:siwa/features/business/types/hotel/screens/hotel_management_screen.dart';
import 'package:siwa/features/business/types/rental/screens/rental_fleet_screen.dart' hide RouteManagementScreen;
import 'package:siwa/features/business/types/transportation/screens/route_management_screen.dart';
import 'package:siwa/features/business/types/trip_booking/screens/trip_itinerary_screen.dart';
import 'package:siwa/features/business/types/restaurant/screens/menu_management_screen.dart';
import 'package:siwa/features/business/types/store/screens/store_inventory_screen.dart';
import 'package:siwa/features/business/types/tour_guide/screens/guide_schedule_screen.dart' hide TripItineraryScreen;

// Admin Screens
import 'package:siwa/features/admin/screens/admin_dashboard_screen.dart';
import 'package:siwa/features/admin/screens/admin_logs_screen.dart';
import 'package:siwa/features/admin/screens/admin_moderation_screen.dart';
import 'package:siwa/app/theme.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    // Auth Routes
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    
    // Tourist Routes
    GoRoute(path: '/tourist_home', builder: (context, state) => const TouristHomeScreen()),
    GoRoute(path: '/tourist_bookings', builder: (context, state) => const TouristBookingsScreen()),
    GoRoute(path: '/tourist_challenges', builder: (context, state) => const TouristChallengesScreen()),
    GoRoute(path: '/tourist_profile', builder: (context, state) => const TouristProfileScreen()),
    GoRoute(path: '/tourist_search', builder: (context, state) => const TouristSearchScreen()),
    GoRoute(path: '/booking_form', builder: (context, state) => const BookingFormScreen()),
    GoRoute(path: '/product_detail', builder: (context, state) => const ProductDetailScreen()),
    GoRoute(path: '/service_detail', builder: (context, state) => const ServiceDetailScreen()),
    GoRoute(path: '/siwa_info', builder: (context, state) => const SiwaInfoScreen()),
    
    // General Business Routes
    GoRoute(path: '/vehicle_management', builder: (context, state) => const VehicleManagementScreen()),
    GoRoute(path: '/business_dashboard', builder: (context, state) => const BusinessDashboardScreen()),
    GoRoute(path: '/business_listings', builder: (context, state) => const BusinessListingsScreen()),
    GoRoute(path: '/business_product_management', builder: (context, state) => const BusinessProductManagementScreen()),
    GoRoute(path: '/business_profile', builder: (context, state) => const BusinessProfileScreen()),
    GoRoute(path: '/business_vehicle_management', builder: (context, state) => const BusinessVehicleManagementScreen()),
    
    // Business Type-Specific Routes
    GoRoute(path: '/hotel_management', builder: (context, state) => const HotelManagementScreen()),
    GoRoute(path: '/rental_fleet', builder: (context, state) => const RentalFleetScreen()),
    GoRoute(path: '/route_management', builder: (context, state) => const RouteManagementScreen()),
    GoRoute(path: '/trip_itinerary', builder: (context, state) => const TripItineraryScreen()),
    GoRoute(path: '/menu_management', builder: (context, state) => const MenuManagementScreen()),
    GoRoute(path: '/store_inventory', builder: (context, state) => const StoreInventoryScreen()),
    GoRoute(path: '/guide_schedule', builder: (context, state) => const GuideScheduleScreen()),
    
    // Admin Routes
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
    );
  }
}