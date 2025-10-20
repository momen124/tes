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
  final String serviceType;
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
    // Detect RTL
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => _navigateToDetail(context),
        borderRadius: BorderRadius.circular(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive card width
            final cardWidth = constraints.maxWidth < 200
                ? constraints.maxWidth
                : (isFeatured ? 350.0 : 200.0);
            
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              constraints: BoxConstraints(
                maxWidth: cardWidth,
                minHeight: 100, // Ensure minimum height
              ),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image section with flexible height (prevents overflow)
                    Expanded(
                      flex: 3, // Allocate more space to image
                      child: _buildImageSection(isRTL),
                    ),
                    
                    // Content section with constrained height
                    Expanded(
                      flex: 2, // Allocate less space to text
                      child: Padding(
                        padding: const EdgeInsets.all(8), // Balanced padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Service name - Fixed overflow
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: cardWidth - 16, // Account for padding
                              ),
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontSize: isFeatured ? 15 : 13, // Compact font
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            
                            const SizedBox(height: 4), // Tighter spacing
                            
                            // Description - Fixed overflow
                            if (description != null && description!.isNotEmpty)
                              Flexible(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: cardWidth - 16,
                                  ),
                                  child: Text(
                                    description!,
                                    style: TextStyle(
                                      fontSize: isFeatured ? 11 : 10,
                                      color: AppTheme.gray,
                                      height: 1.2,
                                    ),
                                    maxLines: isFeatured ? 2 : 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            
                            // Reviews and location - Fixed overflow with Wrap
                            if (reviews != null || location != null) ...[
                              const SizedBox(height: 4),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: cardWidth - 16, // Match padding
                                ),
                                child: Wrap(
                                  spacing: 6,
                                  runSpacing: 3,
                                  children: [
                                    if (reviews != null)
                                      _buildInfoChip(
                                        Icons.people_outline,
                                        '$reviews reviews',
                                        isRTL,
                                      ),
                                    if (location != null)
                                      _buildInfoChip(
                                        Icons.location_on_outlined,
                                        location!,
                                        isRTL,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageSection(bool isRTL) {
    return Stack(
      children: [
        // Main image
        SizedBox(
          width: double.infinity,
          height: double.infinity,
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
        
        // Gradient overlay
        Container(
          width: double.infinity,
          height: double.infinity,
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
        
        // Rating badge - RTL aware positioning
        Positioned(
          top: 6,
          left: isRTL ? null : 6,
          right: isRTL ? 6 : null,
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
                Icon(Icons.star, color: AppTheme.primaryOrange, size: 12),
                const SizedBox(width: 3),
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Price tag - RTL aware positioning
        Positioned(
          bottom: 6,
          right: isRTL ? null : 6,
          left: isRTL ? 6 : null,
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
              'EGP ${price.toStringAsFixed(0)}',
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

  Widget _buildInfoChip(IconData icon, String text, bool isRTL) {
    return IntrinsicWidth(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Icon(icon, size: 12, color: AppTheme.gray),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
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
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppTheme.lightBlueGray,
      child: Center(
        child: Icon(
          _getIconForServiceType(),
          size: 35, // Balanced size
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
      '/service_detail',
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