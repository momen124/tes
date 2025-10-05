// lib/screens/business_listings_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/utils/theme.dart';

class BusinessListingsScreen extends StatelessWidget {
  const BusinessListingsScreen({super.key});

  Future<void> _uploadPhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    // Handle upload
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/business_dashboard')),
        title: const Text('Create Listing'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Listing Title',
                  hintText: 'e.g., Desert Camp Experience',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Describe your offering in detail',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              const Text('Listing Photos'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _uploadPhoto,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryOrange), // Changed to solid border
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Icon(Icons.add, size: 40, color: AppTheme.primaryOrange)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: const [DropdownMenuItem(child: Text('Select Category'), value: '')],
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Price per person',
                        hintText: '\$ 50',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Availability'),
              const SizedBox(height: 8),
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Preview'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.gray,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        onTap: (index) {
          if (index == 0) context.go('/tourist_home');
          if (index == 1) context.go('/tourist_search');
          if (index == 2) context.go('/tourist_bookings');
          if (index == 3) context.go('/tourist_profile');
        },
      ),
    );
  }
}