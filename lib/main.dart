import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:siwa/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // Enable logging to debug translation issues
  EasyLocalization.logger.enableBuildModes = [];

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        // CRITICAL: This path must match the assets folder structure
        path: 'assets/translations',  // Changed from 'translations' to 'assets/translations'
        fallbackLocale: const Locale('en'),
        saveLocale: true,
        startLocale: const Locale('en'),
        // Add this to help with debugging
        useFallbackTranslations: true,
        child: const SiwaAppWrapper(),
      ),
    ),
  );
}

/// Wrapper to sync EasyLocalization with Riverpod on startup
class SiwaAppWrapper extends ConsumerStatefulWidget {
  const SiwaAppWrapper({super.key});

  @override
  ConsumerState<SiwaAppWrapper> createState() => _SiwaAppWrapperState();
}

class _SiwaAppWrapperState extends ConsumerState<SiwaAppWrapper> {
  @override
  void initState() {
    super.initState();
    // Sync initial locale with Riverpod
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentLocale = context.locale;
      ref.read(currentLocaleProvider.notifier).state = currentLocale;
      
      // Debug: Print current locale
      debugPrint('📍 Current locale: ${currentLocale.languageCode}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch for locale changes in Riverpod
    ref.listen<Locale>(currentLocaleProvider, (previous, next) {
      // This ensures widgets rebuild when locale changes
      if (previous != next && mounted) {
        debugPrint('🔄 Locale changed from ${previous?.languageCode} to ${next.languageCode}');
        setState(() {});
      }
    });

    return const SiwaApp();
  }
}