import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:siwa/data/mock_data_repository.dart';
import 'package:siwa/data/mock_data_repository_ar.dart';

// Provider to track current locale
final currentLocaleProvider = StateProvider<Locale>((ref) => const Locale('en'));

// Provider that depends on locale
final mockDataProvider = Provider<MockDataRepository>((ref) {
  final locale = ref.watch(currentLocaleProvider);
  return (locale.languageCode == 'ar' ? mockDataAr : mockData) as MockDataRepository;
});