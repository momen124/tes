// lib/screens/booking_form_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:siwa/app/theme.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final int _currentStep = 0;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _guests = 2;
  final _specialRequestsController = TextEditingController();
  final String _paymentMethod = 'Visa **** 1234';
  final double _totalCost = 250.00;

  @override
  void dispose() {
    _specialRequestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Booking Form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Container(
              padding: const EdgeInsets.all(16),
              color: AppTheme.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step ${_currentStep + 1} of 5',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.gray,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentStep + 1) / 5,
                    backgroundColor: AppTheme.lightBlueGray,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryOrange),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Hotel Image
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1566073771259-6a8506099945'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Hotel Oasis',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Select Dates
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Select Dates',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                    color: AppTheme.primaryOrange,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppTheme.primaryOrange.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: const TextStyle(color: AppTheme.gray),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            // Guests
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Guests',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.secondaryGray.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$_guests',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_guests > 1) {
                            setState(() => _guests--);
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                        color: AppTheme.primaryOrange,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => _guests++);
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        color: AppTheme.primaryOrange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Special Requests
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Special Requests',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _specialRequestsController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'e.g., dietary restrictions, room preferences',
                  hintStyle: const TextStyle(color: AppTheme.secondaryGray),
                  filled: true,
                  fillColor: AppTheme.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppTheme.secondaryGray.withOpacity(0.3)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Payment Method
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Payment Method',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.secondaryGray.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.credit_card, color: AppTheme.gray),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _paymentMethod,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppTheme.gray),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Total Cost
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Total Cost',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.secondaryGray.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${_totalCost.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryOrange,
                    ),
                  ),
                  const Icon(Icons.attach_money, color: AppTheme.gray),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Confirm Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedDay == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                      return;
                    }
                    
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Booking Confirmed'),
                        content: const Text('Your booking has been confirmed!'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.go('/tourist_bookings');
                            },
                            child: const Text('View Bookings'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/tourist_home');
              break;
            case 1:
              context.push('/tourist_search');
              break;
            case 2:
              // Bookings
              break;
            case 3:
              context.push('/tourist_profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.gray,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.white,
      ),
    );
  }
}