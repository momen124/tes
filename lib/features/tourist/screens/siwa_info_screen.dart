import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class SiwaInfoScreen extends StatefulWidget {
  const SiwaInfoScreen({super.key});

  @override
  State<SiwaInfoScreen> createState() => _SiwaInfoScreenState();
}

class _SiwaInfoScreenState extends State<SiwaInfoScreen> {
  bool _historyExpanded = true;
  bool _bestTimeExpanded = false;
  bool _travelTipsExpanded = false;

  final List<Map<String, dynamic>> _relatedServices = [
    {
      'title': 'Desert Safari',
      'subtitle': 'Explore the dunes',
      'image': Icons.terrain,
    },
    {
      'title': 'Hot Air Balloon Ride',
      'subtitle': 'Sunrise views',
      'image': Icons.air,
    },
  ];

  Widget _buildMapPin(String label, Color color) {
    return Column(
      children: [
        Icon(Icons.location_pin, color: color, size: 32),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ],
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(content),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('Siwa Oasis'.tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1589993464410-6c55678afc12'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Siwa Oasis',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),

                  // Description
                  const Text(
                    'Siwa Oasis, a remote desert paradise in Egypt\'s Western Desert, is renowned for its ancient ruins, natural springs, and unique culture. It\'s a haven for travelers seeking tranquility and adventure.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // History Section
                  _buildExpandableSection(
                    title: 'History'.tr(),
                    isExpanded: _historyExpanded,
                    onTap: () => setState(() => _historyExpanded = !_historyExpanded),
                    content: 'Siwa\'s history dates back to ancient Egypt, serving as a crucial trade route and home to the Oracle of Amun. Its isolation preserved its unique Berber culture and traditions.',
                  ),
                  const SizedBox(height: 16),

                  // Best Time to Visit
                  _buildExpandableSection(
                    title: 'Best Time to Visit'.tr(),
                    isExpanded: _bestTimeExpanded,
                    onTap: () => setState(() => _bestTimeExpanded = !_bestTimeExpanded),
                    content: 'The best time to visit Siwa is between October and April when temperatures are mild. Avoid summer months (June-August) when it can get extremely hot.',
                  ),
                  const SizedBox(height: 16),

                  // Travel Tips
                  _buildExpandableSection(
                    title: 'Travel Tips'.tr(),
                    isExpanded: _travelTipsExpanded,
                    onTap: () => setState(() => _travelTipsExpanded = !_travelTipsExpanded),
                    content: '• Bring cash as ATMs are limited\n• Respect local customs and dress modestly\n• Stay hydrated in the desert climate\n• Book accommodations in advance during peak season\n• Try the local dates and olive oil',
                  ),
                  const SizedBox(height: 24),

                  // Map Section
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      color: AppTheme.lightBlueGray,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Stack(
                      children: [
                        // Map placeholder
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.map, size: 60, color: Colors.blue),
                                const SizedBox(height: 8),
                                Text('Interactive Map'.tr()),
                              ],
                            ),
                          ),
                        ),
                        // Map pins
                        Positioned(
                          top: 50,
                          left: 40,
                          child: _buildMapPin('Siwa Oasis', Colors.pink),
                        ),
                        Positioned(
                          top: 100,
                          right: 60,
                          child: _buildMapPin('Salt Lakes', Colors.pink),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 80,
                          child: _buildMapPin('Cleopatra\'s Bath', Colors.pink),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Related Services
                  Text(
                    'Related Services',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _relatedServices.length,
                    itemBuilder: (context, index) {
                      final service = _relatedServices[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryOrange.withOpacity(0.2),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    service['image'],
                                    size: 60,
                                    color: AppTheme.primaryOrange,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service['title'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    service['subtitle'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.gray,
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
                  const SizedBox(height: 24),

                  // Plan Your Visit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push('/tourist_search');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryOrange,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Plan Your Visit',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}