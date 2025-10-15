import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class DebugNavigatorScreen extends StatelessWidget {
  const DebugNavigatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('navigation.search'.tr()),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Tourist Routes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildNavButton(context, 'Tourist Home', '/tourist_home'),
          _buildNavButton(context, 'Tourist Bookings', '/tourist_bookings'),
          _buildNavButton(context, 'Tourist Challenges', '/tourist_challenges'),
          _buildNavButton(context, 'Tourist Profile', '/tourist_profile'),
          _buildNavButton(context, 'Tourist Search', '/tourist_search'),
          _buildNavButton(
            context,
            'Booking Form (default)',
            '/booking_form?type=default',
          ),
          _buildNavButton(context, 'Product Detail', '/product_detail'),
          _buildNavButton(context, 'Service Detail', '/service_detail'),
          _buildNavButton(context, 'Siwa Info', '/siwa_info'),
          _buildNavButton(context, 'Attractions List', '/attractions'),
          _buildNavButton(context, 'Restaurants List', '/restaurants'),
          _buildNavButton(context, 'Tour Guides List', '/tour_guides'),
          _buildNavButton(context, 'Transportation List', '/transportation'),
          _buildNavButton(
            context,
            'Forgot Password',
            '/forgot_password',
          ), // Assuming this exists
          _buildNavButton(
            context,
            'Payment',
            '/payment',
          ), // Assuming this exists
          _buildNavButton(
            context,
            'Tour Guide Profile',
            '/tour_guide_profile',
          ), // Assuming this exists

          const SizedBox(height: 24),
          const Text(
            'Business Routes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildNavButton(
            context,
            'Business Dashboard (Hotel)',
            '/business_dashboard?type=hotel',
          ),
          _buildNavButton(
            context,
            'Business Listings (Hotel)',
            '/business_listings?type=hotel',
          ),
          _buildNavButton(
            context,
            'Business Profile (Hotel)',
            '/business_profile?type=hotel',
          ),
          _buildNavButton(context, 'Hotel Management', '/hotel_management'),
          _buildNavButton(context, 'Rental Fleet', '/rental_fleet'),
          _buildNavButton(context, 'Route Management', '/route_management'),
          _buildNavButton(context, 'Trip Itinerary', '/trip_itinerary'),
          _buildNavButton(context, 'Menu Management', '/menu_management'),
          _buildNavButton(context, 'Store Inventory', '/store_inventory'),
          _buildNavButton(context, 'Guide Schedule', '/guide_schedule'),

          const SizedBox(height: 24),
          const Text(
            'Admin Routes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildNavButton(context, 'Admin Dashboard', '/admin_dashboard'),
          _buildNavButton(context, 'Admin Logs', '/admin_logs'),
          _buildNavButton(context, 'Admin Moderation', '/admin_moderation'),

          const SizedBox(height: 24),
          const Text(
            'Auth Routes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildNavButton(context, 'Login', '/login'),
          _buildNavButton(
            context,
            'Register (Tourist)',
            '/register?type=tourist',
          ),
          _buildNavButton(
            context,
            'Register (Business)',
            '/register?type=business',
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: () => context.go(route),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
        ),
        child: Text(title),
      ),
    );
  }
}
