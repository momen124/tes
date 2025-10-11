// lib/features/business/screens/business_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/business/models/business_type.dart';
import 'package:siwa/features/business/widgets/navigation/business_bottom_nav.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:go_router/go_router.dart';
class BusinessProfileScreen extends ConsumerStatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  ConsumerState<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends ConsumerState<BusinessProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _businessName = '';
  String _email = '';
  String _phone = '';
  LatLng _location = const LatLng(29.1829, 25.5495);

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/business_dashboard')),
        title: const Text('Edit Profile'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isOffline)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: AppTheme.offlineBanner,
                  alignment: Alignment.center,
                  child: const Text('You are offline', style: TextStyle(color: Colors.white)),
                ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Business Name',
                  hintText: 'Siwa Gems & Crafts',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  errorText: _businessName.isEmpty && _formKey.currentState?.validate() == false ? 'Please enter a name' : null,
                ),
                onChanged: (value) => setState(() => _businessName = value),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contact Email',
                  hintText: 'contact@siwagems.com',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  errorText: _email.isEmpty && _formKey.currentState?.validate() == false ? 'Please enter an email' : null,
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => setState(() => _email = value),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contact Phone',
                  hintText: '+20 123 456 7890',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  errorText: _phone.isEmpty && _formKey.currentState?.validate() == false ? 'Please enter a phone number' : null,
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) => setState(() => _phone = value),
              ),
              const SizedBox(height: 24),
              const Text('Location'),
              const SizedBox(height: 4),
              const Text('Tap on the map to set your business location.'),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: _location,
                    initialZoom: 12.0,
                    onTap: (_, latlng) => setState(() => _location = latlng),
                  ),
                  children: [
                    TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _location,
                          child: const Icon(Icons.location_pin, color: AppTheme.primaryOrange, size: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isOffline || !_formKey.currentState!.validate()
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profile updated!')),
                            );
                            context.go('/business_dashboard');
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BusinessBottomNav(
        currentIndex: 3,
        businessType: BusinessType.hotel, // Dynamic from provider in real app
      ),
    );
  }
}