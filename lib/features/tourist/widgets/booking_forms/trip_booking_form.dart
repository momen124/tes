import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TripBookingForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onFormDataChanged;

  const TripBookingForm({
    super.key,
    required this.onFormDataChanged,
  });

  @override
  _TripBookingFormState createState() => _TripBookingFormState();
}

class _TripBookingFormState extends State<TripBookingForm> {
  int _guestCount = 2;
  String _mealPreference = 'vegetarian';
  double _depositPercentage = 50.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Selection with Dual Calendar
        _buildDualCalendar(),
        const SizedBox(height: 24),
        
        // Guest Count
        _buildGuestSelection(),
        const SizedBox(height: 24),
        
        // Meal Preference
        _buildMealPreference(),
        const SizedBox(height: 24),
        
        // Deposit
        _buildDepositSelection(),
      ],
    );
  }

  Widget _buildDualCalendar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Dates',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildMonthCalendar('October 2024')),
            const SizedBox(width: 16),
            Expanded(child: _buildMonthCalendar('November 2024')),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthCalendar(String monthYear) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            monthYear,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          _buildCalendarGrid(),
        ],
      ),
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
        _buildCalendarRow(['', '', '', '', '', '', '1']),
        _buildCalendarRow(['2', '3', '4', '5', '6', '7', '8']),
        _buildCalendarRow(['9', '10', '11', '12', '13', '14', '15']),
        _buildCalendarRow(['16', '17', '18', '19', '20', '21', '22']),
        _buildCalendarRow(['23', '24', '25', '26', '27', '28', '29']),
        _buildCalendarRow(['30', '', '', '', '', '', '']),
      ],
    );
  }

  TableRow _buildCalendarRow(List<String> days) {
    return TableRow(
      children: days.map((day) => _CalendarCell(day)).toList(),
    );
  }

  Widget _buildGuestSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Guests',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Number of Guests'.tr()),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _guestCount > 1 ? () => setState(() {
                    _guestCount--;
                    _updateFormData();
                  }) : null,
                ),
                Text(
                  '$_guestCount',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() {
                    _guestCount++;
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

  Widget _buildMealPreference() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Meal Preference',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _mealPreference,
          items: [
            DropdownMenuItem(value: 'vegetarian', child: Text('Vegetarian'.tr())),
            DropdownMenuItem(value: 'non-vegetarian', child: Text('Non-Vegetarian'.tr())),
            DropdownMenuItem(value: 'vegan', child: Text('Vegan'.tr())),
          ],
          onChanged: (value) => setState(() {
            _mealPreference = value!;
            _updateFormData();
          }),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildDepositSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Deposit',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Deposit Percentage'.tr()),
            Text(
              '${_depositPercentage.toInt()}%',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Slider(
          value: _depositPercentage,
          min: 0,
          max: 100,
          divisions: 4,
          onChanged: (value) => setState(() {
            _depositPercentage = value;
            _updateFormData();
          }),
        ),
      ],
    );
  }

  void _updateFormData() {
    widget.onFormDataChanged({
      'guestCount': _guestCount,
      'mealPreference': _mealPreference,
      'depositPercentage': _depositPercentage,
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
      height: 32,
      alignment: Alignment.center,
      child: Text(
        day,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: day.isEmpty ? Colors.transparent : 
                 isHeader ? Colors.grey[600] : Colors.black,
        ),
      ),
    );
  }
}