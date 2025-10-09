// lib/widgets/service_card.dart
import 'package:flutter/material.dart';
import 'package:siwa/app/theme.dart';

class ServiceCard extends StatelessWidget {
  final String name;
  final double price;
  final double rating;
  final String? description;
  final String? imageUrl;
  final int? reviews;
  final String? location;
  final bool isFeatured;

  const ServiceCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    this.description,
    this.imageUrl,
    this.reviews,
    this.location,
    this.isFeatured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with gradient overlay
          Stack(
            children: [
              Container(
                height: isFeatured ? 160 : 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl ?? 'https://images.unsplash.com/photo-1589993464410-6c55678afc12'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient overlay
              Container(
                height: isFeatured ? 160 : 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
              // Rating badge
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: AppTheme.primaryOrange, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Price tag
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '\$${price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                
                if (description != null)
                  Text(
                    description!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.gray,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                
                if (reviews != null || location != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (reviews != null)
                        Row(
                          children: [
                            const Icon(Icons.people_outline, size: 16, color: AppTheme.gray),
                            const SizedBox(width: 4),
                            Text(
                              '$reviews reviews',
                              style: const TextStyle(fontSize: 12, color: AppTheme.gray),
                            ),
                          ],
                        ),
                      
                      if (location != null) ...[
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16, color: AppTheme.gray),
                            const SizedBox(width: 4),
                            Text(
                              location!,
                              style: const TextStyle(fontSize: 12, color: AppTheme.gray),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}