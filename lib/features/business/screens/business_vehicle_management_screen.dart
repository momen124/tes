// lib/screens/business_vehicle_management_screen.dart
import 'package:flutter/material.dart';

class BusinessVehicleManagementScreen extends StatelessWidget {
  const BusinessVehicleManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(decoration: const InputDecoration(labelText: 'Vehicle Type')),
              TextFormField(decoration: const InputDecoration(labelText: 'Rates')),
              TextFormField(decoration: const InputDecoration(labelText: 'Routes')),
              SwitchListTile(title: const Text('Driver Verified'), value: true, onChanged: (val) {}),
              ElevatedButton(onPressed: () {}, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}