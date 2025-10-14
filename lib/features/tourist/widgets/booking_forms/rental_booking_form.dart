import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RentalBookingForm extends StatefulWidget {
  final Map<String, dynamic> rental;
  final Function(Map<String, dynamic>) onFormDataChanged;

  const RentalBookingForm({
    super.key,
    required this.rental,
    required this.onFormDataChanged,
  });

  @override
  _RentalBookingFormState createState() => _RentalBookingFormState();
}

class _RentalBookingFormState extends State<RentalBookingForm> {
  String _selectedMileage = 'unlimited';
  bool _includeInsurance = false;
  bool _includePhotoId = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rental Header
        _buildRentalHeader(),
        const SizedBox(height: 24),

        // Date Selection
        _buildDateSelection(),
        const SizedBox(height: 24),

        // Mileage Options
        _buildMileageOptions(),
        const SizedBox(height: 24),

        // Add-ons
        _buildAddons(),
      ],
    );
  }

  Widget _buildRentalHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Siva Oasis Rental',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.rental['description'] ??
              'Explore the beauty of Siva with our reliable rental services.',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Show rental details
          },
          child: Text('common.details'.tr()),
        ),
      ],
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Dates',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Calendar header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {},
                  ),
                  const Text(
                    'October 2024',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Calendar grid
              _buildCalendarGrid(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    return Table(
      children: [
        const TableRow(
          children: [
            _CalendarCell('S', isHeader: true),
            _CalendarCell('M', isHeader: true),
            _CalendarCell('T', isHeader: true),
            _CalendarCell('W', isHeader: true),
            _CalendarCell('T', isHeader: true),
            _CalendarCell('F', isHeader: true),
            _CalendarCell('S', isHeader: true),
          ],
        ),
        _buildCalendarRow(['', '', '', '1', '2', '3', '4']),
        _buildCalendarRow(['5', '6', '7', '8', '9', '10', '11']),
        _buildCalendarRow(['12', '13', '14', '15', '16', '17', '18']),
        _buildCalendarRow(['19', '20', '21', '22', '23', '24', '25']),
        _buildCalendarRow(['26', '27', '28', '29', '30', '31', '']),
      ],
    );
  }

  TableRow _buildCalendarRow(List<String> days) {
    return TableRow(children: days.map((day) => _CalendarCell(day)).toList());
  }

  Widget _buildMileageOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mileage',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            _buildMileageOption('Range', 'range'),
            _buildMileageOption('Unlimited', 'unlimited'),
          ],
        ),
      ],
    );
  }

  Widget _buildMileageOption(String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Radio<String>(
        value: value,
        groupValue: _selectedMileage,
        onChanged: (String? newValue) {
          setState(() {
            _selectedMileage = newValue!;
            _updateFormData();
          });
        },
      ),
      title: Text(title),
      onTap: () {
        setState(() {
          _selectedMileage = value;
          _updateFormData();
        });
      },
    );
  }

  Widget _buildAddons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add-ons',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            _buildAddonOption('Insurance', _includeInsurance, (value) {
              setState(() {
                _includeInsurance = value;
                _updateFormData();
              });
            }),
            _buildAddonOption('Photo ID', _includePhotoId, (value) {
              setState(() {
                _includePhotoId = value;
                _updateFormData();
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildAddonOption(String title, bool value, Function(bool) onChanged) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: (bool? newValue) {
        onChanged(newValue ?? false);
      },
    );
  }

  void _updateFormData() {
    widget.onFormDataChanged({
      'mileage': _selectedMileage,
      'insurance': _includeInsurance,
      'photoId': _includePhotoId,
    });
  }
}

class _CalendarCell extends StatelessWidget {
  final String day;
  final bool isHeader;

  const _CalendarCell(this.day, {this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: Text(
        day,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: day.isEmpty
              ? Colors.transparent
              : isHeader
              ? Colors.grey[600]
              : Colors.black,
        ),
      ),
    );
  }
}
