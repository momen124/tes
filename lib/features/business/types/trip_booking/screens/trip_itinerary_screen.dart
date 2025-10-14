// lib/features/business/types/tour_guide/screens/trip_itinerary_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';

class TripItineraryScreen extends ConsumerStatefulWidget {
  const TripItineraryScreen({super.key});

  @override
  ConsumerState<TripItineraryScreen> createState() => _TripItineraryScreenState();
}

class _TripItineraryScreenState extends ConsumerState<TripItineraryScreen> {
  late ConfettiController _confettiController;
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

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _showAddStopDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final durationController = TextEditingController();
    final descriptionController = TextEditingController();
    final timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Stop'.tr()),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Stop Name'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter stop name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: durationController,
                  decoration: InputDecoration(labelText: 'Duration (e.g., 2h 30m)'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter duration' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter description' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Time (e.g., 09:00 AM)'.tr()),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter time' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final durationParts = durationController.text.split(' ');
                final hours = durationParts.isNotEmpty 
                    ? int.tryParse(durationParts[0].replaceAll('h', '')) ?? 0
                    : 0;
                final minutes = durationParts.length > 1
                    ? int.tryParse(durationParts[1].replaceAll('m', '')) ?? 0
                    : 0;
                setState(() {
                  _itinerary.add({
                    'id': _itinerary.length + 1,
                    'name': nameController.text,
                    'duration': Duration(hours: hours, minutes: minutes),
                    'description': descriptionController.text,
                    'time': timeController.text,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Stop added successfully'.tr())),
                );
                _confettiController.play();
              }
            },
            child: Text('Add'.tr()),
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
          onPressed: isOffline ? null : () => context.go('/business_dashboard'),
        ),
        title: Text('Trip Itinerary'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: isOffline ? null : _showAddStopDialog,
            tooltip: 'Add Stop'.tr(),
          ),
        ],
      ),
      body: isOffline
          ? Center(
              child: Container(
                decoration: AppTheme.offlineBanner,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  'You are offline',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Booking Statistics
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Booking Statistics'.tr(), style: AppTheme.titleLarge),
                  ).animate().fadeIn(),
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
                              title: 'Confirmed'.tr(),
                              radius: 50,
                              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            PieChartSectionData(
                              value: _bookings.where((b) => b['status'] == 'pending').length.toDouble(),
                              color: AppTheme.warningYellow,
                              title: 'Pending'.tr(),
                              radius: 50,
                              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            PieChartSectionData(
                              value: (10 - _bookings.length).toDouble(),
                              color: AppTheme.lightGray,
                              title: 'Available'.tr(),
                              radius: 50,
                              titleStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(),

                  const SizedBox(height: 24),

                  // Itinerary Timeline
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Itinerary'.tr(), style: AppTheme.titleLarge),
                  ).animate().fadeIn(),
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
                        key: Key((item['id'] as int?)?.toString() ?? '0'),
                        title: Text(item['name'] as String? ?? ''),
                        subtitle: Text(
                          '${item['description'] as String? ?? ''} (Duration: ${(item['duration'] as Duration?)?.inHours ?? 0}h ${(item['duration'] as Duration?)?.inMinutes.remainder(60) ?? 0}m, Time: ${item['time'] as String? ?? ''}'),
                        leading: const Icon(Icons.location_on),
                        trailing: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(Icons.drag_handle),
                        ),
                      ).animate().fadeIn();
                    },
                  ),
                ],
              ),
            ),

    );
  }
}