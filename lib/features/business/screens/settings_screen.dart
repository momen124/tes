import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/features/business/providers/business_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final business = ref.watch(businessProvider);
    final businessNotifier = ref.read(businessProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Language (English/Arabic)'),
            value: business.language == 'en',
            onChanged: (val) => businessNotifier.setLanguage(val ? 'en' : 'ar'),
          ),
          SwitchListTile(
            title: const Text('Enable GPS'),
            value: business.gpsEnabled,
            onChanged: (val) => businessNotifier.toggleGps(val),
          ),
          ListTile(
            title: const Text('Logout'),
            trailing: const Icon(Icons.logout),
            onTap: () {
              businessNotifier.logout();
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}