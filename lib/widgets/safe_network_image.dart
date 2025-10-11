// lib/widgets/safe_network_image.dart
import 'package:flutter/material.dart';
import 'package:siwa/app/theme.dart';

class SafeNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: width,
        height: height,
        color: AppTheme.lightBlueGray,
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return placeholder ?? Container(
              color: AppTheme.lightBlueGray,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryOrange),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            // Log the error for debugging
            debugPrint('SafeNetworkImage error: $error');
            return errorWidget ?? Container(
              color: AppTheme.lightBlueGray,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported_outlined,
                      color: AppTheme.primaryOrange,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Image unavailable',
                      style: TextStyle(
                        color: AppTheme.gray,
                        fontSize: 12,
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
}
