// lib/features/tourist/screens/services_list_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServicesListScreen extends ConsumerStatefulWidget {
  const ServicesListScreen({super.key});

  @override
  ConsumerState<ServicesListScreen> createState() => _ServicesListScreenState();
}

class _ServicesListScreenState extends ConsumerState<ServicesListScreen> {
  String _selectedCategory = 'all';

  // Service categories
  final List<Map<String, dynamic>> _serviceCategories = [
    {
      'id': 'medical',
      'name': 'Medical Services',
      'nameAr': 'الخدمات الطبية',
      'icon': Icons.local_hospital,
      'color': Colors.red,
      'subcategories': ['hospitals', 'clinics', 'pharmacies', 'emergency']
    },
    {
      'id': 'financial',
      'name': 'Financial Services',
      'nameAr': 'الخدمات المالية',
      'icon': Icons.account_balance,
      'color': Colors.green,
      'subcategories': ['banks', 'atms', 'currency_exchange']
    },
    {
      'id': 'communication',
      'name': 'Communication',
      'nameAr': 'الاتصالات',
      'icon': Icons.wifi,
      'color': Colors.blue,
      'subcategories': ['internet_cafes', 'mobile_shops', 'post_office']
    },
    {
      'id': 'utilities',
      'name': 'Utilities & Repairs',
      'nameAr': 'المرافق والإصلاحات',
      'icon': Icons.build,
      'color': Colors.orange,
      'subcategories': ['car_repair', 'laundry', 'hair_salon']
    },
    {
      'id': 'government',
      'name': 'Government Services',
      'nameAr': 'الخدمات الحكومية',
      'icon': Icons.account_balance_outlined,
      'color': Colors.indigo,
      'subcategories': ['police', 'tourism_office', 'municipality']
    },
  ];

  // Mock services data
  final List<Map<String, dynamic>> _services = [
    // Medical
    {
      'id': '1',
      'name': 'Siwa Central Hospital',
      'nameAr': 'مستشفى سيوة المركزي',
      'category': 'medical',
      'subcategory': 'hospitals',
      'description': '24/7 emergency services and general medical care',
      'descriptionAr': 'خدمات طوارئ على مدار الساعة والرعاية الطبية العامة',
      'location': 'Downtown Siwa',
      'locationAr': 'وسط سيوة',
      'phone': '+20 123 456 7890',
      'hours': '24/7',
      'imageUrl': 'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=800',
      'rating': 4.2,
      'reviews': 45,
      'services': ['Emergency', 'General Practice', 'Laboratory', 'X-Ray'],
      'emergency': true,
    },
    {
      'id': '2',
      'name': 'Al-Shifa Pharmacy',
      'nameAr': 'صيدلية الشفاء',
      'category': 'medical',
      'subcategory': 'pharmacies',
      'description': 'Well-stocked pharmacy with prescription and OTC medications',
      'descriptionAr': 'صيدلية مجهزة جيداً بالأدوية الموصوفة وبدون وصفة',
      'location': 'Main Street',
      'locationAr': 'الشارع الرئيسي',
      'phone': '+20 123 456 7891',
      'hours': '8:00 AM - 11:00 PM',
      'imageUrl': 'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?w=800',
      'rating': 4.6,
      'reviews': 78,
      'services': ['Prescriptions', 'OTC Medications', 'Medical Supplies'],
    },
    
    // Financial
    {
      'id': '3',
      'name': 'National Bank of Egypt - Siwa',
      'nameAr': 'البنك الأهلي المصري - سيوة',
      'category': 'financial',
      'subcategory': 'banks',
      'description': 'Full banking services including currency exchange',
      'descriptionAr': 'خدمات مصرفية كاملة بما في ذلك صرف العملات',
      'location': 'City Center',
      'locationAr': 'مركز المدينة',
      'phone': '+20 123 456 7892',
      'hours': '9:00 AM - 3:00 PM (Sun-Thu)',
      'imageUrl': 'https://images.unsplash.com/photo-1541354329998-f4d9a9f9297f?w=800',
      'rating': 4.0,
      'reviews': 32,
      'services': ['ATM', 'Currency Exchange', 'Money Transfer'],
    },
    
    // Communication
    {
      'id': '4',
      ''name': 'Siwa Internet Café',
      'nameAr': 'مقهى إنترنت سيوة',
      'category': 'communication',
      'subcategory': 'internet_cafes',
      'description': 'High-speed internet and printing services',
      'descriptionAr': 'إنترنت عالي السرعة وخدمات طباعة',
      'location': 'Near Market Square',
      'locationAr': 'بالقرب من ساحة السوق',
      'phone': '+20 123 456 7893',
      'hours': '9:00 AM - 11:00 PM',
      'imageUrl': 'https://images.unsplash.com/photo-1556761175-4b46a572b786?w=800',
      'rating': 4.3,
      'reviews': 56,
      'services': ['Internet', 'Printing', 'Scanning', 'International Calls'],
    },
    
    // Utilities
    {
      'id': '5',
      'name': 'Desert Auto Repair',
      'nameAr': 'ورشة إصلاح السيارات الصحراوية',
      'category': 'utilities',
      'subcategory': 'car_repair',
      'description': 'Professional car maintenance and emergency repairs',
      'descriptionAr': 'صيانة السيارات المهنية والإصلاحات الطارئة',
      'location': 'Cairo Road',
      'locationAr': 'طريق القاهرة',
      'phone': '+20 123 456 7894',
      'hours': '8:00 AM - 6:00 PM',
      'imageUrl': 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=800',
      'rating': 4.5,
      'reviews': 67,
      'services': ['Tire Repair', 'Oil Change', 'Engine Repair', 'Towing'],
      'emergency': true,
    },
    
    // Government
    {
      'id': '6',
      'name': 'Siwa Tourism Information Center',
      'nameAr': 'مركز معلومات السياحة بسيوة',
      'category': 'government',
      'subcategory': 'tourism_office',
      'description': 'Tourist information, maps, and assistance',
      'descriptionAr': 'معلومات سياحية وخرائط ومساعدة',
      'location': 'Main Square',
      'locationAr': 'الميدان الرئيسي',
      'phone': '+20 123 456 7895',
      'hours': '9:00 AM - 5:00 PM',
      'imageUrl': 'https://images.unsplash.com/photo-1517457373958-b7bdd4587205?w=800',
      'rating': 4.7,
      'reviews': 123,
      'services': ['Maps', 'Tour Information', 'Permits', 'Assistance'],
    },
  ];

