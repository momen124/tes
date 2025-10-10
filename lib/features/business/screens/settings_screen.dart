import 'package:flutter/material.dart';
import '../../providers/business_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final businessProvider = Provider.of<BusinessProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Language (English/Arabic)'),
            value: businessProvider.language == 'en',
            onChanged: (val) => businessProvider.setLanguage(val ? 'en' : 'ar'),
          ),
          SwitchListTile(
            title: const Text('Enable GPS'),
            value: businessProvider.gpsEnabled,
            onChanged: (val) => businessProvider.toggleGps(val),
          ),
          ListTile(
            title: const Text('Logout'),
            trailing: const Icon(Icons.logout),
            onTap: () {
              businessProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}