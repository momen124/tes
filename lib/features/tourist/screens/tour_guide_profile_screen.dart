// lib/features/tourist/screens/tour_guide_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TourGuideProfileScreen extends StatelessWidget {
  const TourGuideProfileScreen({super.key}); // Can take guide ID as argument

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch guide data from provider or API
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Profile Header with Image
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.orange.shade400, Colors.orange.shade700],
                      ),
                    ),
                    child: const Icon(Icons.person, size: 100, color: Colors.white70),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ahmed Hassan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              const Text(
                                '4.8',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                ' (127 reviews)',
                                style: TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Verified',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick Stats
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(Icons.tour, '150+', 'Tours'),
                      _buildStatItem(Icons.people, '800+', 'Tourists'),
                      _buildStatItem(Icons.calendar_today, '5', 'Years'),
                    ],
                  ),
                ),
                const Divider(),

                // Bio/Description
                _buildSection(
                  title: 'About'.tr(),
                  icon: Icons.info_outline,
                  child: const Text(
                    'Experienced tour guide specializing in Siwa Oasis adventures. '
                    'Passionate about sharing the rich history and natural beauty of '
                    'Egypt with visitors from around the world. Fluent in multiple '
                    'languages and certified in first aid and desert safety.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),

                // Languages Spoken
                _buildSection(
                  title: 'Languages'.tr(),
                  icon: Icons.language,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildLanguageChip('Arabic', Icons.check_circle, Colors.green),
                      _buildLanguageChip('English', Icons.check_circle, Colors.green),
                      _buildLanguageChip('French', Icons.check_circle, Colors.green),
                      _buildLanguageChip('German', Icons.circle_outlined, Colors.grey),
                    ],
                  ),
                ),

                // Certifications
                _buildSection(
                  title: 'Certifications'.tr(),
                  icon: Icons.verified,
                  child: Column(
                    children: [
                      _buildCertificationItem(
                        Icons.badge,
                        'Certified Siwa Tour Guide',
                        'Ministry of Tourism - 2019',
                      ),
                      _buildCertificationItem(
                        Icons.medical_services,
                        'First Aid Certified',
                        'Egyptian Red Crescent - 2023',
                      ),
                      _buildCertificationItem(
                        Icons.terrain,
                        'Desert Safety Specialist',
                        'Desert Adventure Association - 2020',
                      ),
                      _buildCertificationItem(
                        Icons.history_edu,
                        'Egyptian History Expert',
                        'Cairo University - 2018',
                      ),
                    ],
                  ),
                ),

                // Specializations
                _buildSection(
                  title: 'Specializations'.tr(),
                  icon: Icons.star_outline,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildSpecializationTag('Desert Adventures'),
                      _buildSpecializationTag('Historical Sites'),
                      _buildSpecializationTag('Photography Tours'),
                      _buildSpecializationTag('Cultural Experiences'),
                      _buildSpecializationTag('Sunset Tours'),
                      _buildSpecializationTag('Stargazing'),
                    ],
                  ),
                ),

                // Photo Gallery
                _buildSection(
                  title: 'Photo Gallery'.tr(),
                  icon: Icons.photo_library,
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 120,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.image, size: 40, color: Colors.grey[600]),
                        );
                      },
                    ),
                  ),
                ),

                // Reviews Section
                _buildSection(
                  title: 'Reviews'.tr(),
                  icon: Icons.rate_review,
                  trailing: TextButton(
                    onPressed: () {
                      // Navigate to all reviews
                    },
                    child: Text('See All'.tr()),
                  ),
                  child: Column(
                    children: [
                      _buildReviewItem(
                        'Sarah Johnson',
                        5,
                        'Amazing experience! Ahmed was knowledgeable and friendly.',
                        '2 days ago',
                      ),
                      _buildReviewItem(
                        'Michael Chen',
                        5,
                        'Best tour guide in Siwa. Highly recommended!',
                        '1 week ago',
                      ),
                      _buildReviewItem(
                        'Emma Williams',
                        4,
                        'Great tour, very informative and well organized.',
                        '2 weeks ago',
                      ),
                    ],
                  ),
                ),

                // Available Tours
                _buildSection(
                  title: 'Available Tours'.tr(),
                  icon: Icons.explore,
                  child: Column(
                    children: [
                      _buildTourItem(
                        'Siwa Oasis Discovery',
                        '8 hours',
                        '\$120',
                        Icons.landscape,
                      ),
                      _buildTourItem(
                        'Desert Sunset Safari',
                        '4 hours',
                        '\$80',
                        Icons.wb_twilight,
                      ),
                      _buildTourItem(
                        'Historical Sites Tour',
                        '6 hours',
                        '\$100',
                        Icons.museum,
                      ),
                    ],
                  ),
                ),

                // Schedule/Availability
                _buildSection(
                  title: 'Schedule'.tr(),
                  icon: Icons.calendar_month,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upcoming Availability',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      const SizedBox(height: 12),
                      _buildAvailabilityItem('Mon, Oct 14', true),
                      _buildAvailabilityItem('Tue, Oct 15', true),
                      _buildAvailabilityItem('Wed, Oct 16', false),
                      _buildAvailabilityItem('Thu, Oct 17', true),
                      _buildAvailabilityItem('Fri, Oct 18', true),
                    ],
                  ),
                ),

                const SizedBox(height: 100), // Space for bottom buttons
              ],
            ),
          ),
        ],
      ),

      // Bottom Action Buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {
                // Contact guide
                _showContactDialog(context);
              },
              icon: const Icon(Icons.message),
              label: Text('Contact'.tr()),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                side: const BorderSide(color: Colors.orange),
                foregroundColor: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/booking_form', arguments: 'tour_guide');
                },
                icon: const Icon(Icons.book_online),
                label: Text('Book Now'.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (trailing != null) ...[
                const Spacer(),
                trailing,
              ],
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildLanguageChip(String language, IconData icon, Color color) {
    return Chip(
      avatar: Icon(icon, size: 18, color: color),
      label: Text(language),
      backgroundColor: Colors.grey[100],
    );
  }

  Widget _buildCertificationItem(IconData icon, String title, String issuer) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orange.withOpacity(0.1),
        child: Icon(icon, color: Colors.orange),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(issuer, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSpecializationTag(String text) {
    return Chip(
      label: Text(text, style: const TextStyle(fontSize: 13)),
      backgroundColor: Colors.orange.withOpacity(0.1),
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildReviewItem(String name, int rating, String comment, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.orange.withOpacity(0.2),
                child: Text(name[0], style: const TextStyle(color: Colors.orange)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          size: 16,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(date, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildTourItem(String title, String duration, String price, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.withOpacity(0.1),
          child: Icon(icon, color: Colors.orange),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(duration),
        trailing: Text(
          price,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }

  Widget _buildAvailabilityItem(String date, bool available) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: available ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: available ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            available ? Icons.check_circle : Icons.cancel,
            color: available ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            date,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            available ? 'Available' : 'Booked',
            style: TextStyle(
              color: available ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact Guide'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.orange),
              title: Text('+20 123 456 7890'.tr()),
              onTap: () {
                // Launch phone dialer
              },
            ),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.orange),
              title: Text('ahmed@siwatourscom'.tr()),
              onTap: () {
                // Launch email
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.orange),
              title: Text('Send Message'.tr()),
              onTap: () {
                // Open chat
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'.tr()),
          ),
        ],
      ),
    );
 
  }
}