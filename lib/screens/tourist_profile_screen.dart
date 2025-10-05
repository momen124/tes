// lib/screens/tourist_profile_screen.dart
import 'package:flutter/material.dart';

class TouristProfileScreen extends StatelessWidget {
  const TouristProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Age Range')),
            // Preferences checkboxes
            CheckboxListTile(title: const Text('Eco-Tourism'), value: true, onChanged: (val) {}),
            TextField(decoration: const InputDecoration(labelText: 'Referral Code')),
            SwitchListTile(title: const Text('GPS Consent'), value: true, onChanged: (val) {}),
            // Challenges badges
            Row(
              children: const [Icon(Icons.star), Text('Challenges')],
            ),
          ],
        ),
      ),
    );
  }
}