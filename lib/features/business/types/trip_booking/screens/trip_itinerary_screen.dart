import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

class TripItineraryScreen extends ConsumerStatefulWidget {
  const TripItineraryScreen({super.key});

  @override
  ConsumerState<TripItineraryScreen> createState() => _TripItineraryScreenState();
}

class _TripItineraryScreenState extends ConsumerState<TripItineraryScreen> {
  final List<Map<String, dynamic>> _itinerary = [
    {
      'id': 1,
      'name': 'Salt Lakes Tour',
      'duration': const Duration(hours: 2),
      'description': 'Explore the stunning natural salt lakes',
      'time': '09:00 AM',
    },
    {
      'id': 2,
      'name': 'Cleopatra Spring',
      'duration': const Duration(hours: 1, minutes: 30),
      'description': 'Swimming in the famous natural spring',
      'time': '11:30 AM',
    },
    {
      'id': 3,
      'name': 'Traditional Lunch',
      'duration': const Duration(hours: 1),
      'description': 'Authentic Siwan cuisine',
      'time': '01:00 PM',
    },
  ];

  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 1,
      'guest': 'Group of 5',
      'date': DateTime.now().add(const Duration(days: 5)),
      'status': 'confirmed',
    },
    {
      'id': 2,
      'guest': 'Family of 4',
      'date': DateTime.now().add(const Duration(days: 12)),
      'status': 'pending',
    },
  ];

  void _showAddStopDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Stop'),
        content: TextField(
          decoration: const InputDecoration(labelText: 'Stop Name'),
          onChanged: (value) {
            // Handle input
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Add logic to add new stop
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/business_dashboard'),
        ),
        title: const Text('Trip Itinerary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: isOffline ? null : _showAddStopDialog,
            tooltip: 'Add Stop',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Statistics
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Booking Statistics', style: AppTheme.titleLarge),
            ),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: _bookings.where((b) => b['status'] == 'confirmed').length.toDouble(),
                        color: AppTheme.successGreen,
                        title: 'Confirmed',
                        radius: 50,
                        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      PieChartSectionData(
                        value: _bookings.where((b) => b['status'] == 'pending').length.toDouble(),
                        color: AppTheme.warningYellow,
                        title: 'Pending',
                        radius: 50,
                        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      PieChartSectionData(
                        value: (10 - _bookings.length).toDouble(),
                        color: AppTheme.lightGray,
                        title: 'Available',
                        radius: 50,
                        titleStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Itinerary Timeline
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Itinerary', style: AppTheme.titleLarge),
            ),
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _itinerary.length,
              onReorder: (oldIndex, newIndex) {
                if (!isOffline) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final item = _itinerary.removeAt(oldIndex);
                    _itinerary.insert(newIndex, item);
                  });
                }
              },
              itemBuilder: (context, index) {
                final item = _itinerary[index];
                return ListTile(
                  key: Key(item['id'].toString()),
                  title: Text(item['name']),
                  subtitle: Text('${item['description']} (Duration: ${item['duration'].inHours}h ${item['duration'].inMinutes.remainder(60)}m, Time: ${item['time']}'),
                  leading: const Icon(Icons.location_on),
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}