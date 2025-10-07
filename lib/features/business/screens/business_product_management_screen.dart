// lib/screens/business_product_management_screen.dart
import 'package:flutter/material.dart';

class BusinessProductManagementScreen extends StatelessWidget {
  const BusinessProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(decoration: const InputDecoration(labelText: 'Name')),
              TextFormField(decoration: const InputDecoration(labelText: 'Price')),
              TextFormField(decoration: const InputDecoration(labelText: 'Stock')),
              ElevatedButton(onPressed: () {}, child: const Text('Upload Photo')),
              ElevatedButton(onPressed: () {}, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}