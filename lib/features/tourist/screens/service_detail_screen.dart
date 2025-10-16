import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:siwa/app/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:siwa/features/tourist/screens/booking_form_screen.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? serviceData;
  
  const ServiceDetailScreen({
    super.key,
    this.serviceData,
  });

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  // Booking form state
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedCheckIn;
  DateTime? _selectedCheckOut;
  int _adultCount = 1;
  int _childCount = 0;
  final _specialRequestsController = TextEditingController();

  // Payment form state
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  String _selectedPaymentMethod = 'card';
  bool _isProcessing = false;

  // Service data getters with null safety - supports ALL service types
  String get _serviceName => widget.serviceData?['name']?.toString() ?? 'Service';
  double get _basePrice => (widget.serviceData?['price'] as num?)?.toDouble() ?? 0.0;
  String get _serviceType => widget.serviceData?['category']?.toString() ?? 'service';
  String get _description => widget.serviceData?['description']?.toString() ?? 'No description available';
  String get _imageUrl => widget.serviceData?['imageUrl']?.toString() ?? '';
  double get _rating => (widget.serviceData?['rating'] as num?)?.toDouble() ?? 0.0;
  int get _reviews => widget.serviceData?['reviews'] as int? ?? 0;
  String get _location => widget.serviceData?['location']?.toString() ?? 'Siwa Oasis';
  
  // Optional fields for different service types
  List<String> get _highlights => (widget.serviceData?['highlights'] as List?)?.cast<String>() ?? [];
  List<String> get _amenities => (widget.serviceData?['amenities'] as List?)?.cast<String>() ?? [];
  List<String> get _specialties => (widget.serviceData?['specialties'] as List?)?.cast<String>() ?? [];
  String get _duration => widget.serviceData?['duration']?.toString() ?? '';
  String get _difficulty => widget.serviceData?['difficulty']?.toString() ?? '';
  String get _openingHours => widget.serviceData?['openingHours']?.toString() ?? '';
  String get _route => widget.serviceData?['route']?.toString() ?? '';
  int get _seats => widget.serviceData?['seats'] as int? ?? 0;
  String get _type => widget.serviceData?['type']?.toString() ?? '';
  String get _cuisine => widget.serviceData?['cuisine']?.toString() ?? '';
  String get _priceRange => widget.serviceData?['priceRange']?.toString() ?? '';
  bool get _openNow => widget.serviceData?['openNow'] as bool? ?? true;

  @override
  void dispose() {
    _specialRequestsController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool _isDateSelectable(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return !day.isBefore(today);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!_isDateSelectable(selectedDay)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot select past dates'.tr()),
          backgroundColor: AppTheme.errorRed,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _focusedDay = focusedDay;
      if (_selectedCheckIn == null ||
          _selectedCheckOut != null ||
          selectedDay.isBefore(_selectedCheckIn!)) {
        _selectedCheckIn = selectedDay;
        _selectedCheckOut = null;
      } else {
        _selectedCheckOut = selectedDay;
      }
    });
  }

  double _calculateTotalPrice() {
    int nights = 1;
    if (_selectedCheckIn != null && _selectedCheckOut != null) {
      nights = _selectedCheckOut!.difference(_selectedCheckIn!).inDays;
      if (nights < 1) nights = 1;
    }
    double adultPrice = _basePrice * _adultCount;
    double childPrice = _basePrice * _childCount * 0.5;
    return (adultPrice + childPrice) * nights;
  }

  void _showBookingBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.gray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Book $_serviceName',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Calendar Section
                      const Text(
                        'Select Dates',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
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
                                    Text(
                                      DateFormat('MMM dd, yyyy')
                                          .format(_selectedCheckIn!),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward,
                                  color: AppTheme.gray, size: 20),
                              const SizedBox(width: 12),
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
                                    Text(
                                      _selectedCheckOut != null
                                          ? DateFormat('MMM dd, yyyy')
                                              .format(_selectedCheckOut!)
                                          : 'Select date',
                                      style: TextStyle(
                                        fontSize: 14,
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
                      const SizedBox(height: 12),
                      TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 365)),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedCheckIn, day) ||
                            isSameDay(_selectedCheckOut, day),
                        rangeStartDay: _selectedCheckIn,
                        rangeEndDay: _selectedCheckOut,
                        onDaySelected: (selected, focused) {
                          _onDaySelected(selected, focused);
                          setModalState(() {});
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
                          rangeHighlightColor:
                              AppTheme.primaryOrange.withOpacity(0.2),
                          rangeStartDecoration: const BoxDecoration(
                            color: AppTheme.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          rangeEndDecoration: const BoxDecoration(
                            color: AppTheme.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Guests Section
                      const Text(
                        'Guests',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildGuestCounter(
                        'Adults',
                        'Age 13+',
                        _adultCount,
                        () => setModalState(() {
                          if (_adultCount > 1) _adultCount--;
                        }),
                        () => setModalState(() {
                          if (_adultCount < 10) _adultCount++;
                        }),
                      ),
                      const Divider(height: 24),
                      _buildGuestCounter(
                        'Children',
                        'Age 2-12',
                        _childCount,
                        () => setModalState(() {
                          if (_childCount > 0) _childCount--;
                        }),
                        () => setModalState(() {
                          if (_childCount < 10) _childCount++;
                        }),
                      ),

                      const SizedBox(height: 24),

                      // Special Requests
                      const Text(
                        'Special Requests',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _specialRequestsController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'e.g., Early check-in, room preferences...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom action bar
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(fontSize: 12, color: AppTheme.gray),
                          ),
                          Text(
                            'EGP ${_calculateTotalPrice().toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedCheckIn == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select check-in date'.tr()),
                              backgroundColor: AppTheme.errorRed,
                            ),
                          );
                          return;
                        }
                        if (_selectedCheckOut == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select check-out date'.tr()),
                              backgroundColor: AppTheme.errorRed,
                            ),
                          );
                          return;
                        }
                        Navigator.pop(context);
                        _showPaymentBottomSheet();
                      },
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
                            'Continue to Payment',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: !_isProcessing,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.gray.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment'.tr(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _isProcessing ? null : () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Booking Summary
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.lightBlueGray,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Booking Summary',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildSummaryRow('Service', _serviceName),
                              const SizedBox(height: 6),
                              _buildSummaryRow(
                                'Guests',
                                '$_adultCount Adults, $_childCount Children',
                              ),
                              const SizedBox(height: 6),
                              _buildSummaryRow(
                                'Dates',
                                '${DateFormat('MMM dd').format(_selectedCheckIn!)} - ${DateFormat('MMM dd, yyyy').format(_selectedCheckOut!)}',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Payment Method
                        const Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildPaymentMethodOption(
                          'card',
                          'Credit/Debit Card',
                          Icons.credit_card,
                          setModalState,
                        ),
                        const SizedBox(height: 8),
                        _buildPaymentMethodOption(
                          'cash',
                          'Pay at Property',
                          Icons.money,
                          setModalState,
                        ),

                        if (_selectedPaymentMethod == 'card') ...[
                          const SizedBox(height: 24),
                          const Text(
                            'Card Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _cardNumberController,
                            decoration: InputDecoration(
                              labelText: 'Card Number',
                              hintText: '1234 5678 9012 3456',
                              prefixIcon: const Icon(Icons.credit_card),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              if (value.replaceAll(' ', '').length != 16) {
                                return 'Invalid card number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Cardholder Name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _expiryController,
                                  decoration: InputDecoration(
                                    labelText: 'MM/YY',
                                    prefixIcon: const Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _cvvController,
                                  decoration: InputDecoration(
                                    labelText: 'CVV',
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    if (value.length != 3) {
                                      return 'Invalid';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom action bar
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isProcessing ? null : () => _processPayment(setModalState),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isProcessing
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Processing...'),
                            ],
                          )
                        : Text(
                            'Pay EGP ${_calculateTotalPrice().toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _processPayment(StateSetter setModalState) async {
    if (_selectedPaymentMethod == 'card' && !_formKey.currentState!.validate()) {
      return;
    }

    setModalState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      serviceType: _serviceName,
      date: _selectedCheckIn!,
      checkOutDate: _selectedCheckOut,
      adultCount: _adultCount,
      childCount: _childCount,
      totalPrice: _calculateTotalPrice(),
      specialRequests: _specialRequestsController.text,
    );

    Navigator.pop(context);
    context.push('/tourist_bookings', extra: booking);
  }

  @override
  Widget build(BuildContext context) {
    // Handle null service data
    if (widget.serviceData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Service Details'),
        ),
        body: const Center(
          child: Text('Service not found'),
        ),
      );
    }

    // Get images list with fallback
    final images = widget.serviceData?['images'] as List?;
    final imageUrls = images?.cast<String>().where((url) => url.isNotEmpty).toList() ?? 
                     (_imageUrl.isNotEmpty ? [_imageUrl] : <String>[]);
    
    // Get features based on service type
    final features = _highlights.isNotEmpty ? _highlights : 
                    _amenities.isNotEmpty ? _amenities :
                    _specialties.isNotEmpty ? _specialties : <String>[];
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(_serviceName),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share feature coming soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            if (imageUrls.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: 250,
                  viewportFraction: 1.0,
                  autoPlay: imageUrls.length > 1,
                  autoPlayInterval: const Duration(seconds: 4),
                ),
                items: imageUrls
                    .map((url) => Image.network(
                          url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stack) => Container(
                            color: AppTheme.lightBlueGray,
                            child: const Icon(Icons.image, size: 40, color: AppTheme.gray),
                          ),
                        ))
                    .toList(),
              )
            else
              Container(
                height: 250,
                color: AppTheme.lightBlueGray,
                child: const Center(
                  child: Icon(Icons.image, size: 60, color: AppTheme.gray),
                ),
              ),

            // Service Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _serviceName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryOrange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: AppTheme.primaryOrange, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              _rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Service Type Badges
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (_location.isNotEmpty)
                        _buildInfoBadge(Icons.location_on, _location),
                      if (_reviews > 0)
                        _buildInfoBadge(Icons.reviews, '$_reviews reviews'),
                      if (_duration.isNotEmpty)
                        _buildInfoBadge(Icons.access_time, _duration),
                      if (_type.isNotEmpty)
                        _buildInfoBadge(Icons.category, _type.toUpperCase()),
                      if (_cuisine.isNotEmpty)
                        _buildInfoBadge(Icons.restaurant, _cuisine),
                      if (!_openNow)
                        _buildInfoBadge(Icons.schedule, 'Closed', isWarning: true),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 32),

            // About Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'service_detail.about'.tr(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _description,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.gray.withOpacity(0.8),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            // Features/Highlights/Amenities Section
            if (features.isNotEmpty) ...[
              const Divider(height: 32),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _highlights.isNotEmpty ? 'Highlights' :
                      _amenities.isNotEmpty ? 'Amenities' : 'Features',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...features.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppTheme.successGreen.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: AppTheme.successGreen,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Additional Info (for transport, restaurants, etc.)
            if (_route.isNotEmpty || _seats > 0 || _openingHours.isNotEmpty) ...[
              const Divider(height: 32),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Additional Information',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_route.isNotEmpty)
                      _buildInfoRow(Icons.route, 'Route', _route),
                    if (_seats > 0)
                      _buildInfoRow(Icons.event_seat, 'Capacity', '$_seats seats'),
                    if (_openingHours.isNotEmpty)
                      _buildInfoRow(Icons.schedule, 'Hours', _openingHours),
                    if (_difficulty.isNotEmpty)
                      _buildInfoRow(Icons.fitness_center, 'Difficulty', _difficulty),
                  ],
                ),
              ),
            ],

            const Divider(height: 32),

            // Reviews Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'service_detail.reviews'.tr(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        _rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < _rating.floor()
                                    ? Icons.star
                                    : (index < _rating ? Icons.star_half : Icons.star_border),
                                color: AppTheme.primaryOrange,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('$_reviews reviews'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 32),

            // Location Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'service_detail.location'.tr(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _location,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppTheme.gray,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 200,
                      child: FlutterMap(
                        options: const MapOptions(
                          initialCenter: LatLng(29.1829, 25.5495),
                          initialZoom: 12.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          ),
                          const MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(29.1829, 25.5495),
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Book Now Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _openNow ? _showBookingBottomSheet : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _openNow ? 'Book Now - ' : 'Currently Closed - ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'EGP ${_basePrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String text, {bool isWarning = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isWarning 
            ? AppTheme.errorRed.withOpacity(0.1)
            : AppTheme.lightBlueGray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon, 
            size: 14, 
            color: isWarning ? AppTheme.errorRed : AppTheme.gray
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isWarning ? AppTheme.errorRed : AppTheme.gray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.primaryOrange),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.gray,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestCounter(
    String title,
    String subtitle,
    int count,
    VoidCallback onDecrement,
    VoidCallback onIncrement,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.gray,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: const Icon(Icons.remove_circle_outline),
              color: AppTheme.primaryOrange,
              iconSize: 28,
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
              onPressed: onIncrement,
              icon: const Icon(Icons.add_circle_outline),
              color: AppTheme.primaryOrange,
              iconSize: 28,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppTheme.gray),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption(
    String value,
    String label,
    IconData icon,
    StateSetter setModalState,
  ) {
    final isSelected = _selectedPaymentMethod == value;
    return InkWell(
      onTap: _isProcessing
          ? null
          : () {
              setModalState(() => _selectedPaymentMethod = value);
            },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppTheme.primaryOrange : AppTheme.lightGray,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? AppTheme.primaryOrange.withOpacity(0.05)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryOrange : AppTheme.gray,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppTheme.primaryOrange : AppTheme.darkGray,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.primaryOrange),
          ],
        ),
      ),
    );
  }
}