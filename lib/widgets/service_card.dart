// lib/widgets/service_card.dart
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String name;
  final double price;
  final int rating;

  const ServiceCard({super.key, required this.name, required this.price, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFD2B48C),
      child: Column(
        children: [
          const Placeholder(),  // Photo
          Text(name, style: const TextStyle(color: Color(0xFF000000))),
          Text('$price', style: const TextStyle(color: Color(0xFFFF7518))),
          Row(
            children: List.generate(5, (i) => Icon(i < rating ? Icons.star : Icons.star_border, color: Color(0xFFFF7518))),
          ),
        ],
      ),
    );
  }
}