  List<Map<String, dynamic>> get _filteredServices {
    if (_selectedCategory == 'all') {
      return _services;
    }
    return _services.where((service) => service['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tourist_home'),
        ),
        title: Text(isArabic ? 'الخدمات' : 'Services'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.emergency),
            onPressed: () => _showEmergencyContacts(),
            tooltip: isArabic ? 'الطوارئ' : 'Emergency',
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            color: AppTheme.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildCategoryChip('All', 'all', Icons.apps, Colors.grey, isArabic),
                  ..._serviceCategories.map((category) => _buildCategoryChip(
                    isArabic ? category['nameAr'] : category['name'],
                    category['id'],
                    category['icon'],
                    category['color'],
                    isArabic,
                  )),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Services List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              itemCount: _filteredServices.length,
              itemBuilder: (context, index) {
                final service = _filteredServices[index];
                return _buildServiceCard(service, isArabic);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const SafeArea(
        child: TouristBottomNav(currentIndex: 1),
      ),
    );
  }

  Widget _buildCategoryChip(String label, String value, IconData icon, Color color, bool isArabic) {
    final isSelected = _selectedCategory == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppTheme.white : color,
            ),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
        onSelected: (selected) {
          setState(() => _selectedCategory = value);
        },
        selectedColor: color,
        backgroundColor: AppTheme.white,
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.white : AppTheme.darkGray,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, bool isArabic) {
    final name = isArabic ? service['nameAr'] : service['name'];
    final description = isArabic ? service['descriptionAr'] : service['description'];
    final location = isArabic ? service['locationAr'] : service['location'];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showServiceDetails(service, isArabic),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Emergency Badge
            Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: NetworkImage(service['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (service['emergency'] == true)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.errorRed,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.emergency, size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            isArabic ? 'طوارئ' : 'Emergency',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: AppTheme.primaryOrange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${service['rating']}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: AppTheme.gray),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppTheme.gray),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(fontSize: 13, color: AppTheme.gray),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: AppTheme.gray),
                      const SizedBox(width: 4),
                      Text(
                        service['hours'],
                        style: const TextStyle(fontSize: 13, color: AppTheme.gray),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceDetails(Map<String, dynamic> service, bool isArabic) {
    final name = isArabic ? service['nameAr'] : service['name'];
    final description = isArabic ? service['descriptionAr'] : service['description'];
    final location = isArabic ? service['locationAr'] : service['location'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: controller,
            padding: EdgeInsets.zero,
            children: [
              // Image
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage(service['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(backgroundColor: Colors.black45),
                    ),
                  ),
                ],
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppTheme.primaryOrange, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${service['rating']} (${service['reviews']} reviews)',
                          style: const TextStyle(fontSize: 14, color: AppTheme.gray),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(description, style: const TextStyle(fontSize: 16, height: 1.5)),
                    const SizedBox(height: 24),

                    // Contact Info
                    _buildInfoRow(Icons.location_on, location),
                    _buildInfoRow(Icons.phone, service['phone']),
                    _buildInfoRow(Icons.access_time, service['hours']),
                    
                    const SizedBox(height: 24),

                    // Services
                    const Text('Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (service['services'] as List).map((s) => Chip(
                        label: Text(s),
                        backgroundColor: AppTheme.primaryOrange.withOpacity(0.1),
                        labelStyle: const TextStyle(color: AppTheme.primaryOrange),
                      )).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Open maps
                            },
                            icon: const Icon(Icons.directions),
                            label: Text(isArabic ? 'الاتجاهات' : 'Directions'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Call phone
                            },
                            icon: const Icon(Icons.phone),
                            label: Text(isArabic ? 'اتصال' : 'Call'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.primaryOrange),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  void _showEmergencyContacts() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.emergency, color: AppTheme.errorRed),
            SizedBox(width: 8),
            Text('Emergency Contacts'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEmergencyContact('Police', '122', Icons.local_police),
            _buildEmergencyContact('Ambulance', '123', Icons.local_hospital),
            _buildEmergencyContact('Fire Department', '180', Icons.local_fire_department),
            _buildEmergencyContact('Tourist Police', '+20 123 456 7896', Icons.support_agent),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String number, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.errorRed),
      title: Text(name),
      subtitle: Text(number),
      trailing: IconButton(
        icon: const Icon(Icons.phone, color: AppTheme.primaryOrange),
        onPressed: () {
          // Call number
        },
      ),
    );
  }
}