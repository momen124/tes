import 'package:siwa/data/mock_data_repository.dart';
// lib/features/business/types/rental/screens/rental_fleet_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';

class RentalFleetScreen extends ConsumerStatefulWidget {
  const RentalFleetScreen({super.key});

  @override
  ConsumerState<RentalFleetScreen> createState() => _RentalFleetScreenState();
}

class _RentalFleetScreenState extends ConsumerState<RentalFleetScreen> {
  late ConfettiController _confettiController;
  

  

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

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: isOffline ? null : () => context.go('/business_dashboard'),
        ),
        title: Text('Rental Fleet'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: isOffline ? null : _showRentalHistory,
            tooltip: 'Rental History'.tr(),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: isOffline ? null : _showAddVehicleDialog,
            tooltip: 'Add Vehicle'.tr(),
          ),
        ],
      ),
      body: isOffline
          ? Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: AppTheme.offlineBanner,
                child: const Text(
                  'Offline',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: mockData.getAllOther().length,
              itemBuilder: (context, index) {
                final vehicle = mockData.getAllOther()[index];
                return _buildVehicleCard(vehicle).animate().fadeIn();
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
                        '\$${(double.tryParse((vehicle['rate'] ?? 0).toString()) ?? 0).toStringAsFixed(0)}/${vehicle['rateType'] ?? 0}',
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
                        onPressed: ref.watch(offlineProvider) ? null : () => _showEditVehicleDialog(vehicle),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      IconButton(
                        icon: Icon(
                          isAvailable ? Icons.block : Icons.check_circle,
                          size: 20,
                        ),
                        color: AppTheme.primaryOrange,
                        onPressed: ref.watch(offlineProvider)
                            ? null
                            : () {
                                setState(() => vehicle['available'] = !vehicle['available']);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isAvailable ? 'Vehicle marked as unavailable' : 'Vehicle marked as available',
                                    ),
                                  ),
                                );
                                _confettiController.play();
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
    final formKey = GlobalKey<FormState>();
    final typeController = TextEditingController();
    final modelController = TextEditingController();
    final rateController = TextEditingController();
    String selectedRateType = 'day';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Vehicle'.tr()),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'Vehicle Type'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter vehicle type' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: modelController,
                  decoration: InputDecoration(labelText: 'Model'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter model' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: rateController,
                  decoration: InputDecoration(labelText: 'Rate'.tr()),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter rate' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedRateType,
                  decoration: InputDecoration(labelText: 'Rate Type'.tr()),
                  items: ['hour', 'day', 'week'].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) => setState(() => selectedRateType = value!),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  mockData.getAllOther().add({
                    'id': mockData.getAllOther().length + 1,
                    'type': typeController.text,
                    'model': modelController.text,
                    'rate': double.tryParse(rateController.text) ?? 0.0,
                    'rateType': selectedRateType,
                    'available': true,
                    'condition': 'Good',
                    'image': _getVehicleIcon(typeController.text),
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Vehicle added successfully'.tr())),
                );
                _confettiController.play();
              }
            },
            child: Text('Add'.tr()),
          ),
        ],
      ),
    );
  }

  void _showEditVehicleDialog(Map<String, dynamic> vehicle) {
    final formKey = GlobalKey<FormState>();
    final typeController = TextEditingController(text: vehicle['type']);
    final modelController = TextEditingController(text: vehicle['model']);
    final rateController = TextEditingController(text: (vehicle['rate'] ?? 0).toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Vehicle'.tr()),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Vehicle Type'.tr()),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter vehicle type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: modelController,
                decoration: InputDecoration(labelText: 'Model'.tr()),
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter model' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: rateController,
                decoration: InputDecoration(labelText: 'Rate'.tr()),
                keyboardType: TextInputType.number,
                validator: (value) => (value?.isEmpty ?? true) ? 'Enter rate' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => mockData.getAllOther().remove(vehicle));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Vehicle deleted'.tr())),
              );
              _confettiController.play();
            },
            child: Text('Delete'.tr(), style: const TextStyle(color: AppTheme.errorRed)),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  vehicle['type'] = typeController.text;
                  vehicle['model'] = modelController.text;
                  vehicle['rate'] = double.tryParse(rateController.text) ?? vehicle['rate'];
                  vehicle['image'] = _getVehicleIcon(typeController.text);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Vehicle updated'.tr())),
                );
                _confettiController.play();
              }
            },
            child: Text('Save'.tr()),
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
                  Text('Rental History'.tr(), style: AppTheme.titleLarge),
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
                itemCount: mockData.getAllOther().length,
                itemBuilder: (context, index) {
                  final rental = mockData.getAllOther()[index];
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
                                '\$${(double.tryParse(rental['revenue']?.toString() ?? '') ?? 0).toStringAsFixed(0)}',
                                style: AppTheme.titleMedium.copyWith(color: AppTheme.successGreen),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Customer: ${rental['.tr()customer']}', style: AppTheme.bodyMedium),
                          const SizedBox(height: 4),
                          Text(
                            'Period: ${_formatDate(rental['startDate'])} - ${_formatDate(rental['endDate'])}',
                            style: AppTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getVehicleIcon(String type) {
    switch (type.toLowerCase()) {
      case 'mountain bike':
        return Icons.pedal_bike;
      case 'suv':
        return Icons.directions_car;
      case 'electric scooter':
        return Icons.electric_scooter;
      case 'atv':
        return Icons.terrain;
      default:
        return Icons.directions_car;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}