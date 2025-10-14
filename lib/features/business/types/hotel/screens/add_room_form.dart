import 'package:flutter/material.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/widgets/dashed_border_container.dart';
import 'package:easy_localization/easy_localization.dart';

class AddRoomForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onRoomAdded;

  const AddRoomForm({
    super.key,
    required this.onRoomAdded,
  });

  @override
  State<AddRoomForm> createState() => _AddRoomFormState();
}

class _AddRoomFormState extends State<AddRoomForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String? _selectedRoomType;
  double _price = 150.0;
  int _capacity = 2;
  bool _available = true;

  // Room type options with descriptions
  final List<Map<String, String>> _roomTypes = [
    {'value': 'single', 'label': 'Single Room', 'icon': '🛏️'},
    {'value': 'double', 'label': 'Double Room', 'icon': '🛏️🛏️'},
    {'value': 'twin', 'label': 'Twin Room', 'icon': '👥'},
    {'value': 'suite', 'label': 'Suite', 'icon': '🏨'},
    {'value': 'deluxe', 'label': 'Deluxe Suite', 'icon': '✨'},
    {'value': 'family', 'label': 'Family Room', 'icon': '👨‍👩‍👧‍👦'},
    {'value': 'presidential', 'label': 'Presidential Suite', 'icon': '👑'},
  ];

  // Add-ons with quantities
  final Map<String, int> _addOns = {
    'Extra Bed': 0,
    'Breakfast': 0,
    'Airport Transfer': 0,
    'Mini Bar': 0,
  };

  final Map<String, double> _addOnPrices = {
    'Extra Bed': 20.0,
    'Breakfast': 15.0,
    'Airport Transfer': 30.0,
    'Mini Bar': 10.0,
  };

  double get _totalPrice {
    double total = _price;
    _addOns.forEach((name, quantity) {
      total += (_addOnPrices[name] ?? 0.0) * quantity;
    });
    return total;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add New Room'.tr(), style: AppTheme.titleLarge),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Room Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Room Name'.tr(),
                  hintText: 'e.g., Ocean View Suite 101'.tr(),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a room name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Room Type Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedRoomType,
                decoration: InputDecoration(
                  labelText: 'Room Type'.tr(),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.hotel),
                ),
                hint: Text('Select room type'.tr()),
                items: _roomTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type['value'],
                    child: Row(
                      children: [
                        Text(
                          type['icon']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 12),
                        Text(type['label']!),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedRoomType = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a room type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Price Slider
              Text(
                'Price per night: \$${_price.toInt()}',
                style: AppTheme.titleMedium,
              ),
              Slider(
                value: _price,
                min: 50,
                max: 1000,
                divisions: 95,
                label: '\$${_price.toInt()}'.tr(),
                activeColor: AppTheme.primaryOrange,
                onChanged: (val) => setState(() => _price = val),
              ),
              const SizedBox(height: 16),

              // Capacity Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Guest Capacity'.tr(), style: AppTheme.titleMedium),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.gray.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_capacity > 1) {
                              setState(() => _capacity--);
                            }
                          },
                          icon: const Icon(Icons.remove),
                          color: _capacity > 1 ? AppTheme.primaryOrange : AppTheme.gray,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '$_capacity',
                            style: AppTheme.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (_capacity < 10) {
                              setState(() => _capacity++);
                            }
                          },
                          icon: const Icon(Icons.add),
                          color: _capacity < 10 ? AppTheme.primaryOrange : AppTheme.gray,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Add-ons Section
              Text('Add-ons (Optional)'.tr(), style: AppTheme.titleMedium),
              const SizedBox(height: 12),
              ..._addOns.keys.map((addOn) => _buildAddOnRow(addOn)),
              const SizedBox(height: 20),

              // Total Price Display
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.lightBlueGray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Base Price'.tr(), style: AppTheme.bodyMedium),
                        Text(
                          '\$${_price.toInt()}/night',
                          style: AppTheme.bodySmall.copyWith(color: AppTheme.gray),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Total with Add-ons'.tr(), style: AppTheme.bodyMedium),
                        Text(
                          '\$${_totalPrice.toInt()}/night',
                          style: AppTheme.titleMedium.copyWith(
                            color: AppTheme.primaryOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Photo Upload - Now using the reusable widget
              Text('Room Photo'.tr(), style: AppTheme.titleMedium),
              const SizedBox(height: 8),
              DashedBorderContainer(
                color: AppTheme.gray,
                strokeWidth: 2,
                dashWidth: 8,
                dashSpace: 4,
                borderRadius: 12,
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.lightBlueGray.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_upload, size: 40, color: AppTheme.gray),
                      const SizedBox(height: 8),
                      Text(
                        'Click to upload or drag and drop',
                        style: AppTheme.bodyMedium.copyWith(color: AppTheme.gray),
                      ),
                      Text(
                        'PNG, JPG (MAX. 1920x1080px)',
                        style: AppTheme.bodySmall.copyWith(color: AppTheme.gray),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Availability Toggle
              SwitchListTile(
                title: Text('Available for Booking'.tr(), style: AppTheme.titleMedium),
                subtitle: Text(
                  _available ? 'Guests can book this room' : 'Room is unavailable',
                  style: AppTheme.bodySmall,
                ),
                value: _available,
                activeThumbColor: AppTheme.primaryOrange,
                onChanged: (val) => setState(() => _available = val),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description'.tr(),
                  hintText: 'Describe the room amenities and features...'.tr(),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  if (value.trim().length < 20) {
                    return 'Description must be at least 20 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppTheme.gray),
                      ),
                      child: Text('Cancel'.tr()),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryOrange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Add Room',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddOnRow(String addOn) {
    final quantity = _addOns[addOn] ?? 0;
    final price = _addOnPrices[addOn] ?? 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.gray.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(addOn, style: AppTheme.bodyMedium),
                Text(
                  '+\$${price.toInt()} each',
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.gray),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.lightBlueGray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 0) {
                      setState(() => _addOns[addOn] = quantity - 1);
                    }
                  },
                  icon: const Icon(Icons.remove, size: 20),
                  color: quantity > 0 ? AppTheme.primaryOrange : AppTheme.gray,
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  padding: EdgeInsets.zero,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '$quantity',
                    style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (quantity < 10) {
                      setState(() => _addOns[addOn] = quantity + 1);
                    }
                  },
                  icon: const Icon(Icons.add, size: 20),
                  color: quantity < 10 ? AppTheme.primaryOrange : AppTheme.gray,
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Get selected room type label
      final roomTypeLabel = _roomTypes
          .firstWhere((type) => type['value'] == _selectedRoomType)['label'];

      // Prepare room data
      final roomData = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'name': _nameController.text.trim(),
        'type': roomTypeLabel,
        'typeValue': _selectedRoomType,
        'price': _price,
        'capacity': _capacity,
        'available': _available,
        'description': _descriptionController.text.trim(),
        'addOns': Map.from(_addOns)..removeWhere((key, value) => value == 0),
        'totalPrice': _totalPrice,
        'photos': [], // Will be populated when photo upload is implemented
        'amenities': _buildDefaultAmenities(),
        'createdAt': DateTime.now().toIso8601String(),
      };

      // Call the callback with room data
      widget.onRoomAdded(roomData);

      // Close the form
      Navigator.pop(context);
    }
  }

  List<String> _buildDefaultAmenities() {
    List<String> amenities = ['WiFi', 'AC', 'TV'];
    
    if (_addOns['Mini Bar']! > 0) amenities.add('Mini Bar');
    if (_addOns['Breakfast']! > 0) amenities.add('Breakfast Included');
    
    // Add amenities based on room type
    switch (_selectedRoomType) {
      case 'suite':
      case 'deluxe':
      case 'presidential':
        amenities.addAll(['Balcony', 'Bathtub', 'Room Service']);
        break;
      case 'family':
        amenities.addAll(['Kitchen', 'Living Area']);
        break;
    }
    
    return amenities;
  }
}

// DashedBorderPainter class removed - now in separate file