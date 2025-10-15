// lib/features/tourist/screens/tourist_bookings_screen.dart
import 'package:siwa/providers/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

class TouristBookingsScreen extends ConsumerStatefulWidget {
  const TouristBookingsScreen({super.key});

  @override
  ConsumerState<TouristBookingsScreen> createState() =>
      _TouristBookingsScreenState();
}

class _TouristBookingsScreenState extends ConsumerState<TouristBookingsScreen> {
  Color _getStatusColor(String status) {
    final statusLower = status.toLowerCase();
    if (statusLower.contains('confirm')) {
      return AppTheme.successGreen;
    } else if (statusLower.contains('pend')) {
      return AppTheme.warningYellow;
    } else if (statusLower.contains('cancel')) {
      return AppTheme.errorRed;
    }
    return AppTheme.gray;
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'Date unavailable';
    
    try {
      if (date is DateTime) {
        return DateFormat('MMM dd, yyyy').format(date);
      } else if (date is String) {
        final parsed = DateTime.tryParse(date);
        if (parsed != null) {
          return DateFormat('MMM dd, yyyy').format(parsed);
        }
        return date;
      }
      return date.toString();
    } catch (e) {
      return 'Date unavailable';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);
    final bookings = ref.watch(mockDataProvider).getAllBookings();

    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tourist_home'),
        ),
        title: Text('navigation.bookings'.tr()),
        actions: [
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
              color: AppTheme.lightGray,
              child: const Row(
                children: [
                  Icon(
                    Icons.signal_wifi_off,
                    color: AppTheme.primaryOrange,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You are offline. Data might be outdated.',
                      style: TextStyle(color: AppTheme.black, fontSize: 14),
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
                        const Text(
                          'No bookings yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.gray,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Start exploring Siwa Oasis',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.secondaryGray,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      
                      // Extract booking details with null safety
                      final title = booking['title']?.toString() ?? (booking['guest'] ?? 'Unknown Booking').toString();
                      final imageUrl = (booking['imageUrl'] ?? 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800').toString();
                      final status = (booking['status'] ?? 'unknown').toString();
                      final date = booking['date'] ?? booking['checkIn'];
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () => context.push('/service_detail'),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // Booking Image
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppTheme.lightBlueGray,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: AppTheme.lightBlueGray,
                                          child: const Icon(
                                            Icons.hotel,
                                            size: 40,
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
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 14,
                                            color: AppTheme.gray,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              _formatDate(date),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: AppTheme.gray,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(status).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          status,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor(status),
                                          ),
                                        ),
                                      ),
                                    ],
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
      bottomNavigationBar: const TouristBottomNav(currentIndex: 3),
    );
  }
}