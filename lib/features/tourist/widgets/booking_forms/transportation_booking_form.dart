import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TransportationBookingForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onFormDataChanged;

  const TransportationBookingForm({super.key, required this.onFormDataChanged});

  @override
  _TransportationBookingFormState createState() =>
      _TransportationBookingFormState();
}

class _TransportationBookingFormState extends State<TransportationBookingForm> {
  TimeOfDay? _selectedTime;
  int _seatCount = 2;
  String? _selectedRoute;
  String? _photoIdPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Book Transportation',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),

        // Time Selection
        _buildTimeSelection(),
        const SizedBox(height: 24),

        // Number of Seats
        _buildSeatSelection(),
        const SizedBox(height: 24),

        // Route Selection
        _buildRouteSelection(),
        const SizedBox(height: 24),

        // Photo ID Upload
        _buildPhotoIdUpload(),
      ],
    );
  }

  Widget _buildTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: Text(
            _selectedTime != null
                ? _selectedTime!.format(context)
                : 'Select Time',
          ),
          trailing: const Icon(Icons.access_time),
          onTap: _selectTime,
        ),
      ],
    );
  }

  Widget _buildSeatSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Number of Seats',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('business.vehicles.seats'.tr()),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _seatCount > 1
                      ? () => setState(() {
                          _seatCount--;
                          _updateFormData();
                        })
                      : null,
                ),
                Text(
                  '$_seatCount',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() {
                    _seatCount++;
                    _updateFormData();
                  }),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRouteSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Route',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _selectedRoute,
          items: [
            DropdownMenuItem(
              value: 'route1',
              child: Text('business.profile.set_location'.tr()),
            ),
            DropdownMenuItem(
              value: 'route2',
              child: Text('Siwa to Alexandria'.tr()),
            ),
            DropdownMenuItem(value: 'route3', child: Text('tourist.categories.tours'.tr())),
          ],
          onChanged: (value) => setState(() {
            _selectedRoute = value;
            _updateFormData();
          }),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'business.rental.select_room_type'.tr(),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoIdUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photo ID',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _uploadPhotoId,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _photoIdPath != null
                ? Image.network(_photoIdPath!, fit: BoxFit.cover)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('business.rental.photo_upload_hint'.tr()),
                      SizedBox(height: 4),
                      Text(
                        'PNG, JPG or PDF (MAX.800x400px)',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
        _updateFormData();
      });
    }
  }

  void _uploadPhotoId() {
    // Implement photo upload logic
  }

  void _updateFormData() {
    widget.onFormDataChanged({
      'time': _selectedTime?.format(context),
      'seatCount': _seatCount,
      'route': _selectedRoute,
      'photoIdPath': _photoIdPath,
    });
  }
}
