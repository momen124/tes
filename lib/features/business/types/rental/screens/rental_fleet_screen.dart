// lib/features/business/types/rental/screens/rental_fleet_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';

class RentalFleetScreen extends StatefulWidget {
  const RentalFleetScreen({super.key});

  @override
  State<RentalFleetScreen> createState() => _RentalFleetScreenState();
}

class _RentalFleetScreenState extends State<RentalFleetScreen> {
  final List<Map<String, dynamic>> _fleet = [
    {
      'id': 1,
      'type': 'Mountain Bike',
      'model': 'Trek X-Caliber',
      'rate': 25.0,
      'rateType': 'day',
      'available': true,
      'condition': 'Excellent',
      'image': Icons.pedal_bike,
    },
    {
      'id': 2,
      'type': 'SUV',
      'model': 'Toyota Land Cruiser',
      'rate': 120.0,
      'rateType': 'day',
      'available': false,
      'condition': 'Good',
      'image': Icons.directions_car,
    },
    {
      'id': 3,
      'type': 'Electric Scooter',
      'model': 'Xiaomi Pro 2',
      'rate': 15.0,
      'rateType': 'hour',
      'available': true,
      'condition': 'Excellent',
      'image': Icons.electric_scooter,
    },
    {
      'id': 4,
      'type': 'ATV',
      'model': 'Polaris Sportsman',
      'rate': 80.0,
      'rateType': 'day',
      'available': true,
      'condition': 'Good',
      'image': Icons.terrain,
    },
  ];

