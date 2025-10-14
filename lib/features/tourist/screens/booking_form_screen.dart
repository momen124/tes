// lib/features/tourist/screens/booking_form_screen.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:siwa/app/theme.dart';

class Booking {
  final String id;
  final String serviceType;
  final DateTime date;
  final DateTime? checkOutDate;
  final int adultCount;
  final int childCount;
  final double totalPrice;
  final String specialRequests;

  Booking({
    required this.id,
    required this.serviceType,
    required this.date,
    this.checkOutDate,
    required this.adultCount,
    required this.childCount,
    required this.totalPrice,
    this.specialRequests = '',
  });
}

class BookingFormScreen extends StatefulWidget {
  final String serviceName;
  final String serviceType;
  final double basePrice;
  final String? imageUrl;

  const BookingFormScreen({
    super.key,
    required this.serviceName,
    required this.serviceType,
    required this.basePrice,
    this.imageUrl,
  });

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _specialRequestsController = TextEditingController();

  // Date selection
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedCheckIn;
  DateTime? _selectedCheckOut;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  // Guest counters
  int _adultCount = 1;
  int _childCount = 0;

  // Constraints
  static const int _minAdults = 1;
  static const int _maxAdults = 10;
  static const int _minChildren = 0;
  static const int _maxChildren = 10;

  @override
  void dispose() {
    _specialRequestsController.dispose();
    super.dispose();
  }

