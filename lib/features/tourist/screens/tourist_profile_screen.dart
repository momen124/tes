import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/widgets/tourist_bottom_nav.dart';
import 'package:siwa/widgets/language_switcher.dart';
import 'package:easy_localization/easy_localization.dart';

class TouristProfileScreen extends StatefulWidget {
  const TouristProfileScreen({super.key});

  @override
  State<TouristProfileScreen> createState() => _TouristProfileScreenState();
}

class _TouristProfileScreenState extends State<TouristProfileScreen> {
  final _nameController = TextEditingController(text: 'tourist.profile.default_name'.tr());
  final _emailController = TextEditingController(text: 'amani.hassan@example.com');
  String _ageRange = '25-34';
  bool _adventure = true;
  bool _relaxation = false;
  bool _cultural = true;
  final String _referralCode = 'SIWA-EXPLORER-24';
  bool _gpsConsent = false;

  final List<Map<String, dynamic>> _badges = [
    {
      'name': 'tourist.challenges.hidden_oasis'.tr(),
      'imageUrl': 'https://www.kemetexperience.com/wp-content/uploads/2019/09/incredible-white-desert-960x636.jpg',
    },
    {
      'name': 'tourist.challenges.capture_sunset'.tr(),
      'imageUrl': 'https://thedaydreamdrifters.com/wp-content/uploads/2018/09/Siwa-Oasis-.jpg',
    },
    {
      'name': 'tourist.challenges.salt_lake'.tr(),
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
        title: Text('tourist.profile.title'.tr()),
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
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=400&h=300&fit=crop'),
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
              Center(
                child: Text(
                  _nameController.text,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  'tourist.profile.user_type_tourist'.tr(),
                  style: const TextStyle(fontSize: 16, color: AppTheme.gray),
                ),
              ),
              Center(
                child: Text(
                  'tourist.profile.joined_year'.tr(namedArgs: {'year': '2022'}),
                  style: const TextStyle(fontSize: 14, color: AppTheme.secondaryGray),
                ),
              ),
              const SizedBox(height: 32),
              Text('tourist.profile.personal_info'.tr(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'tourist.profile.name'.tr(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'auth.email'.tr(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _ageRange,
                decoration: InputDecoration(
                  labelText: 'tourist.profile.age_range'.tr(),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: [
                  DropdownMenuItem(value: '18-24', child: Text('tourist.profile.age_ranges.18_24'.tr())),
                  DropdownMenuItem(value: '25-34', child: Text('tourist.profile.age_ranges.25_34'.tr())),
                  DropdownMenuItem(value: '35-44', child: Text('tourist.profile.age_ranges.35_44'.tr())),
                  DropdownMenuItem(value: '45+', child: Text('tourist.profile.age_ranges.45_plus'.tr())),
                ],
                onChanged: (value) => setState(() => _ageRange = value!),
              ),
              const SizedBox(height: 32),
              Text('tourist.profile.preferences'.tr(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: Text('tourist.profile.adventure'.tr()),
                value: _adventure,
                onChanged: (val) => setState(() => _adventure = val!),
                activeColor: AppTheme.primaryOrange,
              ),
              CheckboxListTile(
                title: Text('tourist.profile.relaxation'.tr()),
                value: _relaxation,
                onChanged: (val) => setState(() => _relaxation = val!),
                activeColor: AppTheme.primaryOrange,
              ),
              CheckboxListTile(
                title: Text('tourist.profile.cultural_immersion'.tr()),
                value: _cultural,
                onChanged: (val) => setState(() => _cultural = val!),
                activeColor: AppTheme.primaryOrange,
              ),
              const SizedBox(height: 32),
              Text('tourist.profile.referral_code'.tr(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('tourist.profile.copied'.tr())));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('tourist.profile.copy'.tr()),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text('tourist.profile.gps_consent'.tr(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text('auth.enable_gps'.tr()),
                subtitle: Text('tourist.profile.allow_location'.tr()),
                value: _gpsConsent,
                onChanged: (val) => setState(() => _gpsConsent = val),
                activeThumbColor: AppTheme.primaryOrange,
              ),
              const SizedBox(height: 32),
              Text('tourist.profile.badges'.tr(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                          Text(
                            badge['name'],
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              Text('common.language'.tr(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Center(
                child: LanguageSwitcher(
                  style: LanguageSwitcherStyle.button,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const TouristBottomNav(currentIndex: 4),
    );
  }
}