import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';

class BusinessDashboardScreen extends StatelessWidget {
  const BusinessDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/tourist_home')),
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Total Bookings'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text('23', style: TextStyle(fontSize: 32, color: AppTheme.primaryOrange)),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Pending'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text('5', style: TextStyle(fontSize: 32, color: AppTheme.primaryOrange)),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Your Listings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildListingCard(
                  title: 'Siwa Shali Resort',
                  status: 'Published',
                  imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg?w=900&h=500&s=1',
                ),
                _buildListingCard(
                  title: 'Desert Oasis Camp',
                  status: 'Draft',
                  imageUrl: 'https://media-cdn.tripadvisor.com/media/attractions-splice-spp-720x480/10/70/9f/ba.jpg',
                ),
                _buildListingCard(
                  title: 'Mountain View...',
                  status: 'Published',
                  imageUrl: 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/36375216.jpg?k=7c4c3d7a3f023c70057a34f4191dbedca15bdf660e58c8c774efc912e87b893f&o=&hp=1',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.gray,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
        ],
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  Widget _buildListingCard({required String title, required String status, required String imageUrl}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        title: Text(title),
        subtitle: Text(status, style: TextStyle(color: AppTheme.primaryOrange)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit, color: AppTheme.primaryOrange), onPressed: () {}),
            IconButton(icon: const Icon(Icons.delete_outline, color: AppTheme.primaryOrange), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}