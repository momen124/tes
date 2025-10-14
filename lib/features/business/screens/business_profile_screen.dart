// lib/features/business/screens/business_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/business/models/business_type.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class BusinessProfileScreen extends ConsumerStatefulWidget {
  final BusinessType businessType;

  const BusinessProfileScreen({super.key, required this.businessType});

  @override
  ConsumerState<BusinessProfileScreen> createState() =>
      _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends ConsumerState<BusinessProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  LatLng _location = const LatLng(29.1829, 25.5495);

  @override
  void dispose() {
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Customize business name hint based on type
  String _getBusinessNameHint() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return 'Siwa Paradise Hotel';
      case BusinessType.rental:
        return 'Siwa Bike & Car Rentals';
      case BusinessType.restaurant:
        return 'Traditional Siwan Kitchen';
      case BusinessType.store:
        return 'Siwa Gems & Crafts';
      case BusinessType.tourGuide:
        return 'Desert Adventures Siwa';
      case BusinessType.transportation:
        return 'Siwa Transport Services';
      case BusinessType.tripBooking:
        return 'Siwa Trip Organizers';
    }
  }

  // Customize email hint based on type
  String _getEmailHint() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return 'contact@siwahotel.com';
      case BusinessType.rental:
        return 'info@siwarentals.com';
      case BusinessType.restaurant:
        return 'reservations@siwarestaurant.com';
      case BusinessType.store:
        return 'shop@siwacrafts.com';
      case BusinessType.tourGuide:
        return 'tours@siwaadventures.com';
      case BusinessType.transportation:
        return 'booking@siwatransport.com';
      case BusinessType.tripBooking:
        return 'trips@siwatravel.com';
    }
  }

  // Customize description hint based on type
  String _getDescriptionHint() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return 'Describe your hotel facilities, room types, and unique amenities...';
      case BusinessType.rental:
        return 'Describe your rental fleet, pricing, and rental terms...';
      case BusinessType.restaurant:
        return 'Describe your cuisine style, specialty dishes, and dining experience...';
      case BusinessType.store:
        return 'Describe your products, crafts, and what makes your store unique...';
      case BusinessType.tourGuide:
        return 'Describe your tour experiences, expertise, and destinations...';
      case BusinessType.transportation:
        return 'Describe your transportation services, routes, and vehicle types...';
      case BusinessType.tripBooking:
        return 'Describe your trip packages, destinations, and travel services...';
    }
  }

  // Customize address hint based on type
  String _getAddressHint() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return 'Shali Fortress Road, Siwa Oasis';
      case BusinessType.rental:
        return 'Main Market Street, Siwa';
      case BusinessType.restaurant:
        return 'Downtown Siwa, Near City Center';
      case BusinessType.store:
        return 'Traditional Market, Siwa Oasis';
      case BusinessType.tourGuide:
        return 'Tourist Information Center, Siwa';
      case BusinessType.transportation:
        return 'Bus Station Area, Siwa';
      case BusinessType.tripBooking:
        return 'Travel Hub, Central Siwa';
    }
  }

  // Get icon based on business type
  IconData _getBusinessIcon() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return Icons.hotel;
      case BusinessType.rental:
        return Icons.directions_car;
      case BusinessType.restaurant:
        return Icons.restaurant;
      case BusinessType.store:
        return Icons.store;
      case BusinessType.tourGuide:
        return Icons.explore;
      case BusinessType.transportation:
        return Icons.directions_bus;
      case BusinessType.tripBooking:
        return Icons.map;
    }
  }

  // Get color based on business type
  Color _getBusinessColor() {
    switch (widget.businessType) {
      case BusinessType.hotel:
        return const Color(0xFFFF9500);
      case BusinessType.rental:
        return const Color(0xFF2196F3);
      case BusinessType.restaurant:
        return const Color(0xFF4CAF50);
      case BusinessType.store:
        return const Color(0xFF9C27B0);
      case BusinessType.tourGuide:
        return const Color(0xFFFFC107);
      case BusinessType.transportation:
        return const Color(0xFFF44336);
      case BusinessType.tripBooking:
        return const Color(0xFF00BCD4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);
    final businessColor = _getBusinessColor();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_getBusinessIcon(), color: businessColor),
            const SizedBox(width: 8),
            Text('navigation.profile'.tr()),
          ],
        ),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isOffline)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: AppTheme.offlineBanner,
                  child: const Row(
                    children: [
                      Icon(Icons.wifi_off, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'You are offline - Changes will sync when connected',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

              // Business header card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: businessColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getBusinessIcon(),
                          color: businessColor,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.businessType.displayName,
                              style: AppTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Manage your business profile',
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.gray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Business Information Section
              Text(
                'Business Information',
                style: AppTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _businessNameController,
                decoration: InputDecoration(
                  labelText: 'business.profile.business_name'.tr(),
                  hintText: _getBusinessNameHint(),
                  prefixIcon: Icon(Icons.business, color: businessColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.lightGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: businessColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a business name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'business.listings.description'.tr(),
                  hintText: _getDescriptionHint(),
                  prefixIcon: Icon(Icons.description, color: businessColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.lightGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: businessColor),
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Contact Information Section
              Text(
                'Contact Information',
                style: AppTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'business.profile.contact_email'.tr(),
                  hintText: _getEmailHint(),
                  prefixIcon: Icon(Icons.email, color: businessColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.lightGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: businessColor),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'business.profile.contact_phone'.tr(),
                  hintText: '+20 123 456 7890'.tr(),
                  prefixIcon: Icon(Icons.phone, color: businessColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.lightGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: businessColor),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Location Section
              Text(
                'Business Location',
                style: AppTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap on the map to set your business location',
                style: AppTheme.bodySmall.copyWith(color: AppTheme.gray),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'tourist.profile.badges'.tr(),
                  hintText: _getAddressHint(),
                  prefixIcon: Icon(Icons.location_on, color: businessColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.lightGray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: businessColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.lightGray),
                ),
                clipBehavior: Clip.antiAlias,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: _location,
                    initialZoom: 12.0,
                    onTap: (_, latlng) => setState(() => _location = latlng),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _location,
                          child: Icon(
                            Icons.location_pin,
                            color: businessColor,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.lightBlueGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: businessColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Coordinates: ${_location.latitude.toStringAsFixed(4)}, ${_location.longitude.toStringAsFixed(4)}',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.darkGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isOffline
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${widget.businessType.displayName} profile updated successfully!'
                                      .tr(),
                                ),
                                backgroundColor: AppTheme.successGreen,
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: businessColor,
                    disabledBackgroundColor: AppTheme.lightGray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.save),
                      const SizedBox(width: 8),
                      Text(
                        'Save Changes',
                        style: AppTheme.titleMedium.copyWith(
                          color: AppTheme.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
