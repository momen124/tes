// lib/widgets/booking_form.dart
import 'package:flutter/material.dart';

class BookingForm extends StatelessWidget {
  const BookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(decoration: const InputDecoration(labelText: 'Date')),
          TextFormField(decoration: const InputDecoration(labelText: 'Guests')),
          ElevatedButton(onPressed: () {}, child: const Text('Book')),
        ],
      ),
    );
  }
}