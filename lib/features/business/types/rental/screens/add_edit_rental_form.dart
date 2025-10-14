// lib/features/business/types/rental/screens/add_edit_rental_form.dart
import 'package:flutter/material.dart';
import 'package:siwa/widgets/dashed_border_container.dart';
import 'package:easy_localization/easy_localization.dart';

// Vehicle Type Categories
enum VehicleCategory {
  cars,
  motorcycles,
  bicycles,
  others,
}

class VehicleType {
  final String name;
  final VehicleCategory category;
  final IconData icon;

  const VehicleType({
    required this.name,
    required this.category,
    required this.icon,
  });
}

class AddEditRentalForm extends StatefulWidget {
  const AddEditRentalForm({super.key});

  @override
  State<AddEditRentalForm> createState() => _AddEditRentalFormState();
}

class _AddEditRentalFormState extends State<AddEditRentalForm> {
  final _formKey = GlobalKey<FormState>();
  double _price = 50.0;
  int _capacity = 1;
  bool _available = true;
  VehicleType? _selectedVehicleType;

  // Vehicle types organized by category
  static const List<VehicleType> _vehicleTypes = [
    // Cars
    VehicleType(name: 'Sedan', category: VehicleCategory.cars, icon: Icons.directions_car),
    VehicleType(name: 'SUV', category: VehicleCategory.cars, icon: Icons.airport_shuttle),
    VehicleType(name: 'Hatchback', category: VehicleCategory.cars, icon: Icons.directions_car),
    VehicleType(name: 'Luxury', category: VehicleCategory.cars, icon: Icons.car_rental),
    
    // Motorcycles
    VehicleType(name: 'Scooter', category: VehicleCategory.motorcycles, icon: Icons.two_wheeler),
    VehicleType(name: 'Sport', category: VehicleCategory.motorcycles, icon: Icons.sports_motorsports),
    VehicleType(name: 'Cruiser', category: VehicleCategory.motorcycles, icon: Icons.motorcycle),
    
    // Bicycles
    VehicleType(name: 'Mountain', category: VehicleCategory.bicycles, icon: Icons.pedal_bike),
    VehicleType(name: 'Road', category: VehicleCategory.bicycles, icon: Icons.directions_bike),
    VehicleType(name: 'Electric', category: VehicleCategory.bicycles, icon: Icons.electric_bike),
    
    // Others
    VehicleType(name: 'ATV', category: VehicleCategory.others, icon: Icons.terrain),
    VehicleType(name: 'Buggy', category: VehicleCategory.others, icon: Icons.agriculture),
    VehicleType(name: 'Golf Cart', category: VehicleCategory.others, icon: Icons.golf_course),
  ];

  String _getCategoryName(VehicleCategory category) {
    switch (category) {
      case VehicleCategory.cars:
        return 'Cars';
      case VehicleCategory.motorcycles:
        return 'Motorcycles';
      case VehicleCategory.bicycles:
        return 'Bicycles';
      case VehicleCategory.others:
        return 'Others';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Rental Name with Vehicle Icon
              Row(
                children: [
                  if (_selectedVehicleType != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        _selectedVehicleType!.icon,
                        color: Colors.orange,
                        size: 28,
                      ),
                    ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Rental Name'.tr(),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a rental name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Vehicle Type Dropdown
              DropdownButtonFormField<VehicleType>(
                decoration: InputDecoration(
                  labelText: 'Vehicle Type'.tr(),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                initialValue: _selectedVehicleType,
                hint: Text('Select vehicle type'.tr()),
                isExpanded: true,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a vehicle type';
                  }
                  return null;
                },
                items: _buildDropdownItems(),
                onChanged: (VehicleType? newValue) {
                  setState(() {
                    _selectedVehicleType = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              
              // Price Slider
              Text('Price: \$${_price.toInt()}'.tr()),
              Slider(
                value: _price,
                min: 0,
                max: 200,
                divisions: 40,
                label: '\$${_price.toInt()}'.tr(),
                onChanged: (val) => setState(() => _price = val),
              ),
              
              // Capacity Control
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Capacity'.tr(), style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _capacity > 1
                            ? () => setState(() => _capacity--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$_capacity',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() => _capacity++),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Photo Upload
               Align(
                alignment: Alignment.centerLeft,
                child: Text('Photo'.tr(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 8),
            const DashedBorderContainer(
  color: Colors.grey,
  strokeWidth: 2,
  dashWidth: 8,
  dashSpace: 4,
  borderRadius: 8,
  child: SizedBox(
    height: 120,
    width: double.infinity,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey),
          SizedBox(height: 8),
          Text(
            'Click to upload or drag and drop',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            'SVG, PNG, JPG (MAX. 800x400px)',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    ),
  ),
),
              const SizedBox(height: 16),
              
              // Availability Switch
              SwitchListTile(
                title: Text('Available'.tr()),
                subtitle: Text(_available ? 'Currently available for rent' : 'Not available'),
                value: _available,
                activeThumbColor: Colors.orange,
                onChanged: (val) => setState(() => _available = val),
              ),
              const SizedBox(height: 16),
              
              // Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description'.tr(),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Cancel'.tr()),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save logic here
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<VehicleType>> _buildDropdownItems() {
    final items = <DropdownMenuItem<VehicleType>>[];
    VehicleCategory? currentCategory;

    for (var vehicleType in _vehicleTypes) {
      // Add category header when category changes
      if (currentCategory != vehicleType.category) {
        currentCategory = vehicleType.category;
        items.add(
          DropdownMenuItem<VehicleType>(
            enabled: false,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                _getCategoryName(vehicleType.category),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      }

      // Add vehicle type item
      items.add(
        DropdownMenuItem<VehicleType>(
          value: vehicleType,
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Row(
              children: [
                Icon(vehicleType.icon, size: 20, color: Colors.orange),
                const SizedBox(width: 12),
                Text(vehicleType.name),
              ],
            ),
          ),
        ),
      );
    }

    return items;
  }
}