  bool _isDateSelectable(DateTime day) {
    // Only future dates (or today) are selectable
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return !day.isBefore(today);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!_isDateSelectable(selectedDay)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('common.no'.tr()),
          backgroundColor: AppTheme.errorRed,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _focusedDay = focusedDay;

      if (_selectedCheckIn == null ||
          _selectedCheckOut != null ||
          selectedDay.isBefore(_selectedCheckIn!)) {
        // First selection or reset
        _selectedCheckIn = selectedDay;
        _selectedCheckOut = null;
      } else {
        // Second selection (check-out)
        _selectedCheckOut = selectedDay;
      }
    });
  }

  void _incrementGuests(bool isAdult) {
    HapticFeedback.lightImpact();
    setState(() {
      if (isAdult && _adultCount < _maxAdults) {
        _adultCount++;
      } else if (!isAdult && _childCount < _maxChildren) {
        _childCount++;
      }
    });
  }

  void _decrementGuests(bool isAdult) {
    HapticFeedback.lightImpact();
    setState(() {
      if (isAdult && _adultCount > _minAdults) {
        _adultCount--;
      } else if (!isAdult && _childCount > _minChildren) {
        _childCount--;
      }
    });
  }

  double _calculateTotalPrice() {
    int nights = 1;
    if (_selectedCheckIn != null && _selectedCheckOut != null) {
      nights = _selectedCheckOut!.difference(_selectedCheckIn!).inDays;
      if (nights < 1) nights = 1;
    }

    // Base price per night/day
    // Adults pay full price, children pay 50%
    double adultPrice = widget.basePrice * _adultCount;
    double childPrice = widget.basePrice * _childCount * 0.5;

    return (adultPrice + childPrice) * nights;
  }

  String _getNightsText() {
    if (_selectedCheckIn == null || _selectedCheckOut == null) {
      return '1 night';
    }
    int nights = _selectedCheckOut!.difference(_selectedCheckIn!).inDays;
    return '$nights ${nights == 1 ? 'night' : 'nights'}';
  }

  Future<bool> _onWillPop() async {
    if (_selectedCheckIn != null || _adultCount > 1 || _childCount > 0) {
      return await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('common.cancel'.tr()),
              content: Text(
                'Are you sure you want to cancel this booking? All entered information will be lost.'
                    .tr(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('tourist.booking.confirm_booking'.tr()),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.errorRed,
                  ),
                  child: Text('common.cancel'.tr()),
                ),
              ],
            ),
          ) ??
          false;
    }
    return true;
  }

  void _proceedToPayment() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCheckIn == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a check-in date'.tr()),
            backgroundColor: AppTheme.errorRed,
          ),
        );
        return;
      }

      // For accommodations, require check-out date
      if (_selectedCheckOut == null &&
          (widget.serviceType.toLowerCase().contains('hotel') ||
              widget.serviceType.toLowerCase().contains('accommodation'))) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a check-out date'.tr()),
            backgroundColor: AppTheme.errorRed,
          ),
        );
        return;
      }

      // Create booking object
      final booking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        serviceType: widget.serviceName,
        date: _selectedCheckIn!,
        checkOutDate: _selectedCheckOut,
        adultCount: _adultCount,
        childCount: _childCount,
        totalPrice: _calculateTotalPrice(),
        specialRequests: _specialRequestsController.text,
      );

      // Navigate to payment screen
      context.push('/payment', extra: booking);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.lightBlueGray,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _onWillPop()) {
                context.pop();
              }
            },
          ),
          title: Text(widget.serviceName),
          elevation: 0,
          backgroundColor: AppTheme.white,
          actions: [
            TextButton(
              onPressed: () async {
                if (await _onWillPop()) {
                  context.pop();
                }
              },
              child: Text('Cancel', style: TextStyle(color: AppTheme.errorRed)),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service info card
                if (widget.imageUrl != null)
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.serviceName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${widget.basePrice.toStringAsFixed(0)} per night',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Calendar Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: AppTheme.primaryOrange,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Select Dates',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_selectedCheckIn != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.lightBlueGray,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Check-in',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.gray,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateFormat(
                                        'MMM dd, yyyy',
                                      ).format(_selectedCheckIn!),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: AppTheme.gray,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Check-out',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.gray,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _selectedCheckOut != null
                                          ? DateFormat(
                                              'MMM dd, yyyy',
                                            ).format(_selectedCheckOut!)
                                          : 'Select date',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: _selectedCheckOut != null
                                            ? AppTheme.darkGray
                                            : AppTheme.gray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 365)),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        rangeSelectionMode: _rangeSelectionMode,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedCheckIn, day) ||
                              isSameDay(_selectedCheckOut, day);
                        },
                        rangeStartDay: _selectedCheckIn,
                        rangeEndDay: _selectedCheckOut,
                        onDaySelected: _onDaySelected,
                        onFormatChanged: (format) {
                          setState(() => _calendarFormat = format);
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        enabledDayPredicate: _isDateSelectable,
                        calendarStyle: CalendarStyle(
                          selectedDecoration: const BoxDecoration(
                            color: AppTheme.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: AppTheme.primaryOrange.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          rangeHighlightColor: AppTheme.primaryOrange
                              .withOpacity(0.2),
                          rangeStartDecoration: const BoxDecoration(
                            color: AppTheme.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          rangeEndDecoration: const BoxDecoration(
                            color: AppTheme.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          disabledDecoration: BoxDecoration(
                            color: AppTheme.lightGray.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          outsideDaysVisible: false,
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Guests Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.people, color: AppTheme.primaryOrange),
                          SizedBox(width: 8),
                          Text(
                            'Guests',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildGuestCounter(
                        'Adults',
                        'Age 13+',
                        _adultCount,
                        () => _decrementGuests(true),
                        () => _incrementGuests(true),
                        _adultCount <= _minAdults,
                        _adultCount >= _maxAdults,
                      ),
                      const Divider(height: 32),
                      _buildGuestCounter(
                        'Children',
                        'Age 2-12',
                        _childCount,
                        () => _decrementGuests(false),
                        () => _incrementGuests(false),
                        _childCount <= _minChildren,
                        _childCount >= _maxChildren,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Special Requests
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.note_alt, color: AppTheme.primaryOrange),
                          SizedBox(width: 8),
                          Text(
                            'Special Requests',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Optional - Any special requirements or preferences',
                        style: TextStyle(fontSize: 12, color: AppTheme.gray),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _specialRequestsController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText:
                              'e.g., Early check-in, specific room location...'
                                  .tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppTheme.lightGray,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppTheme.primaryOrange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(fontSize: 14, color: AppTheme.gray),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                        Text(
                          '${_adultCount + _childCount} guests • ${_getNightsText()}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.gray,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: _proceedToPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryOrange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuestCounter(
    String title,
    String subtitle,
    int count,
    VoidCallback onDecrement,
    VoidCallback onIncrement,
    bool isMinDisabled,
    bool isMaxDisabled,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: AppTheme.gray),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: isMinDisabled ? null : onDecrement,
              icon: const Icon(Icons.remove_circle_outline),
              color: isMinDisabled
                  ? AppTheme.lightGray
                  : AppTheme.primaryOrange,
              iconSize: 32,
            ),
            Container(
              width: 40,
              alignment: Alignment.center,
              child: Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: isMaxDisabled ? null : onIncrement,
              icon: const Icon(Icons.add_circle_outline),
              color: isMaxDisabled
                  ? AppTheme.lightGray
                  : AppTheme.primaryOrange,
              iconSize: 32,
            ),
          ],
        ),
      ],
    );
  }
}
