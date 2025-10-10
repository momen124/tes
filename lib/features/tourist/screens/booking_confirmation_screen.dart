// lib/features/tourist/screens/booking_confirmation_screen.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:siwa/features/tourist/screens/booking_form_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final Booking booking;

  const BookingConfirmationScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 80),
                const SizedBox(height: 16),
                Text(
                  'tourist.booking.booking_confirmed'.tr(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text('tourist.booking.booking_details_sent'.tr()),
                const SizedBox(height: 8),
                Text('${'tourist.booking.reference_id'.tr()} #${booking.id}'),
                Text('${'tourist.booking.service'.tr()}: ${booking.serviceType}'),
                Text('${'tourist.booking.date'.tr()}: ${booking.date.toString().split(' ')[0]}'),
                Text('${'tourist.booking.adults'.tr()}: ${booking.adultCount}'),
                Text('${'tourist.booking.children'.tr()}: ${booking.childCount}'),
                Text('${'tourist.booking.total_cost'.tr()}: \$${booking.totalPrice.toStringAsFixed(2)}'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/tourist_home', (route) => false),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: Text(
                    'common.back'.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}