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
      path: 'lib/assets/translations',  // Remove trailing slash
      fallbackLocale: const Locale('en'),
      saveLocale: true, // Persist language choice
      startLocale: const Locale('en'), // Default start locale
      child: const ProviderScope(child: SiwaApp()),
    ),
  );
}