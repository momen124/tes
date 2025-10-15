// lib/widgets/booking_form.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BookingForm extends StatelessWidget {
  const BookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(decoration: InputDecoration(labelText: 'tourist.booking.date'.tr())),
          TextFormField(decoration: InputDecoration(labelText: 'tourist.booking.guests'.tr())),
          ElevatedButton(onPressed: () {}, child: Text('navigation.bookings'.tr())),
        ],
      ),
    );
  }
}
