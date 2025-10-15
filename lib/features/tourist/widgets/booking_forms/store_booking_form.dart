import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreBookingForm extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onFormDataChanged;

  const StoreBookingForm({
    super.key,
    required this.product,
    required this.onFormDataChanged,
  });

  @override
  _StoreBookingFormState createState() => _StoreBookingFormState();
}

class _StoreBookingFormState extends State<StoreBookingForm> {
  bool _isDelivery = true;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _notesController.addListener(_updateFormData);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Info
        _buildProductInfo(),
        const SizedBox(height: 24),
        
        // Delivery/Pickup Selection
        _buildDeliveryOptions(),
        const SizedBox(height: 24),
        
        // Notes
        _buildNotesSection(),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Siva Dates',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Delicious Siva dates, perfect for a healthy snack.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${widget.product['price'] ?? '100'} EGP',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery or Pickup',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDeliveryOption(
                'Delivery',
                Icons.delivery_dining,
                _isDelivery,
                () => setState(() {
                  _isDelivery = true;
                  _updateFormData();
                }),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDeliveryOption(
                'Pickup',
                Icons.store,
                !_isDelivery,
                () => setState(() {
                  _isDelivery = false;
                  _updateFormData();
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryOption(String title, IconData icon, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[50],
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add notes (e.g., gift wrap instructions)'.tr(),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  void _updateFormData() {
    widget.onFormDataChanged({
      'deliveryType': _isDelivery ? 'delivery' : 'pickup',
      'notes': _notesController.text,
    });
  }
}