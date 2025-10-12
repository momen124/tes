// lib/features/business/types/tour_guide/screens/guide_schedule_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:siwa/features/business/models/business_type.dart';
import 'package:siwa/features/business/widgets/navigation/business_bottom_nav.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:confetti/confetti.dart';

class GuideScheduleScreen extends ConsumerStatefulWidget {
  const GuideScheduleScreen({super.key});

  @override
  ConsumerState<GuideScheduleScreen> createState() => _GuideScheduleScreenState();
}

class _GuideScheduleScreenState extends ConsumerState<GuideScheduleScreen> {
  late ConfettiController _confettiController;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Set<DateTime> _blockedDates = {};
  final Map<DateTime, List<Map<String, dynamic>>> _tours = {};
  final List<String> _expertiseTags = [
    'History',
    'Eco-Tourism',
    'Adventure',
    'Culture',
    'Photography',
  ];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
    // Add sample tours
    final today = DateTime.now();
    _tours[DateTime(today.year, today.month, today.day + 2)] = [
      {
        'id': 1,
        'title': 'Siwa Fortress Tour',
        'duration': '3 hours',
        'guests': 4,
        'price': 120.0,
      },
    ];
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
          onPressed: isOffline ? null : () => context.go('/business_dashboard'),
        ),
        title: const Text('Guide Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: isOffline ? null : _showExpertiseDialog,
            tooltip: 'Update Expertise',
          ),
        ],
      ),
      body: isOffline
          ? Center(
              child: Container(
                decoration: AppTheme.offlineBanner,
                padding: const EdgeInsets.all(12),
                child: const Text('You are offline'),
              ),
            )
          : Column(
              children: [
                _buildCalendar().animate().fadeIn(),
                _buildToursList().animate().fadeIn(),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: isOffline || _selectedDay == null ? null : () => _showAddTourDialog(_selectedDay!),
        icon: const Icon(Icons.add),
        label: const Text('Add Tour'),
        backgroundColor: _selectedDay != null && !isOffline ? AppTheme.primaryOrange : AppTheme.gray,
      ),

    );
  }

  Widget _buildCalendar() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
              color: AppTheme.primaryOrange,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: AppTheme.primaryOrange.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            markerDecoration: const BoxDecoration(
              color: AppTheme.oasisTeal,
              shape: BoxShape.circle,
            ),
          ),
          eventLoader: (day) {
            final normalizedDay = DateTime(day.year, day.month, day.day);
            return _tours[normalizedDay] ?? [];
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
      ),
    );
  }

  Widget _buildToursList() {
    if (_selectedDay == null) {
      return Expanded(
        child: Center(
          child: Text(
            'Select a date to view tours',
            style: AppTheme.bodyLarge.copyWith(color: AppTheme.gray),
          ),
        ),
      );
    }

    final normalizedDay = DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
    final toursForDay = _tours[normalizedDay] ?? [];

    if (toursForDay.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.event_available, size: 64, color: AppTheme.gray),
              const SizedBox(height: 16),
              Text(
                'No tours scheduled',
                style: AppTheme.bodyLarge.copyWith(color: AppTheme.gray),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: toursForDay.length,
        itemBuilder: (context, index) {
          final tour = toursForDay[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.tour, color: AppTheme.primaryOrange),
              ),
              title: Text(tour['title'], style: AppTheme.titleMedium),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Duration: ${tour['duration']}'),
                  Text('Guests: ${tour['guests']}'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${tour['price'].toStringAsFixed(0)}",
                    style: AppTheme.titleMedium.copyWith(color: AppTheme.primaryOrange),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: ref.watch(offlineProvider)
                            ? null
                            : () => _showEditTourDialog(tour, normalizedDay),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn();
        },
      ),
    );
  }

  void _showAddTourDialog(DateTime day) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final durationController = TextEditingController();
    final guestsController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Tour - ${_formatDate(day)}'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Tour Title'),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter tour title' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: durationController,
                  decoration: const InputDecoration(labelText: 'Duration (e.g., 3 hours)'),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter duration' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: guestsController,
                  decoration: const InputDecoration(labelText: 'Number of Guests'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter number of guests' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter price' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final normalizedDay = DateTime(day.year, day.month, day.day);
                setState(() {
                  if (_tours[normalizedDay] == null) {
                    _tours[normalizedDay] = [];
                  }
                  _tours[normalizedDay]!.add({
                    'id': DateTime.now().millisecondsSinceEpoch,
                    'title': titleController.text,
                    'duration': durationController.text,
                    'guests': int.tryParse(guestsController.text) ?? 1,
                    'price': double.tryParse(priceController.text) ?? 0.0,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tour added successfully')),
                );
                _confettiController.play();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditTourDialog(Map<String, dynamic> tour, DateTime day) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController(text: tour['title']);
    final durationController = TextEditingController(text: tour['duration']);
    final guestsController = TextEditingController(text: tour['guests'].toString());
    final priceController = TextEditingController(text: tour['price'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Tour'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Tour Title'),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter tour title' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: durationController,
                  decoration: const InputDecoration(labelText: 'Duration'),
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter duration' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: guestsController,
                  decoration: const InputDecoration(labelText: 'Number of Guests'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter number of guests' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value?.isEmpty ?? true) ? 'Enter price' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _tours[day]?.remove(tour));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tour deleted')),
              );
              _confettiController.play();
            },
            child: const Text('Delete', style: TextStyle(color: AppTheme.errorRed)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  tour['title'] = titleController.text;
                  tour['duration'] = durationController.text;
                  tour['guests'] = int.tryParse(guestsController.text) ?? tour['guests'];
                  tour['price'] = double.tryParse(priceController.text) ?? tour['price'];
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tour updated')),
                );
                _confettiController.play();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showExpertiseDialog() {
    final editableTags = List<String>.from(_expertiseTags);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Your Expertise'),
            content: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: editableTags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: AppTheme.oasisTeal,
                  labelStyle: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                  onDeleted: () {
                    setState(() => editableTags.remove(tag));
                  },
                );
              }).toList(),
            ),
            actions: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Add new expertise',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty && !editableTags.contains(value)) {
                    setState(() => editableTags.add(value));
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() => _expertiseTags.clear());
                  setState(() => _expertiseTags.addAll(editableTags));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Expertise updated')),
                  );
                  _confettiController.play();
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}