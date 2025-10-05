import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BusinessListingsScreen extends StatelessWidget {
  const BusinessListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listings Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(decoration: const InputDecoration(labelText: 'Name')),
              TextFormField(decoration: const InputDecoration(labelText: 'Price')),
              TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: DateTime.now(),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Upload Photo')),
              ElevatedButton(onPressed: () {}, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}