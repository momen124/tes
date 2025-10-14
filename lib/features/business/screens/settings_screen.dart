// lib/features/business/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/business/providers/business_provider.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final business = ref.watch(businessProvider);
    final businessNotifier = ref.read(businessProvider.notifier);
    final isOffline = ref.watch(offlineProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Settings'.tr())),
      body: ListView(
        children: [
          if (isOffline)
            Container(
              decoration: AppTheme.offlineBanner,
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'You are offline',
                style: TextStyle(color: Colors.white),
              ),
            ),
          SwitchListTile(
            title: Text('Language (English/Arabic)'.tr()),
            value: business.language == 'en',
            onChanged: isOffline ? null : (val) => businessNotifier.setLanguage(val ? 'en' : 'ar'),
          ),
          SwitchListTile(
            title: Text('Enable GPS'.tr()),
            value: business.gpsEnabled,
            onChanged: isOffline ? null : (val) => businessNotifier.toggleGps(val),
          ),
          ListTile(
            title: Text('Logout'.tr()),
            trailing: const Icon(Icons.logout),
            onTap: isOffline
                ? null
                : () {
                    businessNotifier.logout();
                    context.go('/login');
                  },
          ),
        ],
      ),
 
    );
  }
}