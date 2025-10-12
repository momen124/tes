import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/business/models/business_type.dart';
import 'package:siwa/features/business/providers/business_provider.dart';
import 'package:siwa/features/business/screens/business_dashboard_screen.dart';
import 'package:siwa/features/business/screens/business_listings_screen.dart';
import 'package:siwa/features/business/screens/business_profile_screen.dart';
import 'package:siwa/features/business/types/hotel/screens/hotel_management_screen.dart';
import 'package:siwa/features/business/types/rental/screens/rental_fleet_screen.dart';
import 'package:siwa/features/business/types/restaurant/screens/menu_management_screen.dart';
import 'package:siwa/features/business/types/store/screens/store_inventory_screen.dart';
import 'package:siwa/features/business/types/tour_guide/screens/guide_schedule_screen.dart';
import 'package:siwa/features/business/types/transportation/screens/route_management_screen.dart';
import 'package:siwa/features/business/widgets/navigation/business_bottom_nav.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:confetti/confetti.dart';

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
  late ConfettiController _confettiController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

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
        return const Color(0xFFFF9500); // Desert orange
      case BusinessType.rental:
        return const Color(0xFF2196F3); // Sky blue
      case BusinessType.restaurant:
        return const Color(0xFF4CAF50); // Sand green
      case BusinessType.store:
        return const Color(0xFF9C27B0); // Purple dusk
      case BusinessType.tourGuide:
        return const Color(0xFFFFC107); // Golden sand
      case BusinessType.transportation:
        return const Color(0xFFF44336); // Red rock
      case BusinessType.tripBooking:
        return const Color(0xFF00BCD4); // Oasis blue
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
        return const GuideScheduleScreen(); // Placeholder; update with trip_itinerary
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

  void _onTabChange(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);
    final businessColor = _getBusinessColor();
    final business = ref.watch(businessProvider);

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
                  colors: [businessColor, businessColor.withOpacity(0.8)],
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
            ).animate().fadeIn(duration: 500.ms),
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
            onPressed: isOffline
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Toggling connectivity...')),
                    );
                    ref.read(offlineProvider.notifier).state = !isOffline;
                    if (!isOffline) _confettiController.play();
                  },
          ),
        ],
      ),
      body: _buildScreen(),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.white,
        child: BusinessBottomNav(
          currentIndex: _currentIndex,
          businessType: widget.businessType,
          onTap: _onTabChange,
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}