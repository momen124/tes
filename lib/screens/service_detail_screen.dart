import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:siwa/utils/theme.dart';
import 'package:go_router/go_router.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/tourist_search')),
        title: const Text('Siwa Shali Lodge'),
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
                'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg?w=900&h=500&s=1',
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
              child: Text('Siwa Shali Lodge offers a unique stay in the heart of Siwa Oasis, blending traditional architecture with modern comforts. Experience authentic Siwan hospitality in our eco-friendly lodge, surrounded by the oasis\'s natural beauty.'),
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
                  const Text('4.7', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
                              BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 50, color: AppTheme.primaryOrange)]),
                              BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 30, color: AppTheme.primaryOrange)]),
                              BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 10, color: AppTheme.primaryOrange)]),
                              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 5, color: AppTheme.primaryOrange)]),
                              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 5, color: AppTheme.primaryOrange)]),
                            ],
                          ),
                        ),
                      ),
                      const Text('125 reviews'),
                    ],
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const ListTile(
                  leading: CircleAvatar(),
                  title: Text('Amira Hassan'),
                  subtitle: Text('2 weeks ago\nAbsolutely loved my stay at Siwa Shali Lodge! The staff were incredibly welcoming, the rooms were beautifully decorated, and the location was perfect for exploring the oasis. Highly recommend!'),
                  trailing: Icon(Icons.thumb_up_off_alt),
                ),
                const ListTile(
                  leading: CircleAvatar(),
                  title: Text('Omar Khaled'),
                  subtitle: Text('1 month ago\nSiwa Shali Lodge is a great choice for a comfortable and authentic experience in Siwa. The lodge is well-maintained, and the staff are friendly. The only minor issue was the limited Wi-Fi, but that\'s expected in such a remote location.'),
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
                options: MapOptions(
                  initialCenter: LatLng(29.1829, 25.5495),
                  initialZoom: 12.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(29.1829, 25.5495),
                        child: const Icon(Icons.location_pin, color: Colors.red),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Book'),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
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