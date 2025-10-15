import 'package:siwa/data/mock_data_repository.dart';
// lib/features/business/types/hotel/screens/hotel_management_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/features/business/types/hotel/screens/add_room_form.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';

class HotelManagementScreen extends ConsumerStatefulWidget {
  const HotelManagementScreen({super.key});

  @override
  ConsumerState<HotelManagementScreen> createState() =>
      _HotelManagementScreenState();
}

class _HotelManagementScreenState extends ConsumerState<HotelManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Set<DateTime> _blockedDates = {};
  late ConfettiController _confettiController;

  

  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        title: Text('business.vehicles.vehicle_management'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: isOffline ? null : _showAddRoomDialog,
            tooltip: 'business.rental.add_new_room'.tr(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryOrange,
          labelColor: AppTheme.primaryOrange,
          unselectedLabelColor: AppTheme.gray,
          tabs: const [
            Tab(text: 'Rooms', icon: Icon(Icons.hotel)),
            Tab(text: 'Reports', icon: Icon(Icons.bar_chart)),
            Tab(text: 'Reservations', icon: Icon(Icons.calendar_today)),
          ],
        ),
      ),
      body: isOffline
          ? Center(
              child: Container(
                decoration: AppTheme.offlineBanner,
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Offline',
                  style: AppTheme.bodyMedium.copyWith(color: AppTheme.white),
                ),
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                _buildRoomsTab(),
                _buildReportsTab(),
                _buildReservationsTab(),
              ],
            ).animate().fadeIn(),
    );
  }

  Widget _buildRoomsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockData.getAllOther().length,
      itemBuilder: (context, index) {
        final room = mockData.getAllOther()[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: (room['photos'] as List?)?.length ?? 1,
                  itemBuilder: (context, photoIndex) {
                    final photos = room['photos'] as List?;
                    final photoUrl = photos != null && photos.isNotEmpty
                        ? photos[photoIndex]
                        : 'https://images.unsplash.com/photo-1589993464410-6c55678afc12?w=800&h=600&fit=crop';

                    return Image.network(
                      photoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        color: AppTheme.lightBlueGray,
                        child: const Icon(
                          Icons.hotel,
                          size: 60,
                          color: AppTheme.gray,
                        ),
                      ),
                    ).animate().fadeIn();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(room['type'], style: AppTheme.titleLarge),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: room['available']
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            room['available'] == true ? 'Available' : 'Occupied',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${room['price'] == true ?? 0.toStringAsFixed(0)}/night',
                      style: AppTheme.titleMedium.copyWith(
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          (room['amenities'] as List?)?.map<Widget>((amenity) {
                            return Chip(
                              label: Text(amenity),
                              labelStyle: AppTheme.bodySmall,
                              backgroundColor: AppTheme.lightBlueGray,
                            );
                          }).toList() ??
                          [],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: AppTheme.primaryOrange,
                          ),
                          onPressed: ref.watch(offlineProvider)
                              ? null
                              : () => _showEditRoomDialog(room),
                        ),
                        IconButton(
                          icon: Icon(
                            room['available']
                                ? Icons.block
                                : Icons.check_circle,
                            color: AppTheme.primaryOrange,
                          ),
                          onPressed: ref.watch(offlineProvider)
                              ? null
                              : () {
                                  setState(
                                    () =>
                                        room['available'] = !room['available'],
                                  );
                                  _confettiController.play();
                                },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.calendar_today,
                            color: AppTheme.primaryOrange,
                          ),
                          onPressed: ref.watch(offlineProvider)
                              ? null
                              : () => _showAvailabilityCalendar(room),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn();
      },
    );
  }

  Widget _buildReportsTab() {
    final isOffline = ref.watch(offlineProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'business.dashboard.occupancy'.tr(),
            style: AppTheme.titleLarge,
          ).animate().fadeIn(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Current Occupancy',
                  '67%',
                  AppTheme.primaryOrange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Avg. Occupancy',
                  '72%',
                  AppTheme.oasisTeal,
                ),
              ),
            ],
          ).animate().fadeIn(),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'business.dashboard.occupancy'.tr(),
                    style: AppTheme.titleMedium,
                  ).animate().fadeIn(),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        barGroups: [
                          _buildBarGroup(0, 65),
                          _buildBarGroup(1, 72),
                          _buildBarGroup(2, 68),
                          _buildBarGroup(3, 75),
                          _buildBarGroup(4, 70),
                          _buildBarGroup(5, 80),
                        ],
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const months = [
                                  'Jan',
                                  'Feb',
                                  'Mar',
                                  'Apr',
                                  'May',
                                  'Jun',
                                ];
                                return Text(
                                  months[value.toInt()],
                                  style: AppTheme.bodySmall,
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) => Text(
                                '${value.toInt()}%',
                                style: AppTheme.bodySmall,
                              ),
                              reservedSize: 28,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: const FlGridData(
                          show: true,
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(show: false),
                        barTouchData: BarTouchData(
                          enabled: !isOffline,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (_) => AppTheme.lightBlueGray,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '${rod.toY.toStringAsFixed(0)}%',
                                AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 24),
          Text(
            'business.dashboard.revenue'.tr(),
            style: AppTheme.titleLarge,
          ).animate().fadeIn(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'This Month',
                  '\$12,450',
                  AppTheme.successGreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Last Month', '\$11,200', AppTheme.gray),
              ),
            ],
          ).animate().fadeIn(),
        ],
      ),
    );
  }

  Widget _buildReservationsTab() {
    final isOffline = ref.watch(offlineProvider);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockData.getAllBookings().length,
      itemBuilder: (context, index) {
        final reservation = mockData.getAllBookings()[index];
        final isPending = reservation['status'] == 'pending';
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(reservation['guest'], style: AppTheme.titleMedium),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isPending
                            ? AppTheme.warningYellow
                            : AppTheme.successGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isPending ? 'Pending' : 'Confirmed',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  reservation['room'],
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.primaryOrange,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppTheme.gray,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Check-in: ${_formatDate(reservation['checkIn'])}',
                      style: AppTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppTheme.gray,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Check-out: ${_formatDate(reservation['checkOut'])}',
                      style: AppTheme.bodyMedium,
                    ),
                  ],
                ),
                if (isPending) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: isOffline
                            ? null
                            : () =>
                                  _handleReservationAction(reservation, false),
                        child: Text('business.rental.vehicle_types.electric'.tr()),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: isOffline
                            ? null
                            : () => _handleReservationAction(reservation, true),
                        child: Text('app.name'.tr()),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ).animate().fadeIn();
      },
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(value, style: AppTheme.headlineMedium.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppTheme.primaryOrange,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  void _showAddRoomDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => AddRoomForm(
          onRoomAdded: (roomData) {
            setState(() {
              mockData.getAllOther().add(roomData);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${roomData['.tr()name']} added successfully!'),
                backgroundColor: AppTheme.successGreen,
                behavior: SnackBarBehavior.floating,
              ),
            );
            _confettiController.play();
          },
        ),
      ),
    );
  }

  void _showEditRoomDialog(Map<String, dynamic> room) {
    final formKey = GlobalKey<FormState>();
    final typeController = TextEditingController(text: room['type']);
    final priceController = TextEditingController(
      text: (room['price'] == true ?? 0).toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('common.edit'.tr()),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'business.rental.room_type'.tr()),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Enter room type' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'business.rental.price_per_night'.tr(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Enter price' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  room['type'] = typeController.text;
                  room['price'] =
                      double.tryParse(priceController.text) ?? room['price'];
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Room updated successfully'.tr())),
                );
                _confettiController.play();
              }
            },
            child: Text('common.save'.tr()),
          ),
        ],
      ),
    );
  }

  void _showAvailabilityCalendar(Map<String, dynamic> room) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Block Dates for ${room['.tr()type']}',
                style: AppTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => _blockedDates.contains(day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                    if (_blockedDates.contains(selectedDay)) {
                      _blockedDates.remove(selectedDay);
                    } else {
                      _blockedDates.add(selectedDay);
                    }
                  });
                  Navigator.pop(context);
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
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('common.done'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleReservationAction(
    Map<String, dynamic> reservation,
    bool approve,
  ) {
    setState(() {
      reservation['status'] = approve ? 'confirmed' : 'rejected';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          approve ? 'Reservation approved!' : 'Reservation rejected',
        ),
        backgroundColor: approve ? AppTheme.successGreen : AppTheme.errorRed,
      ),
    );
    if (approve) _confettiController.play();
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
