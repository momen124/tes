import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/widgets/safe_network_image.dart';

class ServiceCard extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final double rating;
  final String? description;
  final String? imageUrl;
  final int? reviews;
  final String? location;
  final bool isFeatured;
  final String serviceType; // hotel, tour, restaurant, etc.
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    this.id = '',
    required this.name,
    required this.price,
    required this.rating,
    this.description,
    this.imageUrl,
    this.reviews,
    this.location,
    this.isFeatured = false,
    this.serviceType = 'general',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => _navigateToDetail(context),
        borderRadius: BorderRadius.circular(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Dynamically adjust maxWidth based on parent constraints
            final cardWidth = constraints.maxWidth < 200
                ? constraints.maxWidth
                : (isFeatured ? 350.0 : 200.0);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              constraints: BoxConstraints(maxWidth: cardWidth),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image with gradient overlay
                  _buildImageSection(),
                  // Content section
                  Padding(
                    padding: const EdgeInsets.all(8), // Further reduced padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Service name
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: isFeatured ? 16 : 14, // Smaller font
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4), // Tighter spacing
                        // Description
                        if (description != null && description!.isNotEmpty)
                          Text(
                            description!,
                            style: TextStyle(
                              fontSize: isFeatured ? 12 : 11, // Smaller font
                              color: AppTheme.gray,
                              height: 1.2,
                            ),
                            maxLines: isFeatured ? 3 : 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        // Reviews and location
                        if (reviews != null || location != null) ...[
                          const SizedBox(height: 4),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: cardWidth - 16,
                            ), // Match padding
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: [
                                if (reviews != null)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.people_outline,
                                        size: 12,
                                        color: AppTheme.gray,
                                      ),
                                      const SizedBox(width: 3),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Text(
                                          '$reviews reviews',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppTheme.gray,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (location != null)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 12,
                                        color: AppTheme.gray,
                                      ),
                                      const SizedBox(width: 3),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Text(
                                          location!,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppTheme.gray,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        // Main image
        Container(
          height: isFeatured ? 140 : 120, // Reduced image height
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: AppTheme.lightBlueGray,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? SafeNetworkImage(
                    imageUrl: imageUrl!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    errorWidget: _buildPlaceholderImage(),
                  )
                : _buildPlaceholderImage(),
          ),
        ),
        // Gradient overlay
        Container(
          height: isFeatured ? 140 : 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
            ),
          ),
        ),
        // Rating badge
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: AppTheme.primaryOrange, size: 12),
                const SizedBox(width: 3),
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Price tag
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryOrange.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              '\$${price.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppTheme.lightBlueGray,
      child: Center(
        child: Icon(
          _getIconForServiceType(),
          size: 40, // Smaller icon
          color: AppTheme.primaryOrange,
        ),
      ),
    );
  }

  IconData _getIconForServiceType() {
    switch (serviceType.toLowerCase()) {
      case 'hotel':
      case 'accommodation':
        return Icons.hotel;
      case 'tour':
      case 'guide':
        return Icons.explore;
      case 'restaurant':
      case 'food':
        return Icons.restaurant;
      case 'transport':
      case 'transportation':
        return Icons.directions_car;
      case 'activity':
      case 'attraction':
        return Icons.attractions;
      case 'store':
      case 'shop':
        return Icons.store;
      default:
        return Icons.location_city;
    }
  }

  void _navigateToDetail(BuildContext context) {
    context.push(
      '/product_detail',
      extra: {
        'id': id,
        'name': name,
        'price': price,
        'rating': rating,
        'description': description,
        'imageUrl': imageUrl,
        'reviews': reviews,
        'location': location,
        'serviceType': serviceType,
      },
    );
  }
}
