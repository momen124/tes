import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RestaurantBookingForm extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  final Function(Map<String, dynamic>) onFormDataChanged;

  const RestaurantBookingForm({
    super.key,
    required this.restaurant,
    required this.onFormDataChanged,
  });

  @override
  _RestaurantBookingFormState createState() => _RestaurantBookingFormState();
}

class _RestaurantBookingFormState extends State<RestaurantBookingForm> {
  TimeOfDay? _deliveryTime;
  final TextEditingController _specialRequestsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _specialRequestsController.addListener(_updateFormData);
  }

  @override
  void dispose() {
    _specialRequestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant Info
        _buildRestaurantInfo(),
        const SizedBox(height: 24),
        
        // Delivery Time
        _buildDeliveryTime(),
        const SizedBox(height: 24),
        
        // Special Requests
        _buildSpecialRequests(),
      ],
    );
  }

  Widget _buildRestaurantInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aghurmi Restaurant',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Authentic Siwan Cuisine',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Siwa Oasis',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery Time',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: Text(
            _deliveryTime != null 
                ? _deliveryTime!.format(context)
                : 'Select Time',
          ),
          trailing: const Icon(Icons.access_time),
          onTap: _selectDeliveryTime,
        ),
      ],
    );
  }

  Widget _buildSpecialRequests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Special Requests',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _specialRequestsController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Any dietary restrictions or preferences?'.tr(),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDeliveryTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _deliveryTime = time;
        _updateFormData();
      });
    }
  }

  void _updateFormData() {
    widget.onFormDataChanged({
      'deliveryTime': _deliveryTime?.format(context),
      'specialRequests': _specialRequestsController.text,
    });
  }
}