  final List<Map<String, dynamic>> _rentalHistory = [
    {
      'id': 1,
      'vehicle': 'Mountain Bike',
      'customer': 'Sarah Johnson',
      'startDate': DateTime.now().subtract(const Duration(days: 3)),
      'endDate': DateTime.now().subtract(const Duration(days: 1)),
      'revenue': 50.0,
    },
    {
      'id': 2,
      'vehicle': 'SUV',
      'customer': 'Ahmed Hassan',
      'startDate': DateTime.now().subtract(const Duration(days: 1)),
      'endDate': DateTime.now().add(const Duration(days: 2)),
      'revenue': 360.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/business_dashboard'),
        ),
        title: const Text('Rental Fleet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _showRentalHistory,
            tooltip: 'Rental History',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddVehicleDialog,
            tooltip: 'Add Vehicle',
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _fleet.length,
        itemBuilder: (context, index) {
          final vehicle = _fleet[index];
          return _buildVehicleCard(vehicle);
        },
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    final isAvailable = vehicle['available'];
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: AppTheme.lightBlueGray,
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      vehicle['image'],
                      size: 80,
                      color: AppTheme.primaryOrange,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isAvailable ? AppTheme.successGreen : AppTheme.errorRed,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isAvailable ? 'Available' : 'Rented',
                        style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle['type'],
                        style: AppTheme.titleMedium.copyWith(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        vehicle['model'],
                        style: AppTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${vehicle['rate'].toStringAsFixed(0)}/${vehicle['rateType']}',
                        style: AppTheme.titleMedium.copyWith(color: AppTheme.primaryOrange),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        color: AppTheme.primaryOrange,
                        onPressed: () => _showEditVehicleDialog(vehicle),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      IconButton(
                        icon: Icon(
                          isAvailable ? Icons.block : Icons.check_circle,
                          size: 20,
                        ),
                        color: AppTheme.primaryOrange,
                        onPressed: () {
                          setState(() {
                            vehicle['available'] = !vehicle['available'];
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isAvailable ? 'Vehicle marked as unavailable' : 'Vehicle marked as available',
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddVehicleDialog() {
    final typeController = TextEditingController();
    final modelController = TextEditingController();
    final rateController = TextEditingController();
    String selectedRateType = 'day';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Vehicle'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Vehicle Type'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: modelController,
                decoration: const InputDecoration(labelText: 'Model'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: rateController,
                decoration: const InputDecoration(labelText: 'Rate'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedRateType,
                decoration: const InputDecoration(labelText: 'Rate Type'),
                items: ['hour', 'day', 'week'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => selectedRateType = value!,
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
              if (typeController.text.isNotEmpty) {
                setState(() {
                  _fleet.add({
                    'id': _fleet.length + 1,
                    'type': typeController.text,
                    'model': modelController.text,
                    'rate': double.tryParse(rateController.text) ?? 0.0,
                    'rateType': selectedRateType,
                    'available': true,
                    'condition': 'Good',
                    'image': Icons.directions_car,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vehicle added successfully')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditVehicleDialog(Map<String, dynamic> vehicle) {
    final typeController = TextEditingController(text: vehicle['type']);
    final modelController = TextEditingController(text: vehicle['model']);
    final rateController = TextEditingController(text: vehicle['rate'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Vehicle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'Vehicle Type'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: modelController,
              decoration: const InputDecoration(labelText: 'Model'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: rateController,
              decoration: const InputDecoration(labelText: 'Rate'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _fleet.remove(vehicle);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vehicle deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: AppTheme.errorRed)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                vehicle['type'] = typeController.text;
                vehicle['model'] = modelController.text;
                vehicle['rate'] = double.tryParse(rateController.text) ?? vehicle['rate'];
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vehicle updated')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showRentalHistory() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rental History', style: AppTheme.titleLarge),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _rentalHistory.length,
                itemBuilder: (context, index) {
                  final rental = _rentalHistory[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(rental['vehicle'], style: AppTheme.titleMedium),
                              Text(
                                '\${rental['revenue'].toStringAsFixed(0)}',
                                style: AppTheme.titleMedium.copyWith(color: AppTheme.successGreen),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Customer: ${rental['customer']}', style: AppTheme.bodyMedium),
                          const SizedBox(height: 4),
                          Text(
                            'Period: ${_formatDate(rental['startDate'])} - ${_formatDate(rental['endDate'])}',
                            style: AppTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// lib/features/business/types/transportation/screens/route_management_screen.dart
class RouteManagementScreen extends StatefulWidget {
  const RouteManagementScreen({super.key});

  @override
  State<RouteManagementScreen> createState() => _RouteManagementScreenState();
}

class _RouteManagementScreenState extends State<RouteManagementScreen> {
  final List<Map<String, dynamic>> _routes = [
    {
      'id': 1,
      'name': 'Siwa to Marsa Matrouh',
      'distance': '300 km',
      'duration': '4 hours',
      'stops': ['Siwa Town', 'El Arish', 'Marsa Matrouh'],
      'schedule': ['08:00 AM', '02:00 PM', '06:00 PM'],
      'vehicle': 'Bus #101',
      'fare': 120.0,
    },
    {
      'id': 2,
      'name': 'Siwa Oasis Circuit',
      'distance': '50 km',
      'duration': '2 hours',
      'stops': ['Siwa Town', 'Cleopatra Spring', 'Shali Fortress', 'Fatnas Island'],
      'schedule': ['09:00 AM', '12:00 PM', '03:00 PM'],
      'vehicle': 'Van #205',
      'fare': 50.0,
    },
    {
      'id': 3,
      'name': 'Desert Safari Route',
      'distance': '120 km',
      'duration': '5 hours',
      'stops': ['Siwa Town', 'Great Sand Sea', 'Bir Wahed'],
      'schedule': ['07:00 AM', '01:00 PM'],
      'vehicle': '4x4 #302',
      'fare': 200.0,
    },
  ];

  final List<Map<String, dynamic>> _tripQueue = [
    {
      'id': 1,
      'route': 'Siwa Oasis Circuit',
      'time': '09:00 AM',
      'passengers': 8,
      'status': 'scheduled',
    },
    {
      'id': 2,
      'route': 'Siwa to Marsa Matrouh',
      'time': '02:00 PM',
      'passengers': 15,
      'status': 'in-progress',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/business_dashboard'),
        ),
        title: const Text('Route Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: _showTripQueue,
            tooltip: 'Trip Queue',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRouteDialog,
            tooltip: 'Add Route',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _routes.length,
        itemBuilder: (context, index) {
          final route = _routes[index];
          return _buildRouteCard(route);
        },
      ),
    );
  }

  Widget _buildRouteCard(Map<String, dynamic> route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Route Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(route['name'], style: AppTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        '${route['distance']} • ${route['duration']}',
                        style: AppTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Text(
                  '\${route['fare'].toStringAsFixed(0)}',
                  style: AppTheme.titleLarge.copyWith(color: AppTheme.primaryOrange),
                ),
              ],
            ),
          ),
          
          // Route Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.directions_bus, size: 20, color: AppTheme.gray),
                    const SizedBox(width: 8),
                    Text('Vehicle: ${route['vehicle']}', style: AppTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Stops:', style: AppTheme.titleMedium.copyWith(fontSize: 14)),
                const SizedBox(height: 8),
                ...route['stops'].asMap().entries.map((entry) {
                  final index = entry.key;
                  final stop = entry.value;
                  final isLast = index == route['stops'].length - 1;
                  
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: index == 0 
                                  ? AppTheme.successGreen 
                                  : isLast 
                                      ? AppTheme.errorRed 
                                      : AppTheme.primaryOrange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 24,
                              color: AppTheme.gray.withOpacity(0.3),
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(stop, style: AppTheme.bodyMedium),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 12),
                Text('Schedule:', style: AppTheme.titleMedium.copyWith(fontSize: 14)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: route['schedule'].map<Widget>((time) {
                    return Chip(
                      label: Text(time),
                      backgroundColor: AppTheme.primaryOrange.withOpacity(0.1),
                      labelStyle: AppTheme.bodySmall.copyWith(color: AppTheme.primaryOrange),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      color: AppTheme.primaryOrange,
                      onPressed: () => _showEditRouteDialog(route),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: AppTheme.errorRed,
                      onPressed: () => _confirmDeleteRoute(route),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddRouteDialog() {
    final nameController = TextEditingController();
    final distanceController = TextEditingController();
    final durationController = TextEditingController();
    final fareController = TextEditingController();
    final vehicleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Route'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Route Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: distanceController,
                decoration: const InputDecoration(labelText: 'Distance (e.g., 50 km)'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(labelText: 'Duration (e.g., 2 hours)'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: vehicleController,
                decoration: const InputDecoration(labelText: 'Vehicle'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: fareController,
                decoration: const InputDecoration(labelText: 'Fare'),
                keyboardType: TextInputType.number,
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
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _routes.add({
                    'id': _routes.length + 1,
                    'name': nameController.text,
                    'distance': distanceController.text,
                    'duration': durationController.text,
                    'stops': ['Start', 'End'],
                    'schedule': ['09:00 AM'],
                    'vehicle': vehicleController.text,
                    'fare': double.tryParse(fareController.text) ?? 0.0,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Route added successfully')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditRouteDialog(Map<String, dynamic> route) {
    final nameController = TextEditingController(text: route['name']);
    final fareController = TextEditingController(text: route['fare'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Route'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Route Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: fareController,
              decoration: const InputDecoration(labelText: 'Fare'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                route['name'] = nameController.text;
                route['fare'] = double.tryParse(fareController.text) ?? route['fare'];
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Route updated')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteRoute(Map<String, dynamic> route) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Route'),
        content: Text('Remove "${route['name']}" route?'),
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
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showTripQueue() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trip Queue', style: AppTheme.titleLarge),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _tripQueue.length,
                itemBuilder: (context, index) {
                  final trip = _tripQueue[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: trip['status'] == 'in-progress'
                              ? AppTheme.primaryOrange.withOpacity(0.1)
                              : AppTheme.successGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          trip['status'] == 'in-progress'
                              ? Icons.directions_bus
                              : Icons.schedule,
                          color: trip['status'] == 'in-progress'
                              ? AppTheme.primaryOrange
                              : AppTheme.successGreen,
                        ),
                      ),
                      title: Text(trip['route'], style: AppTheme.titleMedium.copyWith(fontSize: 14)),
                      subtitle: Text('${trip['time']} • ${trip['passengers']} passengers'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: trip['status'] == 'in-progress'
                              ? AppTheme.primaryOrange
                              : AppTheme.successGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          trip['status'] == 'in-progress' ? 'In Progress' : 'Scheduled',
                          style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}