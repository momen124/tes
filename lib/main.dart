import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/screens/splash_screen.dart';
import 'package:siwa/screens/login_screen.dart';
import 'package:siwa/screens/register_screen.dart';
import 'package:siwa/screens/tourist_home_screen.dart';
import 'package:siwa/screens/admin_dashboard_screen.dart';
import 'package:siwa/screens/admin_logs_screen.dart';
import 'package:siwa/screens/admin_moderation_screen.dart';
import 'package:siwa/screens/booking_form_screen.dart';
import 'package:siwa/screens/business_dashboard_screen.dart';
import 'package:siwa/screens/business_listings_screen.dart';
import 'package:siwa/screens/business_product_management_screen.dart';
import 'package:siwa/screens/business_profile_screen.dart';
import 'package:siwa/screens/business_vehicle_management_screen.dart';
import 'package:siwa/screens/product_detail_screen.dart';
import 'package:siwa/screens/service_detail_screen.dart';
import 'package:siwa/screens/siwa_info_screen.dart';
import 'package:siwa/screens/tourist_bookings_screen.dart';
import 'package:siwa/screens/tourist_challenges_screen.dart';
import 'package:siwa/screens/tourist_profile_screen.dart';
import 'package:siwa/screens/tourist_search_screen.dart';
import 'package:siwa/screens/vehicle_management_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/tourist_home',
          builder: (context, state) => const TouristHomeScreen(),
        ),
        GoRoute(
          path: '/admin_dashboard',
          builder: (context, state) => const AdminDashboardScreen(),
        ),
        GoRoute(
          path: '/admin_logs',
          builder: (context, state) => const AdminLogsScreen(),
        ),
        GoRoute(
          path: '/admin_moderation',
          builder: (context, state) => const AdminModerationScreen(),
        ),
        GoRoute(
          path: '/booking_form',
          builder: (context, state) => const BookingFormScreen(),
        ),
        GoRoute(
          path: '/business_dashboard',
          builder: (context, state) => const BusinessDashboardScreen(),
        ),
        GoRoute(
          path: '/business_listings',
          builder: (context, state) => const BusinessListingsScreen(),
        ),
        GoRoute(
          path: '/business_product_management',
          builder: (context, state) => const BusinessProductManagementScreen(),
        ),
        GoRoute(
          path: '/business_profile',
          builder: (context, state) => const BusinessProfileScreen(),
        ),
        GoRoute(
          path: '/business_vehicle_management',
          builder: (context, state) => const BusinessVehicleManagementScreen(),
        ),
        GoRoute(
          path: '/product_detail',
          builder: (context, state) => const ProductDetailScreen(),
        ),
        GoRoute(
          path: '/service_detail',
          builder: (context, state) => const ServiceDetailScreen(),
        ),
        GoRoute(
          path: '/siwa_info',
          builder: (context, state) => const SiwaInfoScreen(),
        ),
        GoRoute(
          path: '/tourist_bookings',
          builder: (context, state) => const TouristBookingsScreen(),
        ),
        GoRoute(
          path: '/tourist_challenges',
          builder: (context, state) => const TouristChallengesScreen(),
        ),
        GoRoute(
          path: '/tourist_profile',
          builder: (context, state) => const TouristProfileScreen(),
        ),
        GoRoute(
          path: '/tourist_search',
          builder: (context, state) => const TouristSearchScreen(),
        ),
        GoRoute(
          path: '/vehicle_management',
          builder: (context, state) => const VehicleManagementScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Siwa Tourist App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}