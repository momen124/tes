import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:fl_chart/fl_chart.dart';

class TripItineraryScreen extends ConsumerStatefulWidget {
  const TripItineraryScreen({super.key});

  @override
  ConsumerState<TripItineraryScreen> createState() => _TripItineraryScreenState();
}

class _TripItineraryScreenState extends ConsumerState<TripItineraryScreen> with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;

  // Mock data (replace with provider)
  final List<Map<String, dynamic>> _itinerary = [
    {
      'name': 'Salt Lakes',
      'duration': Duration(minutes: 60),
      'description': 'Explore natural salt lakes',
    },
    // Add more
  ];

  final List<Map<String, dynamic>> _bookings = [
    {
      'guest': 'Group of 5',
      'date': DateTime.now().add(const Duration(days: 5)),
    },
    // Add more
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
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  onReorder: (oldIndex, newIndex) {
                    if (!isOffline) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex--;
                        final item = _itinerary.removeAt(oldIndex);
                        _itinerary.insert(newIndex, item);
                      });
                    }
                  },
                  children: _itinerary.map((stop) => Card(
                    key: ValueKey(stop['name']),
                    child: ListTile(
                      leading: Icon(Icons.location_on, color: AppTheme.primaryOrange),
                      title: Text(stop['name'], style: AppTheme.titleMedium),
                      subtitle: Text('${stop['duration'].inMinutes} min - ${stop['description']}', style: AppTheme.bodyMedium),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: isOffline ? null : () => _showEditStopDialog(stop),
                      ),
                    ),
                  )).toList(),
                ).padding(all: 16),
                Text('Booking Reports', style: AppTheme.titleLarge).padding(horizontal: 16),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(value: _bookings.length.toDouble(), color: AppTheme.primaryOrange, title: 'Bookings'),
                        PieChartSectionData(value: 10 - _bookings.length.toDouble(), color: AppTheme.lightGray, title: 'Available'),
                      ],
                    ),
                  ),
                ).padding(all: 16),
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
          ),
        ],
      ),
    );
  }

  void _showAddStopDialog() {
    // Form for name, duration, description
    // On save, add to _itinerary, play confetti
  }

  void _showEditStopDialog(Map<String, dynamic> stop) {
    // Similar to add, pre-fill
  }
}