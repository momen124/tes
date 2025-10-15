import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:siwa/app/app.dart';
import 'package:siwa/providers/mock_data_provider.dart' as mock;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // Add this to force locale detection
  EasyLocalization.logger.enableBuildModes = [];

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'translations',
        fallbackLocale: const Locale('en'),
        saveLocale: true,
        startLocale: const Locale('en'),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch for locale changes in Riverpod
    ref.listen<Locale>(currentLocaleProvider, (previous, next) {
      // This ensures widgets rebuild when locale changes
      if (previous != next && mounted) {
        setState(() {});
      }
    });

    return const SiwaApp();
  }
}