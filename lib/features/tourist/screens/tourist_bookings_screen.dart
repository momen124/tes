import 'package:siwa/providers/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class TouristBookingsScreen extends ConsumerStatefulWidget {
  const TouristBookingsScreen({super.key});

  @override
  ConsumerState<TouristBookingsScreen> createState() =>
      _TouristBookingsScreenState();
}

class _TouristBookingsScreenState extends ConsumerState<TouristBookingsScreen> {
  Color _getStatusColor(String status) {
    final statusLower = status.toLowerCase();
    if (statusLower.contains('confirm') || statusLower.contains('approved')) {
      return AppTheme.successGreen;
    } else if (statusLower.contains('pend') || statusLower.contains('waiting')) {
      return AppTheme.warningYellow;
    } else if (statusLower.contains('cancel') || statusLower.contains('rejected')) {
      return AppTheme.errorRed;
    }
    return AppTheme.gray;
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'common.date_unavailable'.tr();
    
    try {
      DateTime? parsedDate;
      
      if (date is DateTime) {
        parsedDate = date;
      } else if (date is String) {
        parsedDate = DateTime.tryParse(date);
        if (parsedDate == null) {
          // Try alternative formats
          parsedDate = DateTime.tryParse('${date}T00:00:00');
        }
      } else {
        return date.toString();
      }
      
      if (parsedDate != null) {
        // Use locale-aware date formatting
        final locale = Localizations.localeOf(context).languageCode;
        return DateFormat('MMM dd, yyyy', locale).format(parsedDate);
      }
      
      return date.toString();
    } catch (e) {
      return 'common.date_unavailable'.tr();
    }
  }

  String _formatPrice(dynamic price) {
    if (price == null) return 'common.price_unavailable'.tr();
    
    try {
      final priceValue = (price as num).toDouble();
      final locale = Localizations.localeOf(context).languageCode;
      final isArabic = locale == 'ar';
      
      return NumberFormat.currency(
        locale: locale,
        symbol: isArabic ? 'ج.م' : 'EGP',
        decimalDigits: 0,
      ).format(priceValue);
    } catch (e) {
      return price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);
    
    // Get bookings from the provider
    final bookings = ref.watch(mockDataProvider).getAllBookings();

    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tourist_home'),
        ),
        title: Text('navigation.bookings'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                // Trigger rebuild to refresh data
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('common.data_refreshed'.tr())),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('common.settings'.tr())),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Offline Banner
          if (isOffline)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.orange.withOpacity(0.1),
              child: Row(
                children: [
                  const Icon(
                    Icons.signal_wifi_off,
                    color: AppTheme.primaryOrange,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'common.offline_warning'.tr(),
                      style: const TextStyle(
                        color: AppTheme.primaryOrange, 
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Bookings List
          Expanded(
            child: bookings.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 80,
                          color: AppTheme.secondaryGray.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'bookings.no_bookings'.tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppTheme.gray,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'bookings.start_exploring'.tr(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.secondaryGray,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () => context.go('/tourist_home'),
                          icon: const Icon(Icons.explore),
                          label: Text('bookings.explore_now'.tr()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    itemCount: bookings.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      
                      // Safe data extraction with fallbacks
                      final title = booking['title']?.toString() ?? 
                                   booking['serviceName']?.toString() ?? 
                                   booking['guest']?.toString() ?? 
                                   'common.unknown'.tr();
                      
                      final imageUrl = booking['imageUrl']?.toString() ?? 
                                     booking['serviceImage']?.toString() ?? 
                                     'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800';
                      
                      final status = booking['status']?.toString() ?? 'unknown';
                      final date = booking['date'] ?? booking['checkIn'] ?? booking['bookingDate'];
                      final price = booking['totalPrice'] ?? booking['price'] ?? booking['amount'];
                      
                      final serviceType = booking['serviceType']?.toString() ?? 
                                        booking['category']?.toString() ?? 'general';

                      return Card(
                        margin: EdgeInsets.zero,
                        elevation: 1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () => context.push(
                            '/booking_detail', 
                            extra: booking,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Booking Image
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppTheme.lightBlueGray,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      imageUrl,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: AppTheme.lightBlueGray,
                                          child: Icon(
                                            _getIconForServiceType(serviceType),
                                            size: 32,
                                            color: AppTheme.primaryOrange,
                                          ),
                                        );
                                      },
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                : null,
                                            strokeWidth: 2,
                                            valueColor: const AlwaysStoppedAnimation<Color>(
                                              AppTheme.primaryOrange,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                
                                // Booking Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      
                                      const SizedBox(height: 8),
                                      
                                      // Date and Price Row
                                      Row(
                                        children: [
                                          // Date
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 14,
                                                  color: AppTheme.gray,
                                                ),
                                                const SizedBox(width: 6),
                                                Flexible(
                                                  child: Text(
                                                    _formatDate(date),
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      color: AppTheme.gray,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          
                                          // Price (if available)
                                          if (price != null) ...[
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppTheme.primaryOrange.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                price.toString(),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.primaryOrange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 12),
                                      
                                      // Status Badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(status).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: _getStatusColor(status).withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              _getStatusIcon(status),
                                              size: 14,
                                              color: _getStatusColor(status),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              status.tr(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor(status),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Chevron indicator
                                const Padding(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: AppTheme.gray,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const SafeArea(
        child: TouristBottomNav(currentIndex: 3),
      ),
    );
  }

  IconData _getIconForServiceType(String serviceType) {
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
      default:
        return Icons.local_activity;
    }
  }

  IconData _getStatusIcon(String status) {
    final statusLower = status.toLowerCase();
    if (statusLower.contains('confirm') || statusLower.contains('approved')) {
      return Icons.check_circle;
    } else if (statusLower.contains('pend') || statusLower.contains('waiting')) {
      return Icons.schedule;
    } else if (statusLower.contains('cancel') || statusLower.contains('rejected')) {
      return Icons.cancel;
    }
    return Icons.help_outline;
  }
}