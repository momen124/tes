// lib/screens/tourist_search_screen.dart
import 'package:flutter/material.dart';

class TouristSearchScreen extends StatelessWidget {
  const TouristSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          TextField(decoration: const InputDecoration(hintText: 'Search Siwa...')),
          // Filters
          Row(
            children: [
              DropdownButton<String>(
                hint: const Text('Price'),
                items: const [
                  DropdownMenuItem(value: 'low', child: Text('Low to High')),
                  DropdownMenuItem(value: 'high', child: Text('High to Low')),
                ],
                onChanged: (value) {},
              ),
              // Add location, eco checkboxes
            ],
          ),
          Expanded(
            child: ListView(
              children: const [
                Card(child: ListTile(title: Text('Siwa Shali Resort'))),
                // Add more mock cards
              ],
            ),
          ),
        ],
      ),
    );
  }
}