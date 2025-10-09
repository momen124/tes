import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RouteManagementScreen extends ConsumerStatefulWidget {
  const RouteManagementScreen({super.key});

  @override
  ConsumerState<RouteManagementScreen> createState() => _RouteManagementScreenState();
}

class _RouteManagementScreenState extends ConsumerState<RouteManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ConfettiController _confettiController;

  // Mock data (replace with provider)
  final List<Map<String, dynamic>> _routes = [
    {
      'name': 'Siwa Local Loop',
      'stops': [LatLng(29.2031, 25.5197), LatLng(29.2000, 25.5200)],
      'ratePerKm': 2.0,
      'schedule': 'Daily 8AM-8PM',
    },
    // Add more
  ];

  final List<Map<String, dynamic>> _vehicles = [
    {
      'type': 'Bus',
      'plate': 'ABC123',
      'verified': true,
    },
    // Add more
  ];

  final List<Map<String, dynamic>> _trips = [
    {
      'guest': 'Jane Doe',
      'route': 'Siwa Local Loop',
      'status': 'pending',
    },
    // Add more
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/business_dashboard'),
        ),
        title: const Text('Route Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: isOffline ? null : _showAddRouteDialog,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryOrange,
          labelColor: AppTheme.primaryOrange,
          unselectedLabelColor: AppTheme.gray,
          tabs: const [
            Tab(text: 'Routes', icon: Icon(Icons.route)),
            Tab(text: 'Vehicles', icon: Icon(Icons.local_taxi)),
            Tab(text: 'Trips', icon: Icon(Icons.trip_origin)),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              _buildRoutesTab(isOffline),
              _buildVehiclesTab(isOffline),
              _buildTripsTab(isOffline),
            ],
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
          ),
        ],
      ),
    );
  }

  Widget _buildRoutesTab(bool isOffline) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _routes.length,
      itemBuilder: (context, index) {
        final route = _routes[index];
        return Card(
          child: ExpansionTile(
            title: Text(route['name'], style: AppTheme.titleMedium),
            subtitle: Text(route['schedule'], style: AppTheme.bodySmall),
            children: [
              SizedBox(
                height: 200,
                child: FlutterMap(
                  options: MapOptions(
                    center: route['stops'][0],
                    zoom: 12.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: route['stops'],
                          color: AppTheme.oasisTeal,
                          strokeWidth: 4.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppTheme.primaryOrange),
                    onPressed: isOffline ? null : () => _showEditRouteDialog(route),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppTheme.errorRed),
                    onPressed: isOffline ? null : () => _deleteRoute(route),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVehiclesTab(bool isOffline) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = _vehicles[index];
        return Card(
          child: ListTile(
            title: Text(vehicle['type'], style: AppTheme.titleMedium),
            subtitle: Text('Plate: ${vehicle['plate']}', style: AppTheme.bodyMedium),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: vehicle['verified'] ? AppTheme.successGreen : AppTheme.warningYellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                vehicle['verified'] ? 'Verified' : 'Pending',
                style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
              ),
            ),
            onTap: isOffline ? null : () => _showEditVehicleDialog(vehicle),
          ),
        );
      },
    );
  }

  Widget _buildTripsTab(bool isOffline) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _trips.length,
      itemBuilder: (context, index) {
        final trip = _trips[index];
        return Card(
          child: ListTile(
            title: Text(trip['guest'], style: AppTheme.titleMedium),
            subtitle: Text('Route: ${trip['route']}', style: AppTheme.bodyMedium),
            trailing: ElevatedButton(
              onPressed: isOffline ? null : () => _approveTrip(trip),
              child: const Text('Approve'),
            ),
          ),
        );
      },
    );
  }

  void _showAddRouteDialog() {
    // Form for name, stops (map pins), schedule, rate
    // On save, add to _routes, play confetti
  }

  void _showEditRouteDialog(Map<String, dynamic> route) {
    // Similar to add, pre-fill
  }

  void _deleteRoute(Map<String, dynamic> route) {
    // Remove from _routes
  }

  void _showEditVehicleDialog(Map<String, dynamic> vehicle) {
    // Form for type, plate, verification
  }

  void _approveTrip(Map<String, dynamic> trip) {
    // Update status, play confetti
  }
}