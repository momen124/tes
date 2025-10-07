import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import '../widgets/service_card.dart';

class TouristSearchScreen extends StatefulWidget {
  const TouristSearchScreen({super.key});

  @override
  State<TouristSearchScreen> createState() => _TouristSearchScreenState();
}

class _TouristSearchScreenState extends State<TouristSearchScreen> {
  final _searchController = TextEditingController(text: 'Siwa');
  String _priceFilter = 'Price';
  String _locationFilter = 'Location';
  bool _ecoTourism = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.lightBlueGray,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/tourist_home')),
        title: const Text('Search'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Siwa',
                  suffixIcon: const Icon(Icons.close),
                  filled: true,
                  fillColor: AppTheme.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: _priceFilter,
                  items: const [DropdownMenuItem(child: Text('Price'), value: 'Price')],
                  onChanged: (value) {},
                  underline: const SizedBox(),
                ),
                DropdownButton<String>(
                  value: _locationFilter,
                  items: const [DropdownMenuItem(child: Text('Location'), value: 'Location')],
                  onChanged: (value) {},
                  underline: const SizedBox(),
                ),
                FilterChip(
                  label: const Text('Eco-tourism'),
                  selected: _ecoTourism,
                  onSelected: (selected) => setState(() => _ecoTourism = selected),
                  selectedColor: AppTheme.primaryOrange.withOpacity(0.2),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ServiceCard(
                  name: 'Siwa Shali Resort',
                  price: 120.0, // Added price
                  rating: 4.5,  // Added rating (required)
                  location: 'Siwa, Egypt',
                  imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg?w=900&h=500&s=1',
                ),
                ServiceCard(
                  name: 'Adrar Amellal',
                  price: 150.0, // Added price
                  rating: 4.7,  // Added rating (required)
                  location: 'Siwa, Egypt',
                  imageUrl: 'https://www.adrereamellal.com/adrere/wp-content/uploads/2019/09/Adrere-amellal-siwa-oasis-eco-lodge-Omar-Hikal.jpg',
                ),
                ServiceCard(
                  name: 'Taziry Ecolodge Siwa',
                  price: 90.0,  // Added price
                  rating: 4.3,  // Added rating (required)
                  location: 'Siwa, Egypt',
                  imageUrl: 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/4107994.jpg?k=5ec22bfde0619d0d2e92e0df7e3bd83be9fb281504879ad451e4c5b3bd532bfe&o=&hp=1',
                ),
                ServiceCard(
                  name: 'Siwa Safari Gardens Hotel',
                  price: 100.0, // Added price
                  rating: 4.4,  // Added rating (required)
                  location: 'Siwa, Egypt',
                  imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/19/99/b2/30/siwa-safari-gardens-hotel.jpg?w=900&h=500&s=1',
                ),
              ],
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