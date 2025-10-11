// lib/widgets/navigation/business_bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/business/models/business_type.dart';

class BusinessBottomNav extends StatelessWidget {
  final int currentIndex;
  final BusinessType businessType;

  const BusinessBottomNav({
    super.key,
    required this.currentIndex,
    required this.businessType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onTap(context, index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppTheme.primaryOrange,
          unselectedItemColor: AppTheme.gray,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              activeIcon: Icon(Icons.list_alt),
              label: 'Listings',
            ),
            _getBusinessSpecificNavItem(),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the business-specific navigation item based on business type
  BottomNavigationBarItem _getBusinessSpecificNavItem() {
    switch (businessType) {
      case BusinessType.hotel:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.hotel_outlined),
          activeIcon: Icon(Icons.hotel),
          label: 'Rooms',
        );
      case BusinessType.rental:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.directions_car_outlined),
          activeIcon: Icon(Icons.directions_car),
          label: 'Fleet',
        );
      case BusinessType.restaurant:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu_outlined),
          activeIcon: Icon(Icons.restaurant_menu),
          label: 'Menu',
        );
      case BusinessType.store:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.inventory_outlined),
          activeIcon: Icon(Icons.inventory),
          label: 'Inventory',
        );
      case BusinessType.tourGuide:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Schedule',
        );
      case BusinessType.transportation:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.route_outlined),
          activeIcon: Icon(Icons.route),
          label: 'Routes',
        );
      case BusinessType.tripBooking:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          activeIcon: Icon(Icons.map),
          label: 'Trips',
        );
    }
  }

  /// Handles navigation tap events
  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/business_dashboard');
        break;
      case 1:
        context.go('/business_listings');
        break;
      case 2:
        _navigateToBusinessSpecificScreen(context);
        break;
      case 3:
        context.go('/business_profile');
        break;
    }
  }

  /// Navigates to the business-specific management screen
  void _navigateToBusinessSpecificScreen(BuildContext context) {
    switch (businessType) {
      case BusinessType.hotel:
        context.go('/hotel_management');
        break;
      case BusinessType.rental:
        context.go('/rental_fleet');
        break;
      case BusinessType.restaurant:
        context.go('/menu_management');
        break;
      case BusinessType.store:
        context.go('/store_inventory');
        break;
      case BusinessType.tourGuide:
        context.go('/guide_schedule');
        break;
      case BusinessType.transportation:
        context.go('/route_management');
        break;
      case BusinessType.tripBooking:
        context.go('/trip_itinerary');
        break;
    }
  }
}
