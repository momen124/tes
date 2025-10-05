import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_map/flutter_map.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service Detail')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: const [
                Placeholder(), // Mock photo
              ],
              options: CarouselOptions(),
            ),
            const Text('Description', style: TextStyle(fontSize: 16)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) => ListTile(title: Text('Review $index')),
            ),
            SizedBox(
              height: 200,
              child: FlutterMap(
                options: MapOptions(),
                children: [], // Added required 'children' parameter
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Book')),
          ],
        ),
      ),
    );
  }
}