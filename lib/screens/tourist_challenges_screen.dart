// lib/screens/tourist_challenges_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TouristChallengesScreen extends StatelessWidget {
  const TouristChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Challenges')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Upload Photo'),
            trailing: ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final image = await picker.pickImage(source: ImageSource.camera);
                // Mock upload
              },
              child: const Text('Upload'),
            ),
          ),
          // Add more challenges
        ],
      ),
    );
  }
}