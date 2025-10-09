// lib/screens/tourist_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';

class TouristProfileScreen extends StatefulWidget {
  const TouristProfileScreen({super.key});

  @override
  State<TouristProfileScreen> createState() => _TouristProfileScreenState();
}

class _TouristProfileScreenState extends State<TouristProfileScreen> {
  final _nameController = TextEditingController(text: 'Amani Hassan');
  final _emailController = TextEditingController(text: 'amani.hassan@example.com');
  String _ageRange = '25-34';
  bool _adventure = true;
  bool _relaxation = false;
  bool _cultural = true;
  final String _referralCode = 'SIWA-EXPLORER-24';
  bool _gpsConsent = false;

  final List<Map<String, dynamic>> _badges = [
    {
      'name': 'Desert Explorer',
      'imageUrl': 'https://www.kemetexperience.com/wp-content/uploads/2019/09/incredible-white-desert-960x636.jpg',
    },
    {
      'name': 'Oasis Adventurer',
      'imageUrl': 'https://thedaydreamdrifters.com/wp-content/uploads/2018/09/Siwa-Oasis-.jpg',
    },
    {
      'name': 'Siwa Connoisseur',
      'imageUrl': 'https://visitegypt.com/wp-content/uploads/2025/07/the-salt-lake-siwa-oasis.webp',
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tourist_home'),
        ),
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('https://www.adrereamellal.com/adrere/wp-content/uploads/2019/09/Adrere-amellal-siwa-oasis-eco-lodge-Omar-Hikal.jpg'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryOrange,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: () {
                            // Handle photo upload
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Amani Hassan',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const Center(
                child: Text(
                  'Tourist',
                  style: TextStyle(fontSize: 16, color: AppTheme.gray),
                ),
              ),
              const Center(
                child: Text(
                  'Joined 2022',
                  style: TextStyle(fontSize: 14, color: AppTheme.secondaryGray),
                ),
              ),
              const SizedBox(height: 32),
              const Text('Personal Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _ageRange,
                decoration: InputDecoration(
                  labelText: 'Age Range',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: const [
                  DropdownMenuItem(value: '18-24', child: Text('18-24')),
                  DropdownMenuItem(value: '25-34', child: Text('25-34')),
                  DropdownMenuItem(value: '35-44', child: Text('35-44')),
                  DropdownMenuItem(value: '45+', child: Text('45+')),
                ],
                onChanged: (value) => setState(() => _ageRange = value!),
              ),
              const SizedBox(height: 32),
              const Text('Preferences', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Adventure'),
                value: _adventure,
                onChanged: (val) => setState(() => _adventure = val!),
                activeColor: AppTheme.primaryOrange,
              ),
              CheckboxListTile(
                title: const Text('Relaxation'),
                value: _relaxation,
                onChanged: (val) => setState(() => _relaxation = val!),
                activeColor: AppTheme.primaryOrange,
              ),
              CheckboxListTile(
                title: const Text('Cultural Immersion'),
                value: _cultural,
                onChanged: (val) => setState(() => _cultural = val!),
                activeColor: AppTheme.primaryOrange,
              ),
              const SizedBox(height: 32),
              const Text('Referral Code', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: TextEditingController(text: _referralCode),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _referralCode));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Copy'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text('GPS Consent', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Enable GPS'),
                subtitle: const Text('Allow location access for personalized recommendations.'),
                value: _gpsConsent,
                onChanged: (val) => setState(() => _gpsConsent = val),
                activeThumbColor: AppTheme.primaryOrange,
              ),
              const SizedBox(height: 32),
              const Text('Badges', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _badges.length,
                  itemBuilder: (context, index) {
                    final badge = _badges[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(badge['imageUrl']),
                          ),
                          const SizedBox(height: 8),
                          Text(badge['name'], style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
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
          if (index == 1) context.go('/tourist_search');
          if (index == 2) context.go('/tourist_bookings');
        },
      ),
    );
  }
}