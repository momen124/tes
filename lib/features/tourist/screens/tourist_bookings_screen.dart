// Your provided code for this screen already closely matches the screenshot. Add image URLs for cards.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';

class TouristBookingsScreen extends ConsumerStatefulWidget {
  const TouristBookingsScreen({super.key});

  @override
  ConsumerState<TouristBookingsScreen> createState() => _TouristBookingsScreenState();
}

class _TouristBookingsScreenState extends ConsumerState<TouristBookingsScreen> {
  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 1001,
      'title': 'Siwa Shali Resort',
      'date': '2024-07-20',
      'status': 'Confirmed',
      'imageUrl': 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg?w=900&h=500&s=1',
      'amount': '\$150',
    },
    {
      'id': 1002,
      'title': 'Mountain Bike Rental',
      'date': '2024-08-15',
      'status': 'Pending',
      'imageUrl': 'https://www.quitandgotravel.com/wp-content/uploads/sites/8/2022/04/Cycling-Across-Siwa-Oasis-Lake.jpg',
      'amount': '\$85',
    },
    {
      'id': 1003,
      'title': 'Siwa Oasis Tour',
      'date': '2024-09-05',
      'status': 'Cancelled',
      'imageUrl': 'https://www.kemetexperience.com/wp-content/uploads/2019/09/incredible-white-desert-960x636.jpg',
      'amount': '\$65',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return AppTheme.successGreen;
      case 'Pending':
        return AppTheme.warningYellow;
      case 'Cancelled':
        return AppTheme.errorRed;
      default:
        return AppTheme.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);

    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tourist_home'),
        ),
        title: const Text('Bookings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking settings')),
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
              color: AppTheme.offlineBanner,
              child: Row(
                children: [
                  Icon(
                    Icons.signal_wifi_off,
                    color: AppTheme.primaryOrange,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You are offline. Data might be outdated.',
                      style: TextStyle(
                        color: AppTheme.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          // Bookings List
          Expanded(
            child: _bookings.isEmpty
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
                          'No bookings yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.gray,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
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
                    itemCount: _bookings.length,
                    itemBuilder: (context, index) {
                      final booking = _bookings[index];
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
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(booking['imageUrl']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        booking['title'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today_outlined,
                                            size: 14,
                                            color: AppTheme.gray,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Booking Date: ${booking['date']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.gray,
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
                                          color: _getStatusColor(booking['status'])
                                              .withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          booking['status'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor(booking['status']),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/tourist_home');
              break;
            case 1:
              context.go('/tourist_search');
              break;
            case 2:
              // Current
              break;
            case 3:
              context.go('/tourist_profile');
              break;
          }
        },
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.gray,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}