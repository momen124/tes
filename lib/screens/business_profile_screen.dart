import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class BusinessProfileScreen extends StatelessWidget {
  const BusinessProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(decoration: const InputDecoration(labelText: 'Name')),
              TextFormField(decoration: const InputDecoration(labelText: 'Contact Email')),
              SizedBox(
                height: 200,
                child: FlutterMap(
                  options: MapOptions(),
                  children: [
                    // Map layers or tiles go here
                  ],
                ),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
}