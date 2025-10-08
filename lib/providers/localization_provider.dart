import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localizationProvider = StateNotifierProvider<LocalizationNotifier, Locale>((ref) {
  return LocalizationNotifier();
});

class LocalizationNotifier extends StateNotifier<Locale> {
  LocalizationNotifier() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  static const String _localeKey = 'app_locale';

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_localeKey) ?? 'en';
    state = Locale(languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  void toggleLanguage() {
    if (state.languageCode == 'en') {
      setLocale(const Locale('ar'));
    } else {
      setLocale(const Locale('en'));
    }
  }

  bool get isArabic => state.languageCode == 'ar';
}