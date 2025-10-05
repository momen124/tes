// lib/widgets/service_card.dart
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String name;
  final double price;
  final double rating;
  final String? description; // Already added in previous fix
  final String? imageUrl;    // New parameter for image URL
  final int? reviews;        // New parameter for number of reviews
  final String? location;    // New parameter for location

  const ServiceCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    this.description,
    this.imageUrl,
    this.reviews,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Image.network(imageUrl!, height: 100, fit: BoxFit.cover), // Display image if provided
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Price: \$${price.toStringAsFixed(2)}'),
            Text('Rating: ${rating.toStringAsFixed(1)}/5'),
            if (reviews != null) Text('Reviews: $reviews'), // Display reviews if provided
            if (location != null) Text('Location: $location'), // Display location if provided
            if (description != null) Text(description!), // Display description if provided
          ],
        ),
      ),
    );
  }
}