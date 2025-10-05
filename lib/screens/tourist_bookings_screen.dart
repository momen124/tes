// lib/screens/tourist_bookings_screen.dart
import 'package:flutter/material.dart';

class TouristBookingsScreen extends StatelessWidget {
  const TouristBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      body: ListView(
        children: const [
          Card(child: ListTile(title: Text('Booking 1'), subtitle: Text('Pending'))),
          // Add mock bookings
        ],
      ),
    );
  }
}