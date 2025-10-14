import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:siwa/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // Add this to force locale detection
  EasyLocalization.logger.enableBuildModes = [];

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path:
          'translations', // ✅ CORRECT: Just 'translations' without 'assets/' prefix
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      startLocale: const Locale('en'),
      child: const ProviderScope(child: SiwaApp()),
    ),
  );
}
