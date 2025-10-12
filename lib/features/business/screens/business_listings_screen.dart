// lib/features/business/screens/business_listings_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/business/models/business_type.dart';
import 'package:siwa/features/business/widgets/navigation/business_bottom_nav.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class BusinessListingsScreen extends ConsumerStatefulWidget {
  const BusinessListingsScreen({super.key});

  @override
  ConsumerState<BusinessListingsScreen> createState() => _BusinessListingsScreenState();
}

class _BusinessListingsScreenState extends ConsumerState<BusinessListingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  XFile? _photo;
  String _category = '';
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _uploadPhoto() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _photo = image);
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/business_dashboard')),
        title: const Text('Create Listing'),
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
                  decoration: AppTheme.offlineBanner,
                  padding: const EdgeInsets.all(8),
                  child: const Row(
                    children: [
                      Icon(Icons.wifi_off, color: Colors.white),
                      SizedBox(width: 8),
                      Text('You are offline', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Listing Title',
                  hintText: 'e.g., Desert Camp Experience',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Describe your offering in detail',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Listing Photos'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: isOffline ? null : _uploadPhoto,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryOrange),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _photo == null
                        ? const Icon(Icons.add, size: 40, color: AppTheme.primaryOrange)
                        : Image.file(File(_photo!.path), fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'hotel', child: Text('Hotel')),
                        DropdownMenuItem(value: 'rental', child: Text('Rental')),
                        DropdownMenuItem(value: 'restaurant', child: Text('Restaurant')),
                      ],
                      value: _category.isNotEmpty ? _category : null,
                      onChanged: (value) => setState(() => _category = value ?? ''),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        labelText: 'Price per person',
                        hintText: '\$ 50',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Availability'),
              const SizedBox(height: 8),
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _selectedDate ?? DateTime.now(),
                onDaySelected: (selectedDay, focusedDay) => setState(() => _selectedDate = selectedDay),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isOffline
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Listing created!')),
                            );
                            context.go('/business_dashboard');
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Preview'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BusinessBottomNav(
        currentIndex: 1,
        businessType: BusinessType.hotel, // Dynamic from provider in real app
      ),
    );
  }
}