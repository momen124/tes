// lib/features/business/types/tour_guide/screens/guide_schedule_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';

class GuideScheduleScreen extends StatefulWidget {
  const GuideScheduleScreen({super.key});

  @override
  State<GuideScheduleScreen> createState() => _GuideScheduleScreenState();
}

class _GuideScheduleScreenState extends State<GuideScheduleScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/business_dashboard'),
        ),
        title: const Text('Guide Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: _showExpertiseDialog,
            tooltip: 'Update Expertise',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCalendar(),
          _buildToursList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _selectedDay != null ? () => _showAddTourDialog(_selectedDay!) : null,
        icon: const Icon(Icons.add),
        label: const Text('Add Tour'),
        backgroundColor: _selectedDay != null ? AppTheme.primaryOrange : AppTheme.gray,
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
                        onPressed: () => _showEditTourDialog(tour, normalizedDay),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddTourDialog(DateTime day) {
    final titleController = TextEditingController();
    final durationController = TextEditingController();
    final guestsController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Tour - ${_formatDate(day)}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Tour Title'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(labelText: 'Duration (e.g., 3 hours)'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: guestsController,
                decoration: const InputDecoration(labelText: 'Number of Guests'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
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
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditTourDialog(Map<String, dynamic> tour, DateTime day) {
    final titleController = TextEditingController(text: tour['title']);
    final durationController = TextEditingController(text: tour['duration']);
    final guestsController = TextEditingController(text: tour['guests'].toString());
    final priceController = TextEditingController(text: tour['price'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Tour'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Tour Title'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(labelText: 'Duration'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: guestsController,
                decoration: const InputDecoration(labelText: 'Number of Guests'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _tours[day]?.remove(tour);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tour deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: AppTheme.errorRed)),
          ),
          ElevatedButton(
            onPressed: () {
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
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showExpertiseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Expertise'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _expertiseTags.map((tag) {
            return Chip(
              label: Text(tag),
              backgroundColor: AppTheme.oasisTeal,
              labelStyle: AppTheme.bodySmall.copyWith(color: AppTheme.white),
            );
          }).toList(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

