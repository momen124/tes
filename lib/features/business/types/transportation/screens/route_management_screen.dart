import 'package:siwa/providers/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';

class RouteManagementScreen extends ConsumerStatefulWidget {
  const RouteManagementScreen({super.key});

  @override
  ConsumerState<RouteManagementScreen> createState() => _RouteManagementScreenState();
}

class _RouteManagementScreenState extends ConsumerState<RouteManagementScreen>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late TabController _tabController;

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
    final stops = route['stops'] as List<dynamic>?;
    if (stops == null || stops.isEmpty) return [];
    return [
      Marker(
        point: stops[0] is LatLng ? stops[0] as LatLng : const LatLng(29.2031, 25.5197),
        child: const Icon(Icons.location_on, color: Colors.green, size: 30),
      ),
      if (stops.length > 1)
        Marker(
          point: stops[stops.length - 1] is LatLng
              ? stops[stops.length - 1] as LatLng
              : const LatLng(29.2000, 25.5200),
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
        title: Text('business.transport.route_management'.tr()), // Corrected translation key
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: isOffline ? null : _showAddRouteDialog,
            tooltip: 'business.transport.add_route'.tr(), // Corrected translation key
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
      itemCount: ref.watch(mockDataProvider).getAllOther().length,
      itemBuilder: (context, index) {
        final route = ref.watch(mockDataProvider).getAllOther()[index];
        if (route == null || route is! Map<String, dynamic>) return const SizedBox.shrink();
        final name = route['name']?.toString() ?? 'Unknown Route';
        final distance = route['distance']?.toString() ?? 'N/A';
        final duration = route['duration']?.toString() ?? 'N/A';
        final schedule = route['schedule']?.toString() ?? 'N/A';
        final ratePerKm = route['ratePerKm'] is num ? route['ratePerKm'] as num : 0;
        final stops = route['stops'] as List<dynamic>? ?? [const LatLng(29.2031, 25.5197)];

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(name, style: AppTheme.titleMedium),
            subtitle: Text(
              '$distance • $duration',
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
                          initialCenter: stops.isNotEmpty && stops[0] is LatLng
                              ? stops[0] as LatLng
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
                                points: stops
                                    .whereType<LatLng>()
                                    .cast<LatLng>()
                                    .toList(),
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
                    Text('Schedule: $schedule', style: AppTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Text('Rate: \$${ratePerKm.toStringAsFixed(2)}/km', style: AppTheme.bodyMedium),
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
      itemCount: ref.watch(mockDataProvider).getAllTransportation().length,
      itemBuilder: (context, index) {
        final vehicle = ref.watch(mockDataProvider).getAllTransportation()[index];
        if (vehicle == null || vehicle is! Map<String, dynamic>) return const SizedBox.shrink();
        final type = vehicle['type']?.toString() ?? 'Unknown Type';
        final plate = vehicle['plate']?.toString() ?? 'N/A';
        final capacity = vehicle['capacity']?.toString() ?? 'N/A';
        final verified = vehicle['verified'] as bool? ?? false;

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
            title: Text(type, style: AppTheme.titleMedium),
            subtitle: Text('Plate: $plate • Capacity: $capacity'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: verified ? AppTheme.successGreen : AppTheme.warningYellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                verified ? 'Verified' : 'Pending',
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
      itemCount: ref.watch(mockDataProvider).getAllOther().length,
      itemBuilder: (context, index) {
        final trip = ref.watch(mockDataProvider).getAllOther()[index];
        if (trip == null || trip is! Map<String, dynamic>) return const SizedBox.shrink();
        final guest = trip['guest']?.toString() ?? 'Unknown Guest';
        final route = trip['route']?.toString() ?? 'N/A';
        final time = trip['time']?.toString() ?? 'N/A';
        final passengers = trip['passengers']?.toString() ?? 'N/A';
        final status = trip['status']?.toString() ?? 'pending';
        final isPending = status.toLowerCase() == 'pending';

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
            title: Text(guest, style: AppTheme.titleMedium),
            subtitle: Text('$route • $time • $passengers passengers'),
            trailing: isPending && !isOffline
                ? ElevatedButton(
                    onPressed: () => _approveTrip(trip),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text('Approve'.tr()),
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
        title: Text('business.transport.add_route'.tr()), // Corrected translation key
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'business.transport.route_name'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter route name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: distanceController,
                  decoration: InputDecoration(labelText: 'business.transport.distance'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter distance' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: durationController,
                  decoration: InputDecoration(labelText: 'business.transport.duration'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter duration' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: scheduleController,
                  decoration: InputDecoration(labelText: 'business.transport.schedule'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter schedule' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: rateController,
                  decoration: InputDecoration(labelText: 'business.transport.rate_per_km'.tr()),
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
            child: Text('common.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  ref.watch(mockDataProvider).getAllOther().add({
                    'id': ref.watch(mockDataProvider).getAllOther().length + 1,
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
                  SnackBar(content: Text('business.transport.route_added'.tr())),
                );
                _confettiController.play();
              }
            },
            child: Text('common.add'.tr()),
          ),
        ],
      ),
    );
  }

  void _showEditRouteDialog(Map<String, dynamic> route) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: route['name']?.toString() ?? '');
    final scheduleController = TextEditingController(text: route['schedule']?.toString() ?? '');
    final rateController = TextEditingController(text: (route['ratePerKm'] ?? 0).toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('business.transport.edit_route'.tr()), // Corrected translation key
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'business.transport.route_name'.tr()),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter route name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: scheduleController,
                decoration: InputDecoration(labelText: 'business.transport.schedule'.tr()),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter schedule' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: rateController,
                decoration: InputDecoration(labelText: 'business.transport.rate_per_km'.tr()),
                keyboardType: TextInputType.number,
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter rate' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
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
                  SnackBar(content: Text('business.transport.route_updated'.tr())),
                );
                _confettiController.play();
              }
            },
            child: Text('common.save'.tr()),
          ),
        ],
      ),
    );
  }

  void _showEditVehicleDialog(Map<String, dynamic> vehicle) {
    final formKey = GlobalKey<FormState>();
    final typeController = TextEditingController(text: vehicle['type']?.toString() ?? '');
    final plateController = TextEditingController(text: vehicle['plate']?.toString() ?? '');
    final capacityController = TextEditingController(text: (vehicle['capacity'] ?? 0).toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('business.transport.edit_vehicle'.tr()), // Corrected translation key
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'business.transport.vehicle_type'.tr()),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter vehicle type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: plateController,
                decoration: InputDecoration(labelText: 'business.transport.plate_number'.tr()),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter plate number' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: capacityController,
                decoration: InputDecoration(labelText: 'business.transport.capacity'.tr()),
                keyboardType: TextInputType.number,
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter capacity' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
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
                  SnackBar(content: Text('business.transport.vehicle_updated'.tr())),
                );
                _confettiController.play();
              }
            },
            child: Text('common.save'.tr()),
          ),
        ],
      ),
    );
  }

  void _deleteRoute(Map<String, dynamic> route) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('business.transport.delete_route'.tr()), // Corrected translation key
        content: Text('Are you sure you want to delete ${route['name'] ?? 'this route'}?'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                ref.watch(mockDataProvider).getAllOther().remove(route);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('business.transport.route_deleted'.tr())),
              );
              _confettiController.play();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: Text('common.delete'.tr()),
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
      SnackBar(
        content: Text('business.transport.trip_approved'.tr()),
        backgroundColor: AppTheme.successGreen,
      ),
    );
    _confettiController.play();
  }
}