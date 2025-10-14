import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:siwa/app/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tourist_search'),
        ),
        title: Text('Siwa Shali Lodge'.tr()),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                autoPlay: true,
              ),
              items: [
                'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&h=600&fit=crop',
              ].map((url) => Image.network(url, fit: BoxFit.cover)).toList(),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'About',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'common.no'.tr()s natural beauty.',
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Reviews',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    '4.7'.tr(),
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: BarChart(
                          BarChartData(
                            borderData: FlBorderData(show: false),
                            barGroups: [
                              BarChartGroupData(
                                x: 5,
                                barRods: [
                                  BarChartRodData(
                                    toY: 50,
                                    color: AppTheme.primaryOrange,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 4,
                                barRods: [
                                  BarChartRodData(
                                    toY: 30,
                                    color: AppTheme.primaryOrange,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(
                                    toY: 10,
                                    color: AppTheme.primaryOrange,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(
                                    toY: 5,
                                    color: AppTheme.primaryOrange,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(
                                    toY: 5,
                                    color: AppTheme.primaryOrange,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text('common.reviews'.tr()),
                    ],
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Amira Hassan'.tr()),
                  subtitle: Text(
                    '2 weeks ago\nAbsolutely loved my stay at Siwa Shali Lodge! The staff were incredibly welcoming, the rooms were beautifully decorated, and the location was perfect for exploring the oasis. Highly recommend!'
                        .tr(),
                  ),
                  trailing: Icon(Icons.thumb_up_off_alt),
                ),
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Omar Khaled'.tr()),
                  subtitle: Text(
                    'common.no'.tr()s expected in such a remote location.',
                  ),
                  trailing: Icon(Icons.thumb_up_off_alt),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Location',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(29.1829, 25.5495),
                  initialZoom: 12.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  const MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(29.1829, 25.5495),
                        child: Icon(Icons.location_pin, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/booking_form'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('navigation.bookings'.tr()),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.gray,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'navigation.home'.tr()),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'navigation.search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'navigation.bookings'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'navigation.profile'.tr(),
          ),
        ],
        onTap: (index) {
          if (index == 0) context.go('/tourist_home');
          if (index == 2) context.go('/tourist_bookings');
          if (index == 3) context.go('/tourist_profile');
        },
      ),
    );
  }
}
