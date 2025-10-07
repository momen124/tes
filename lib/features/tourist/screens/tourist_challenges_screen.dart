import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siwa/utils/theme.dart';
import 'package:go_router/go_router.dart';

class TouristChallengesScreen extends StatelessWidget {
  const TouristChallengesScreen({super.key});

  Future<void> _uploadPhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    // Handle upload
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/tourist_home')),
        title: const Text('Photo Challenges'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Challenge Progress'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LinearProgressIndicator(
                value: 0.6,
                backgroundColor: AppTheme.gray.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation(AppTheme.primaryOrange),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('6/10 Completed', style: TextStyle(color: AppTheme.gray)),
            ),
            const SizedBox(height: 24),
            _buildChallengeCard(
              title: 'Capture the Sunset',
              description: 'Find the perfect spot to photograph the sunset over the desert dunes.',
              imageUrl: 'https://www.heatheronhertravels.com/wp-content/uploads/2011/09/Sunset-at-Fatnas-Island-in-Siwa-in-Egypt-2.jpg.webp',
            ),
            _buildChallengeCard(
              title: 'Hidden Oasis',
              description: 'Discover and photograph a hidden oasis within the Siwa desert.',
              imageUrl: 'https://thedaydreamdrifters.com/wp-content/uploads/2018/09/Siwa-Oasis-.jpg',
            ),
            _buildChallengeCard(
              title: 'Salt Lake Reflection',
              description: 'Capture the stunning reflections on the surface of the salt lakes.',
              imageUrl: 'https://visitegypt.com/wp-content/uploads/2025/07/the-salt-lake-siwa-oasis.webp',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,  // Assume challenges is index 2
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.gray,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Challenges'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  Widget _buildChallengeCard({required String title, required String description, required String imageUrl}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(color: AppTheme.gray)),
                ],
              ),
            ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _uploadPhoto,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Upload Photo'),
            ),
          ],
        ),
      ),
    );
  }
}