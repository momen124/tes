// lib/features/business/screens/business_app_main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/business/models/business_type.dart';
import 'package:siwa/features/business/screens/business_dashboard_screen.dart';
import 'package:siwa/features/business/screens/business_profile_screen.dart';
import 'package:siwa/features/business/screens/business_listings_screen.dart';
import 'package:siwa/features/business/types/hotel/screens/hotel_management_screen.dart';
import 'package:siwa/features/business/types/rental/screens/rental_fleet_screen.dart' hide RouteManagementScreen;
import 'package:siwa/features/business/types/restaurant/screens/menu_management_screen.dart';
import 'package:siwa/features/business/types/store/screens/store_inventory_screen.dart';
import 'package:siwa/features/business/types/tour_guide/screens/guide_schedule_screen.dart';
import 'package:siwa/features/business/types/transportation/screens/route_management_screen.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';

class BusinessAppMain extends ConsumerStatefulWidget {
  final BusinessType businessType;
  final VoidCallback onBack;

  const BusinessAppMain({
    super.key,
    required this.businessType,
    required this.onBack,
  });

  @override
  ConsumerState<BusinessAppMain> createState() => _BusinessAppMainState();
}

class _BusinessAppMainState extends ConsumerState<BusinessAppMain> {
  int _currentIndex = 0;

  IconData _getBusinessIcon() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return Icons.hotel;
      case BusinessType.rental:
        return Icons.directions_car;
      case BusinessType.restaurant:
        return Icons.restaurant;
      case BusinessType.store:
        return Icons.store;
      case BusinessType.tourGuide:
        return Icons.explore;
      case BusinessType.transportation:
        return Icons.directions_bus;
      case BusinessType.tripBooking:
        return Icons.map;
    }
  }

  Color _getBusinessColor() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return const Color(0xFFFF9500); // Orange
      case BusinessType.rental:
        return const Color(0xFF2196F3); // Blue
      case BusinessType.restaurant:
        return const Color(0xFF4CAF50); // Green
      case BusinessType.store:
        return const Color(0xFF9C27B0); // Purple
      case BusinessType.tourGuide:
        return const Color(0xFFFFC107); // Amber
      case BusinessType.transportation:
        return const Color(0xFFF44336); // Red
      case BusinessType.tripBooking:
        return const Color(0xFF00BCD4); // Cyan
    }
  }

  String _getManagementLabel() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return 'Rooms';
      case BusinessType.rental:
        return 'Fleet';
      case BusinessType.restaurant:
        return 'Menu';
      case BusinessType.store:
        return 'Inventory';
      case BusinessType.tourGuide:
        return 'Schedule';
      case BusinessType.transportation:
        return 'Routes';
      case BusinessType.tripBooking:
        return 'Trips';
    }
  }

  Widget _getManagementScreen() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return const HotelManagementScreen();
      case BusinessType.rental:
        return const RentalFleetScreen();
      case BusinessType.restaurant:
        return const MenuManagementScreen();
      case BusinessType.store:
        return const StoreInventoryScreen();
      case BusinessType.tourGuide:
        return const GuideScheduleScreen();
      case BusinessType.transportation:
        return const RouteManagementScreen();
      case BusinessType.tripBooking:
        return const GuideScheduleScreen(); // Reuse for now
    }
  }

  Widget _buildScreen() {
    switch (_currentIndex) {
      case 0:
        return BusinessDashboardScreen(businessType: widget.businessType);
      case 1:
        return const BusinessListingsScreen();
      case 2:
        return _getManagementScreen();
      case 3:
        return const BusinessProfileScreen();
      default:
        return BusinessDashboardScreen(businessType: widget.businessType);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);
    final businessColor = _getBusinessColor();

    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    businessColor,
                    businessColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getBusinessIcon(),
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              widget.businessType.displayName,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              isOffline ? Icons.wifi_off : Icons.wifi,
              color: isOffline ? AppTheme.errorRed : AppTheme.gray,
            ),
            onPressed: () {
              // Toggle offline mode for testing
              ref.read(offlineProvider.notifier).state = !isOffline;
            },
          ),
        ],
      ),
      body: _buildScreen(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: businessColor,
          unselectedItemColor: AppTheme.gray,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Listings',
            ),
            BottomNavigationBarItem(
              icon: Icon(_getBusinessIcon()),
              label: _getManagementLabel(),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// Business Dashboard with Offline Support
class BusinessDashboardScreen extends ConsumerWidget {
  final BusinessType businessType;

  const BusinessDashboardScreen({
    super.key,
    required this.businessType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOffline = ref.watch(offlineProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Offline Banner
          if (isOffline)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: AppTheme.lightGray,
              child: Row(
                children: [
                  const Icon(
                    Icons.wifi_off,
                    color: AppTheme.errorRed,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Offline. Data syncs when connected.',
                      style: TextStyle(
                        color: AppTheme.darkGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, size: 20),
                    onPressed: () {
                      // Attempt to sync
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Attempting to sync...')),
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

          // Header with Add Button
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: isOffline ? null : () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Stats Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Total Bookings',
                    value: '173',
                    change: '+12%',
                    icon: Icons.trending_up,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Total Revenue',
                    value: '\$95,000',
                    change: '+18%',
                    icon: Icons.attach_money,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Activities List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Activities & Services',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ActivityItem(
                      name: 'Desert Safari Tour',
                      status: 'active',
                      bookings: 45,
                      price: '\$120',
                    ),
                    const SizedBox(height: 12),
                    _ActivityItem(
                      name: 'Oasis Swimming',
                      status: 'active',
                      bookings: 32,
                      price: '\$50',
                    ),
                    const SizedBox(height: 12),
                    _ActivityItem(
                      name: 'Traditional Dinner',
                      status: 'pending',
                      bookings: 28,
                      price: '\$80',
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9500), Color(0xFFFF6B00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryOrange.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$change from last month',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String name;
  final String status;
  final int bookings;
  final String price;

  const _ActivityItem({
    required this.name,
    required this.status,
    required this.bookings,
    required this.price,
  });

  Color _getStatusColor() {
    switch (status) {
      case 'active':
        return AppTheme.successGreen;
      case 'pending':
        return AppTheme.warningYellow;
      default:
        return AppTheme.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightBlueGray.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$bookings bookings',
                      style: const TextStyle(
                        color: AppTheme.gray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              color: AppTheme.primaryOrange,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}