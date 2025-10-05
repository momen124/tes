// lib/screens/tourist_home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:siwa/utils/theme.dart';
import 'package:siwa/widgets/service_card.dart';

class TouristHomeScreen extends StatelessWidget {
  const TouristHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: const Icon(Icons.eco, color: Colors.green), // Logo
        title: const Text('Siwa Oasis', style: TextStyle(color: AppTheme.black)),
        actions: const [Icon(Icons.language, color: AppTheme.gray)], // Globe
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Where to?',
                  hintStyle: const TextStyle(color: AppTheme.gray),
                  prefixIcon: const Icon(Icons.search, color: AppTheme.gray),
                  filled: true,
                  fillColor: AppTheme.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryOrange,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text('Accommodations', style: TextStyle(color: AppTheme.white)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text('Transportation', style: TextStyle(color: AppTheme.gray)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text('Attractions', style: TextStyle(color: AppTheme.gray)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Featured', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: [
                  ServiceCard(
                    name: 'Desert Safari',
                    price: 80.0, // Added required price
                    rating: 4.6, // Added required rating
                    description: 'Explore the vast desert',
                    imageUrl: 'https://www.kemetexperience.com/wp-content/uploads/2019/09/incredible-white-desert-960x636.jpg',
                  ),
                  ServiceCard(
                    name: 'Oasis Retreat',
                    price: 110.0, // Added required price
                    rating: 4.8, // Added required rating
                    description: 'Relax in lush oasis',
                    imageUrl: 'https://www.travelandleisure.com/thmb/amlI6kTE1WDxle2u1zdACGm1INg=/1500x0/filters:no_upscale():max_bytes(200000):strip_icc()/TAL-adrere-amellal-terrace-SIWA0423-a107116c1ddf4bb19a6efd4121c89223.jpg',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Hidden Gems', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ServiceCard(
                    name: 'Abo Ali\'s Pottery',
                    price: 40.0, // Added required price
                    rating: 4.8, // Added required rating
                    description: 'Local pottery workshop',
                    reviews: 23,
                    imageUrl: 'https://trc-leiden.nl/trc-needles/media/k2/items/cache/aba5e2c8a475266deaf8d7f80d5274e5_XL.jpg',
                  ),
                  const SizedBox(height: 16),
                  ServiceCard(
                    name: 'Fatma\'s Weaving',
                    price: 35.0, // Added required price
                    rating: 4.7, // Added required rating
                    description: 'Traditional weaving',
                    reviews: 18,
                    imageUrl: 'https://thezay.org/wp-content/uploads/2021/04/Zay-Siwa-blog-1-pic-5.jpg',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppTheme.primaryOrange,
        unselectedItemColor: AppTheme.gray,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        onTap: (index) {
          if (index == 1) context.go('/tourist_search');
          if (index == 2) context.go('/tourist_bookings');
          if (index == 3) context.go('/tourist_profile');
        },
      ),
    );
  }
}