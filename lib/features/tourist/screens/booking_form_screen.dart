import 'package:flutter/material.dart';
import 'package:siwa/features/business/models/business.dart';
import 'package:siwa/features/tourist/screens/booking_confirmation_screen.dart';
import 'package:siwa/features/tourist/widgets/booking_forms/rental_booking_form.dart';
import 'package:siwa/features/tourist/widgets/booking_forms/restaurant_booking_form.dart';
import 'package:siwa/features/tourist/widgets/booking_forms/store_booking_form.dart';
import 'package:siwa/features/tourist/widgets/booking_forms/transportation_booking_form.dart';
import 'package:siwa/features/tourist/widgets/booking_forms/trip_booking_form.dart';
// import 'package:siwa/features/tourist/widgets/booking_forms/attraction_booking_form.dart';
// import 'package:siwa/features/tourist/widgets/booking_forms/tourguide_booking_form.dart';
import '../../../utils/currency_formatter.dart';

class Booking {
  final String id;
  final String businessId;
  final String serviceType;
  final DateTime date;
  final int adultCount;
  final int childCount;
  final String specialRequests;
  final double totalPrice;
  final String status;

  Booking({
    required this.id,
    required this.businessId,
    required this.serviceType,
    required this.date,
    required this.adultCount,
    required this.childCount,
    required this.specialRequests,
    required this.totalPrice,
    required this.status,
  });
}

class BookingFormScreen extends StatefulWidget {
  final Business? business;
  final String serviceType;
  final Map<String, dynamic>? serviceData;

  const BookingFormScreen({
    super.key,
    this.business,
    required this.serviceType,
    this.serviceData,
  });

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late Widget _bookingForm;
  DateTime? selectedDate;
  int adultCount = 2;
  int childCount = 0;
  String specialRequests = '';
  DateTime displayedMonth = DateTime(2025, 10);

  @override
  void initState() {
    super.initState();
    _bookingForm = _buildBookingForm();
  }

  Widget _buildBookingForm() {
    switch (widget.serviceType) {
      case 'rental':
        return RentalBookingForm(
          rental: widget.serviceData ?? {},
          onFormDataChanged: _updateFormData,
        );
      case 'store':
        return StoreBookingForm(
          product: widget.serviceData ?? {},
          onFormDataChanged: _updateFormData,
        );
      case 'restaurant':
        return RestaurantBookingForm(
          restaurant: widget.serviceData ?? {},
          onFormDataChanged: _updateFormData,
        );
      case 'transportation':
        return TransportationBookingForm(
          onFormDataChanged: _updateFormData,
        );
      case 'trip':
        return TripBookingForm(
          onFormDataChanged: _updateFormData,
        );
      // case 'attraction':
      //   return AttractionBookingForm(
      //     attraction: widget.serviceData ?? {},
      //     onFormDataChanged: _updateFormData,
      //   );
      // case 'tourguide':
      //   return TourguideBookingForm(
      //     tourguide: widget.serviceData ?? {},
      //     onFormDataChanged: _updateFormData,
      //   );
      default:
        return _buildDefaultBookingForm();
    }
  }

  Widget _buildDefaultBookingForm() {
    return Column(
      children: [
        _buildServiceHeader(),
        const SizedBox(height: 24),
        _buildDateSelection(),
        const SizedBox(height: 24),
        _buildGuestSelection(),
        const SizedBox(height: 24),
        _buildSpecialRequests(),
        const SizedBox(height: 32),
        _buildPaymentSummary(),
      ],
    );
  }

  Widget _buildServiceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.business?.name ?? 'Default Business',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.business?.description ?? 'Default Description',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        displayedMonth = DateTime(displayedMonth.year, displayedMonth.month - 1);
                      });
                    },
                  ),
                  Text(
                    '${_monthName(displayedMonth.month)} ${displayedMonth.year}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      setState(() {
                        displayedMonth = DateTime(displayedMonth.year, displayedMonth.month + 1);
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildCalendarGrid(),
            ],
          ),
        ),
      ],
    );
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month, 1);
    final daysInMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday % 7; // Sunday = 0
    final days = List.generate(firstWeekday, (_) => '').followedBy(
      List.generate(daysInMonth, (i) => '${i + 1}'),
    ).toList();

    while (days.length % 7 != 0) {
      days.add('');
    }

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
        for (int i = 0; i < days.length; i += 7)
          _buildCalendarRow(days.sublist(i, i + 7)),
      ],
    );
  }

  TableRow _buildCalendarRow(List<String> days) {
    return TableRow(
      children: days.map((day) => _CalendarCell(
        day,
        onTap: day.isNotEmpty
            ? () {
                setState(() {
                  selectedDate = DateTime(displayedMonth.year, displayedMonth.month, int.parse(day));
                });
              }
            : null,
      )).toList(),
    );
  }

  Widget _buildGuestSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Number of Guests',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildGuestCounter(
          'Adults',
          'Age 13+',
          adultCount,
          (value) => setState(() => adultCount = value.clamp(0, 10)),
        ),
        const SizedBox(height: 16),
        _buildGuestCounter(
          'Children',
          'Age 2-12',
          childCount,
          (value) => setState(() => childCount = value.clamp(0, 10)),
        ),
      ],
    );
  }

  Widget _buildGuestCounter(String title, String subtitle, int count, Function(int) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, size: 20),
              onPressed: count > 0 ? () => onChanged(count - 1) : null,
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$count',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add, size: 20),
              onPressed: () => onChanged(count + 1),
              style: IconButton.styleFrom(
                backgroundColor: Colors.orange.withValues(alpha: 0.1),
              ),
            ),
          ],
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
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Any special requests?',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() => specialRequests = value),
        ),
      ],
    );
  }

  Widget _buildPaymentSummary() {
    const double servicePrice = 200.0; // Should be dynamic based on service
    const double serviceFee = 10.0; // Should be dynamic
    final double total = servicePrice * adultCount + serviceFee;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildPaymentRow(
            'Service ($adultCount Adults)',
            CurrencyFormatter.format(servicePrice * adultCount, context),
          ),
          const SizedBox(height: 8),
          _buildPaymentRow('Service Fee', CurrencyFormatter.format(serviceFee, context)),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          _buildPaymentRow('Total', CurrencyFormatter.format(total, context), isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.orange : Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.orange : Colors.black,
          ),
        ),
      ],
    );
  }

  void _updateFormData(Map<String, dynamic> formData) {
    setState(() {
      adultCount = formData['adultCount'] ?? adultCount;
      childCount = formData['childCount'] ?? childCount;
      specialRequests = formData['specialRequests'] ?? specialRequests;
      selectedDate = formData['date'] ?? selectedDate;
    });
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate()) {
      if (selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date')),
        );
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen(
            booking: Booking(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              businessId: widget.business?.id.toString() ?? 'default',
              serviceType: widget.serviceType,
              date: selectedDate!,
              adultCount: adultCount,
              childCount: childCount,
              specialRequests: specialRequests,
              totalPrice: 200.0 * adultCount + 10.0,
              status: 'pending',
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Form'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _bookingForm,
              const SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SizedBox(),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.orange),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _confirmBooking,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Confirm Booking',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _CalendarCell extends StatelessWidget {
  final String day;
  final bool isHeader;
  final VoidCallback? onTap;

  const _CalendarCell(this.day, {this.isHeader = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onTap != null && day.isNotEmpty ? Colors.grey[100] : null,
          borderRadius: BorderRadius.circular(4),
        ),
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
      ),
    );
  }
}