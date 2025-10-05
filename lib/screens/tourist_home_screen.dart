import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TouristHomeScreen extends StatelessWidget {
  const TouristHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD2B48C), Color(0xFFF5E8C7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Siwa...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFFF7518))),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            TabBar(
              tabs: const [
                Tab(text: 'Accommodations'),
                Tab(text: 'Transportation'),
                Tab(text: 'Attractions'),
                Tab(text: 'Products'),
              ],
              labelColor: const Color(0xFF87CEEB),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 200,
                    child: CarouselSlider(
                      items: [
                        Card(child: Text('Siwa Camp')),
                      ],
                      options: CarouselOptions(),
                    ),
                  ),
                  Text('Hidden Gems', style: TextStyle(color: Color(0xFFFF7518))),
                  // Add ListView for gems as needed
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: const Color(0xFF87CEEB),
        unselectedItemColor: const Color(0xFFFF7518),
      ),
    );
  }
}