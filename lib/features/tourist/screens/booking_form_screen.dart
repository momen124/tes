import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/booking.dart';
import '../../providers/offline_provider.dart';
import '../../../business/models/business.dart';
import '../../../utils/constants.dart';
import '../../../utils/date_formatter.dart';
import '../../../utils/currency_formatter.dart';
import '../../widgets/booking_forms/rental_booking_form.dart';
import '../../widgets/booking_forms/store_booking_form.dart';
import '../../widgets/booking_forms/restaurant_booking_form.dart';
import '../../widgets/booking_forms/transportation_booking_form.dart';
import '../../widgets/booking_forms/trip_booking_form.dart';
import '../../widgets/tourist_bottom_nav.dart';

class BookingFormScreen extends StatefulWidget {
  final Business business;
  final String serviceType;
  final Map<String, dynamic>? serviceData;

  const BookingFormScreen({
    Key? key,
    required this.business,
    required this.serviceType,
    this.serviceData,
  }) : super(key: key);

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late Widget _bookingForm;

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
      default:
        return _buildDefaultBookingForm();
    }
  }

  Widget _buildDefaultBookingForm() {
    DateTime? _selectedDate;
    int _adultCount = 2;
    int _childCount = 0;
    String _specialRequests = '';

    return Column(
      children: [
        // Service Header
        _buildServiceHeader(),
        const SizedBox(height: 24),
        
        // Date Selection
        _buildDateSelection(_selectedDate, (date) {
          setState(() => _selectedDate = date);
        }),
        const SizedBox(height: 24),
        
        // Guest Selection
        _buildGuestSelection(_adultCount, _childCount, (adults, children) {
          setState(() {
            _adultCount = adults;
            _childCount = children;
          });
        }),
        const SizedBox(height: 24),
        
        // Special Requests
        _buildSpecialRequests(_specialRequests, (value) {
          setState(() => _specialRequests = value);
        }),
        const SizedBox(height: 32),
        
        // Payment Summary
        _buildPaymentSummary(_adultCount, _childCount),
      ],
    );
  }

  Widget _buildServiceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.business.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.business.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelection(DateTime? selectedDate, Function(DateTime) onDateSelected) {
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
        // Week days header
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
        // Calendar rows
        _buildCalendarRow(['', '', '', '1', '2', '3', '4']),
        _buildCalendarRow(['5', '6', '7', '8', '9', '10', '11']),
        _buildCalendarRow(['12', '13', '14', '15', '16', '17', '18']),
        _buildCalendarRow(['19', '20', '21', '22', '23', '24', '25']),
        _buildCalendarRow(['26', '27', '28', '29', '30', '31', '']),
      ],
    );
  }

  TableRow _buildCalendarRow(List<String> days) {
    return TableRow(
      children: days.map((day) => _CalendarCell(day)).toList(),
    );
  }

  Widget _buildGuestSelection(int adultCount, int childCount, Function(int, int) onCountChanged) {
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
          (value) => onCountChanged(value, childCount),
        ),
        const SizedBox(height: 16),
        _buildGuestCounter(
          'Children',
          'Age 2-12',
          childCount,
          (value) => onCountChanged(adultCount, value),
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
                backgroundColor: AppColors.primary.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecialRequests(String value, Function(String) onChanged) {
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
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildPaymentSummary(int adultCount, int childCount) {
    final currencyFormatter = CurrencyFormatter();
    final servicePrice = 200; // Example price
    final serviceFee = 10; // Example fee
    final total = servicePrice + serviceFee;

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
          _buildPaymentRow('Desert Safari (${adultCount} Adults)', currencyFormatter.format(servicePrice)),
          const SizedBox(height: 8),
          _buildPaymentRow('Service Fee', currencyFormatter.format(serviceFee)),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          _buildPaymentRow('Total', currencyFormatter.format(total), isTotal: true),
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
            color: isTotal ? AppColors.primary : Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.primary : Colors.black,
          ),
        ),
      ],
    );
  }

  void _updateFormData(Map<String, dynamic> formData) {
    // Handle form data updates if needed
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate()) {
      // Navigate to confirmation screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen(
            booking: Booking(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              businessId: widget.business.id,
              serviceType: widget.serviceType,
              date: DateTime.now(),
              adultCount: 2,
              childCount: 0,
              specialRequests: '',
              totalPrice: 210,
              status: 'pending',
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = Provider.of<OfflineProvider>(context).isOnline;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Form'),
        backgroundColor: AppColors.primary,
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
      bottomNavigationBar: const TouristBottomNavBar(),
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
              side: BorderSide(color: AppColors.primary),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _confirmBooking,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
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
          color: day.isEmpty ? Colors.transparent : 
                 isHeader ? Colors.grey[600] : Colors.black,
        ),
      ),
    );
  }
}