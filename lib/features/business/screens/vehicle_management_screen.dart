import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';

class VehicleManagementScreen extends StatefulWidget {
  const VehicleManagementScreen({super.key});

  @override
  State<VehicleManagementScreen> createState() => _VehicleManagementScreenState();
}

class _VehicleManagementScreenState extends State<VehicleManagementScreen> {
  final List<Map<String, dynamic>> _vehicles = [
    {
      'id': 1,
      'type': 'SUV',
      'licensePlate': 'ABC 123',
      'driver': 'Omar Hassan',
      'driverVerified': true,
      'rate': 50.0,
      'routes': 'Oasis Circuit, Desert Safari',
      'image': Icons.directions_car,
    },
    {
      'id': 2,
      'type': 'Van',
      'licensePlate': 'XYZ 456',
      'driver': 'Layla Ali',
      'driverVerified': true,
      'rate': 45.0,
      'routes': 'Airport Transfer',
      'image': Icons.airport_shuttle,
    },
    {
      'id': 3,
      'type': 'Jeep',
      'licensePlate': 'DEF 789',
      'driver': 'Karim Ahmed',
      'driverVerified': true,
      'rate': 70.0,
      'routes': 'Great Sand Sea Expedition',
      'image': Icons.terrain,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2C2C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Vehicle Management',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Your Vehicles',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Vehicles List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = _vehicles[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  color: const Color(0xFF3A3A3A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Vehicle Image
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A4A4A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            vehicle['image'],
                            size: 50,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Vehicle Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle['type'],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'License Plate:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                vehicle['licensePlate'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Driver: ${vehicle['driver']}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  if (vehicle['driverVerified'])
                                    const Icon(
                                      Icons.verified,
                                      size: 16,
                                      color: AppTheme.primaryOrange,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rate: \$${vehicle['rate'].toStringAsFixed(0)}/day',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Routes: ${vehicle['routes']}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        
                        // Action Buttons
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              color: AppTheme.primaryOrange,
                              onPressed: () {
                                _showEditVehicleDialog(vehicle);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              color: AppTheme.errorRed,
                              onPressed: () {
                                _showDeleteConfirmation(vehicle);
                              },
                            ),
                          ],
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
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: FloatingActionButton.extended(
          onPressed: () {
            _showAddVehicleDialog();
          },
          backgroundColor: AppTheme.primaryOrange,
          icon: const Icon(Icons.add),
          label: const Text(
            'Add Vehicle',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/business_dashboard');
              break;
            case 1:
              // Search
              break;
            case 2:
              // Vehicles (current)
              break;
            case 3:
              // Profile
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined),
            activeIcon: Icon(Icons.directions_car),
            label: 'Vehicles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.gray,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.white,
      ),
    );
  }

  void _showEditVehicleDialog(Map<String, dynamic> vehicle) {
    final typeController = TextEditingController(text: vehicle['type']);
    final plateController = TextEditingController(text: vehicle['licensePlate']);
    final driverController = TextEditingController(text: vehicle['driver']);
    final rateController = TextEditingController(text: vehicle['rate'].toString());
    final routesController = TextEditingController(text: vehicle['routes']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Vehicle'),
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
                controller: plateController,
                decoration: const InputDecoration(labelText: 'License Plate'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: driverController,
                decoration: const InputDecoration(labelText: 'Driver Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: rateController,
                decoration: const InputDecoration(labelText: 'Rate per Day'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: routesController,
                decoration: const InputDecoration(labelText: 'Routes'),
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
              setState(() {
                vehicle['type'] = typeController.text;
                vehicle['licensePlate'] = plateController.text;
                vehicle['driver'] = driverController.text;
                vehicle['rate'] = double.tryParse(rateController.text) ?? vehicle['rate'];
                vehicle['routes'] = routesController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vehicle updated successfully')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddVehicleDialog() {
    final typeController = TextEditingController();
    final plateController = TextEditingController();
    final driverController = TextEditingController();
    final rateController = TextEditingController();
    final routesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Vehicle'),
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
                controller: plateController,
                decoration: const InputDecoration(labelText: 'License Plate'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: driverController,
                decoration: const InputDecoration(labelText: 'Driver Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: rateController,
                decoration: const InputDecoration(labelText: 'Rate per Day'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: routesController,
                decoration: const InputDecoration(labelText: 'Routes'),
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
              if (typeController.text.isNotEmpty &&
                  plateController.text.isNotEmpty) {
                setState(() {
                  _vehicles.add({
                    'id': _vehicles.length + 1,
                    'type': typeController.text,
                    'licensePlate': plateController.text,
                    'driver': driverController.text,
                    'driverVerified': true,
                    'rate': double.tryParse(rateController.text) ?? 50.0,
                    'routes': routesController.text,
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

  void _showDeleteConfirmation(Map<String, dynamic> vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Vehicle'),
        content: Text('Are you sure you want to delete ${vehicle['licensePlate']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _vehicles.remove(vehicle);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vehicle deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}