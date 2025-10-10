import 'package:flutter/material.dart';

class TourGuideProfileScreen extends StatelessWidget {
  const TourGuideProfileScreen({super.key}); // Can take guide ID as argument

  @override
  Widget build(BuildContext context) {
    // Fetch guide data from provider or API
    return Scaffold(
      appBar: AppBar(title: const Text('Tour Guide Profile')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image
            Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(child: Text('Guide Photo')),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Certifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const ListTile(title: Text('Certified Siwa Tour Guide')),
            const ListTile(title: Text('First Aid Certified')),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Schedule', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            // Calendar widget or list
            const ListTile(title: Text('Available: Oct 10 - Oct 15')),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/booking_form', arguments: 'tour_guide'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(double.infinity, 50)),
          child: const Text('Book Now', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}