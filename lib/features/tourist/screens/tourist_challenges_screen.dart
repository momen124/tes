import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siwa/app/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/providers/mock_data_provider.dart';

class TouristChallengesScreen extends ConsumerStatefulWidget {
  const TouristChallengesScreen({super.key});

  @override
  ConsumerState<TouristChallengesScreen> createState() =>
      _TouristChallengesScreenState();
}

class _TouristChallengesScreenState extends ConsumerState<TouristChallengesScreen> {
  int get _totalPoints {
    return ref.watch(mockDataProvider).getAllChallenges()
        .where((c) => c['completed'] == true)
        .fold(0, (sum, c) => sum + (c['points'] as int? ?? 0));
  }

  int get _completedCount {
    return ref.watch(mockDataProvider).getAllChallenges().where((c) => c['completed'] == true).length;
  }

  Future<void> _uploadPhoto(Map<String, dynamic> challenge) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        challenge['proof'] = image.path;
        challenge['completed'] = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${'tourist.challenges.challenge_completed'.tr()} ${challenge['points'] ?? 0} ${'tourist.challenges.points'.tr()}",
            ),
            backgroundColor: AppTheme.successGreen,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final challenges = ref.watch(mockDataProvider).getAllChallenges();
    
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
                    '$_totalPoints ${'tourist.challenges.pts'.tr()}',
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
                  value: challenges.isEmpty
                      ? 0
                      : _completedCount / challenges.length,
                  backgroundColor: AppTheme.gray.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation(
                    AppTheme.primaryOrange,
                  ),
                  minHeight: 8,
                ),
                const SizedBox(height: 8),
                Text(
                  '$_completedCount/${challenges.length} ${'tourist.challenges.completed'.tr()}',
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.gray),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Challenge Cards
          Expanded(
            child: challenges.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 80,
                          color: AppTheme.gray.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'tourist.challenges.no_challenges'.tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppTheme.gray,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: challenges.length,
                    itemBuilder: (context, index) {
                      final challenge = challenges[index];
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
                                  image: challenge['imageUrl'] != null
                                      ? NetworkImage(challenge['imageUrl'] as String)
                                      : const AssetImage('assets/placeholder.png') as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: challenge['completed'] == true
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
                                          challenge['title']?.toString() ?? 'tourist.challenges.no_title'.tr(),
                                          style: AppTheme.titleMedium,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: challenge['completed'] == true
                                              ? AppTheme.successGreen
                                              : AppTheme.primaryOrange,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          '+${challenge['points']?.toString() ?? '0'} ${'tourist.challenges.pts'.tr()}',
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
                                    challenge['description']?.toString() ?? 'tourist.challenges.no_description'.tr(),
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: AppTheme.gray,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: challenge['completed'] == true
                                          ? null
                                          : () => _uploadPhoto(challenge),
                                      icon: Icon(
                                        challenge['completed'] == true
                                            ? Icons.check_circle
                                            : Icons.camera_alt,
                                      ),
                                      label: Text(
                                        challenge['completed'] == true
                                            ? 'tourist.challenges.completed_button'.tr()
                                            : 'tourist.challenges.upload_photo'.tr(),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: challenge['completed'] == true
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