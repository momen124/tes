// lib/features/tourist/screens/booking_confirmation_screen.dart
import 'package:flutter/material.dart';
import 'package:siwa/features/tourist/screens/booking_form_screen.dart'; // Import Booking class

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
                const Text('Booking Confirmed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const Text('Your booking details have been sent to your email.'),
                const SizedBox(height: 8),
                Text('Reference ID: #${booking.id}'),
                Text('Service: ${booking.serviceType}'),
                Text('Date: ${booking.date.toString().split(' ')[0]}'),
                Text('Adults: ${booking.adultCount}'),
                Text('Children: ${booking.childCount}'),
                Text('Total: \$${booking.totalPrice.toStringAsFixed(2)}'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/tourist_home', (route) => false),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Back to Home', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}