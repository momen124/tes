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
                initialValue: selectedRateType,
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
                                '\$${rental["revenue"].toStringAsFixed(0)}',
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
