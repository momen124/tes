import 'package:siwa/data/mock_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siwa/app/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

class TouristChallengesScreen extends StatefulWidget {
  const TouristChallengesScreen({super.key});

  @override
  State<TouristChallengesScreen> createState() =>
      _TouristChallengesScreenState();
}

class _TouristChallengesScreenState extends State<TouristChallengesScreen> {
  

  int get _totalPoints {
    return mockData.getAllOther()
        .where((c) => c['completed'] == true)
        .fold(0, (sum, c) => sum + (c['points'] as int? ?? 0));
  }

  int get _completedCount {
    return mockData.getAllOther().where((c) => c['completed'] == true).length;
  }

  Future<void> _uploadPhoto(Map<String, dynamic> challenge) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        challenge['proof'] = image.path;
        challenge['completed'] = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${'tourist.challenges.challenge_completed'.tr()} ${challenge['points'] ?? ''} points",
          ),
          backgroundColor: AppTheme.successGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tourist_home'),
        ),
        title: Text('tourist.challenges.photo_challenges'.tr()),
        elevation: 0,
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryOrange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.stars, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '$_totalPoints pts',
                    style: AppTheme.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Section
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('tourist.challenges.challenge_progress'.tr(), style: AppTheme.titleMedium),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: mockData.getAllOther().isEmpty
                      ? 0
                      : _completedCount / mockData.getAllOther().length,
                  backgroundColor: AppTheme.gray.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation(
                    AppTheme.primaryOrange,
                  ),
                  minHeight: 8,
                ),
                const SizedBox(height: 8),
                Text(
                  '$_completedCount/${mockData.getAllOther().length} Completed',
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.gray),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Challenge Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: mockData.getAllOther().length,
              itemBuilder: (context, index) {
                final challenge = mockData.getAllOther()[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Challenge Image
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(challenge['imageUrl']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: challenge['completed']
                            ? Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.successGreen.withOpacity(0.8),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 64,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : null,
                      ),

                      // Challenge Details
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    challenge['title'],
                                    style: AppTheme.titleMedium,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: challenge['completed']
                                        ? AppTheme.successGreen
                                        : AppTheme.primaryOrange,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '+${challenge['points'] ?? ''} pts',
                                    style: AppTheme.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              challenge['description'],
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.gray,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: challenge['completed']
                                    ? null
                                    : () => _uploadPhoto(challenge),
                                icon: Icon(
                                  challenge['completed']
                                      ? Icons.check_circle
                                      : Icons.camera_alt,
                                ),
                                label: Text(
                                  challenge['completed']
                                      ? 'Completed'
                                      : 'Upload Photo',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: challenge['completed']
                                      ? AppTheme.successGreen
                                      : AppTheme.primaryOrange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const TouristBottomNav(currentIndex: 2),
    );
  }
}
