// lib/features/business/types/transport/screens/route_management_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/business/models/business_type.dart';
import 'package:siwa/features/business/widgets/navigation/business_bottom_nav.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:confetti/confetti.dart';

class RouteManagementScreen extends ConsumerStatefulWidget {
  const RouteManagementScreen({super.key});

  @override
  ConsumerState<RouteManagementScreen> createState() => _RouteManagementScreenState();
}

class _RouteManagementScreenState extends ConsumerState<RouteManagementScreen> with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late TabController _tabController;

  final List<Map<String, dynamic>> _routes = [
    {
      'id': 1,
      'name': 'Siwa Local Loop',
      'stops': [
        const LatLng(29.2031, 25.5197),
        const LatLng(29.2000, 25.5200),
        const LatLng(29.1950, 25.5250),
      ],
      'ratePerKm': 2.0,
      'schedule': 'Daily 8AM-8PM',
      'distance': '25 km',
      'duration': '1.5 hours',
    },
    {
      'id': 2,
      'name': 'Desert Safari Route',
      'stops': [
        const LatLng(29.2031, 25.5197),
        const LatLng(29.1500, 25.4500),
      ],
      'ratePerKm': 3.5,
      'schedule': 'Daily 7AM-6PM',
      'distance': '80 km',
      'duration': '4 hours',
    },
  ];

  final List<Map<String, dynamic>> _vehicles = [
    {
      'id': 1,
      'type': 'Bus',
      'plate': 'ABC123',
      'verified': true,
      'capacity': 45,
    },
    {
      'id': 2,
      'type': '4x4 SUV',
      'plate': 'XYZ789',
      'verified': true,
      'capacity': 7,
    },
  ];

  final List<Map<String, dynamic>> _trips = [
    {
      'id': 1,
      'guest': 'Jane Doe',
      'route': 'Siwa Local Loop',
      'status': 'pending',
      'time': '09:00 AM',
      'passengers': 3,
    },
    {
      'id': 2,
      'guest': 'Ahmed Hassan',
      'route': 'Desert Safari Route',
      'status': 'confirmed',
      'time': '07:30 AM',
      'passengers': 5,
    },
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<Marker> _buildRouteMarkers(Map<String, dynamic> route) {
    final stops = route['stops'] as List?;
    if (stops == null || stops.isEmpty) return [];
    
    return [
      Marker(
        point: stops[0],
        child: const Icon(Icons.location_on, color: Colors.green, size: 30),
      ),
      if (stops.length > 1)
        Marker(
          point: stops[stops.length - 1],
          child: const Icon(Icons.location_on, color: Colors.red, size: 30),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: isOffline ? null : () => context.go('/business_dashboard'),
        ),
        title: const Text('Route Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: isOffline ? null : _showAddRouteDialog,
            tooltip: 'Add Route',
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
      body: isOffline
          ? Center(
              child: Container(
                decoration: AppTheme.offlineBanner,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'You are currently offline',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                _buildRoutesTab(isOffline).animate().fadeIn(),
                _buildVehiclesTab(isOffline).animate().fadeIn(),
                _buildTripsTab(isOffline).animate().fadeIn(),
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
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(route['name'], style: AppTheme.titleMedium),
            subtitle: Text(
              '${route['distance']} • ${route['duration']}',
              style: AppTheme.bodySmall,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: (route['stops'] as List?)?.isNotEmpty == true 
                              ? route['stops'][0] 
                              : const LatLng(29.2031, 25.5197),
                          initialZoom: 12.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          ),
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: List<LatLng>.from(route['stops'] as List? ?? []),
                                color: AppTheme.oasisTeal,
                                strokeWidth: 4.0,
                              ),
                            ],
                          ),
                          MarkerLayer(
                            markers: _buildRouteMarkers(route),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Schedule: ${route['schedule']}', style: AppTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Text('Rate: \$${route['ratePerKm']}/km', style: AppTheme.bodyMedium),
                    const SizedBox(height: 16),
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
              ),
            ],
          ),
        ).animate().fadeIn();
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
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.directions_bus, color: AppTheme.primaryOrange),
            ),
            title: Text(vehicle['type'], style: AppTheme.titleMedium),
            subtitle: Text('Plate: ${vehicle['plate']} • Capacity: ${vehicle['capacity']}'),
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
        ).animate().fadeIn();
      },
    );
  }

  Widget _buildTripsTab(bool isOffline) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _trips.length,
      itemBuilder: (context, index) {
        final trip = _trips[index];
        final isPending = trip['status'] == 'pending';

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isPending
                    ? AppTheme.warningYellow.withOpacity(0.1)
                    : AppTheme.successGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.person,
                color: isPending ? AppTheme.warningYellow : AppTheme.successGreen,
              ),
            ),
            title: Text(trip['guest'], style: AppTheme.titleMedium),
            subtitle: Text('${trip['route']} • ${trip['time']} • ${trip['passengers']} passengers'),
            trailing: isPending && !isOffline
                ? ElevatedButton(
                    onPressed: () => _approveTrip(trip),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text('Approve'),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.successGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Confirmed',
                      style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                    ),
                  ),
          ),
        ).animate().fadeIn();
      },
    );
  }

  void _showAddRouteDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final distanceController = TextEditingController();
    final durationController = TextEditingController();
    final scheduleController = TextEditingController();
    final rateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Route'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Route Name'),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter route name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: distanceController,
                  decoration: const InputDecoration(labelText: 'Distance (e.g., 25 km)'),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter distance' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: durationController,
                  decoration: const InputDecoration(labelText: 'Duration (e.g., 1.5 hours)'),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter duration' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: scheduleController,
                  decoration: const InputDecoration(labelText: 'Schedule (e.g., Daily 8AM-8PM)'),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter schedule' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: rateController,
                  decoration: const InputDecoration(labelText: 'Rate per km'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter rate' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  _routes.add({
                    'id': _routes.length + 1,
                    'name': nameController.text,
                    'stops': [const LatLng(29.2031, 25.5197), const LatLng(29.2000, 25.5200)],
                    'ratePerKm': double.tryParse(rateController.text) ?? 2.0,
                    'schedule': scheduleController.text,
                    'distance': distanceController.text,
                    'duration': durationController.text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Route added successfully')),
                );
                _confettiController.play();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditRouteDialog(Map<String, dynamic> route) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: route['name']);
    final scheduleController = TextEditingController(text: route['schedule']);
    final rateController = TextEditingController(text: route['ratePerKm'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Route'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Route Name'),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter route name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: scheduleController,
                decoration: const InputDecoration(labelText: 'Schedule'),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter schedule' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: rateController,
                decoration: const InputDecoration(labelText: 'Rate per km'),
                keyboardType: TextInputType.number,
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter rate' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  route['name'] = nameController.text;
                  route['schedule'] = scheduleController.text;
                  route['ratePerKm'] = double.tryParse(rateController.text) ?? route['ratePerKm'];
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Route updated')),
                );
                _confettiController.play();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditVehicleDialog(Map<String, dynamic> vehicle) {
    final formKey = GlobalKey<FormState>();
    final typeController = TextEditingController(text: vehicle['type']);
    final plateController = TextEditingController(text: vehicle['plate']);
    final capacityController = TextEditingController(text: vehicle['capacity'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Vehicle'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Vehicle Type'),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter vehicle type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: plateController,
                decoration: const InputDecoration(labelText: 'Plate Number'),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter plate number' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: capacityController,
                decoration: const InputDecoration(labelText: 'Capacity'),
                keyboardType: TextInputType.number,
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter capacity' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  vehicle['type'] = typeController.text;
                  vehicle['plate'] = plateController.text;
                  vehicle['capacity'] = int.tryParse(capacityController.text) ?? vehicle['capacity'];
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vehicle updated')),
                );
                _confettiController.play();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteRoute(Map<String, dynamic> route) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Route'),
        content: Text('Are you sure you want to delete "${route['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _routes.remove(route);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Route deleted')),
              );
              _confettiController.play();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _approveTrip(Map<String, dynamic> trip) {
    setState(() {
      trip['status'] = 'confirmed';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Trip approved successfully!'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
    _confettiController.play();
  }
}