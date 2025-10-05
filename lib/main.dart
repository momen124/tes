// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/screens/splash_screen.dart';
import 'package:siwa/screens/login_screen.dart';
import 'package:siwa/screens/register_screen.dart';
import 'package:siwa/screens/tourist_home_screen.dart';
// Add other screens as needed
import 'package:siwa/screens/admin_dashboard_screen.dart';
import 'package:siwa/screens/business_dashboard_screen.dart';
import 'package:siwa/screens/tourist_profile_screen.dart';
import 'package:siwa/screens/tourist_search_screen.dart';

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
        // Add routes for other screens
        GoRoute(
          path: '/admin_dashboard',
          builder: (context, state) => const AdminDashboardScreen(),
        ),
        GoRoute(
          path: '/business_dashboard',
          builder: (context, state) => const BusinessDashboardScreen(),
        ),
        GoRoute(
          path: '/tourist_profile',
          builder: (context, state) => const TouristProfileScreen(),
        ),
        GoRoute(
          path: '/tourist_search',
          builder: (context, state) => const TouristSearchScreen(),
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