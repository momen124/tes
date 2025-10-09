// lib/features/business/types/hotel/screens/hotel_management_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:fl_chart/fl_chart.dart';

class HotelManagementScreen extends StatefulWidget {
  const HotelManagementScreen({super.key});

  @override
  State<HotelManagementScreen> createState() => _HotelManagementScreenState();
}

class _HotelManagementScreenState extends State<HotelManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Set<DateTime> _blockedDates = {};
  
  final List<Map<String, dynamic>> _rooms = [
    {
      'id': 1,
      'type': 'Deluxe Suite',
      'price': 150.0,
      'amenities': ['WiFi', 'AC', 'TV', 'Mini Bar'],
      'available': true,
      'photos': ['https://cf.bstatic.com/xdata/images/hotel/max1024x768/36375216.jpg'],
    },
    {
      'id': 2,
      'type': 'Standard Room',
      'price': 80.0,
      'amenities': ['WiFi', 'AC', 'TV'],
      'available': true,
      'photos': ['https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg'],
    },
    {
      'id': 3,
      'type': 'Family Room',
      'price': 200.0,
      'amenities': ['WiFi', 'AC', 'TV', 'Kitchen', 'Balcony'],
      'available': false,
      'photos': ['https://media-cdn.tripadvisor.com/media/attractions-splice-spp-720x480/10/70/9f/ba.jpg'],
    },
  ];

  final List<Map<String, dynamic>> _reservations = [
    {
      'id': 1,
      'guest': 'Sarah Johnson',
      'room': 'Deluxe Suite',
      'checkIn': DateTime.now().add(const Duration(days: 2)),
      'checkOut': DateTime.now().add(const Duration(days: 5)),
      'status': 'pending',
    },
    {
      'id': 2,
      'guest': 'Ahmed Hassan',
      'room': 'Family Room',
      'checkIn': DateTime.now().add(const Duration(days: 1)),
      'checkOut': DateTime.now().add(const Duration(days: 4)),
      'status': 'confirmed',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/business_dashboard'),
        ),
        title: const Text('Hotel Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRoomDialog,
            tooltip: 'Add Room',
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
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRoomsTab(),
          _buildReportsTab(),
          _buildReservationsTab(),
        ],
      ),
    );
  }

  Widget _buildRoomsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _rooms.length,
      itemBuilder: (context, index) {
        final room = _rooms[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Image Carousel
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: room['photos'].length,
                  itemBuilder: (context, photoIndex) {
                    return Image.network(
                      room['photos'][photoIndex],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        color: AppTheme.lightBlueGray,
                        child: const Icon(Icons.hotel, size: 60, color: AppTheme.gray),
                      ),
                    );
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
                        Text(
                          room['type'],
                          style: AppTheme.titleLarge,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: room['available'] ? AppTheme.successGreen : AppTheme.errorRed,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            room['available'] ? 'Available' : 'Occupied',
                            style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${room['price'].toStringAsFixed(0)}/night',
                      style: AppTheme.titleMedium.copyWith(color: AppTheme.primaryOrange),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: room['amenities'].map<Widget>((amenity) {
                        return Chip(
                          label: Text(amenity),
                          labelStyle: AppTheme.bodySmall,
                          backgroundColor: AppTheme.lightBlueGray,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: AppTheme.primaryOrange),
                          onPressed: () => _showEditRoomDialog(room),
                        ),
                        IconButton(
                          icon: Icon(
                            room['available'] ? Icons.block : Icons.check_circle,
                            color: AppTheme.primaryOrange,
                          ),
                          onPressed: () {
                            setState(() {
                              room['available'] = !room['available'];
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today, color: AppTheme.primaryOrange),
                          onPressed: () => _showAvailabilityCalendar(room),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Occupancy Overview', style: AppTheme.titleLarge),
          const SizedBox(height: 16),
          
          // Occupancy Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Current Occupancy', '67%', AppTheme.primaryOrange),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Avg. Occupancy', '72%', AppTheme.oasisTeal),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Occupancy Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Monthly Occupancy Rate', style: AppTheme.titleMedium),
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
                                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                                return Text(
                                  months[value.toInt()],
                                  style: AppTheme.bodySmall,
                                );
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          Text('Revenue Overview', style: AppTheme.titleLarge),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard('This Month', '\$12,450', AppTheme.successGreen),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Last Month', '\$11,200', AppTheme.gray),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReservationsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _reservations.length,
      itemBuilder: (context, index) {
        final reservation = _reservations[index];
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
                    Text(
                      reservation['guest'],
                      style: AppTheme.titleMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isPending ? AppTheme.warningYellow : AppTheme.successGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isPending ? 'Pending' : 'Confirmed',
                        style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  reservation['room'],
                  style: AppTheme.bodyMedium.copyWith(color: AppTheme.primaryOrange),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: AppTheme.gray),
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
                    const Icon(Icons.calendar_today, size: 16, color: AppTheme.gray),
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
                        onPressed: () => _handleReservationAction(reservation, false),
                        child: const Text('Reject'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _handleReservationAction(reservation, true),
                        child: const Text('Approve'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
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
            Text(
              value,
              style: AppTheme.headlineMedium.copyWith(color: color),
            ),
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
    final typeController = TextEditingController();
    final priceController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Room'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Room Type'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price per Night'),
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
              if (typeController.text.isNotEmpty && priceController.text.isNotEmpty) {
                setState(() {
                  _rooms.add({
                    'id': _rooms.length + 1,
                    'type': typeController.text,
                    'price': double.tryParse(priceController.text) ?? 0.0,
                    'amenities': ['WiFi', 'AC'],
                    'available': true,
                    'photos': ['https://cf.bstatic.com/xdata/images/hotel/max1024x768/36375216.jpg'],
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Room added successfully')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditRoomDialog(Map<String, dynamic> room) {
    final typeController = TextEditingController(text: room['type']);
    final priceController = TextEditingController(text: room['price'].toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Room'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Room Type'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price per Night'),
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
              setState(() {
                room['type'] = typeController.text;
                room['price'] = double.tryParse(priceController.text) ?? room['price'];
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Room updated successfully')),
              );
            },
            child: const Text('Save'),
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
              Text('Block Dates for ${room['type']}', style: AppTheme.titleMedium),
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
                  _showAvailabilityCalendar(room);
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
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleReservationAction(Map<String, dynamic> reservation, bool approve) {
    setState(() {
      reservation['status'] = approve ? 'confirmed' : 'rejected';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(approve ? 'Reservation approved!' : 'Reservation rejected'),
        backgroundColor: approve ? AppTheme.successGreen : AppTheme.errorRed,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}