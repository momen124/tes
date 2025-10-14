// lib/screens/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:siwa/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: Text('common.details'.tr()),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                viewportFraction: 1.0,
                autoPlay: true,
              ),
              items: [
                'https://www.kemetexperience.com/wp-content/uploads/2019/09/incredible-white-desert-960x636.jpg',
                'https://www.sharm-club.com/assets/images/oasis/tour-white-desert-safari.jpg',
              ].map((url) => Image.network(url, fit: BoxFit.cover)).toList(),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'siwa_info.history'.tr(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Explore the hidden gems of Siwa Oasis with our expert guides. This tour includes visits to the ancient ruins, salt lakes, and traditional villages.'
                    .tr(),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Checkout'.tr(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'tourist.booking.payment_method'.tr(),
                  suffixIcon: const Icon(Icons.credit_card),
                  filled: true,
                  fillColor: AppTheme.lightBlueGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                readOnly: true,
                controller: TextEditingController(text: 'Visa **** 4242'),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'tourist.booking.total_cost'.tr(),
                  filled: true,
                  fillColor: AppTheme.lightBlueGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                readOnly: true,
                controller: TextEditingController(text: '\$220'),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle payment
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('common.no'.tr()),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
          if (index == 1) context.go('/tourist_search');
          if (index == 2) context.go('/tourist_bookings');
          if (index == 3) context.go('/tourist_profile');
        },
      ),
    );
  }
}
