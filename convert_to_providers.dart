#!/usr/bin/env dart
// convert_to_providers.dart
// Converts widgets to Consumer widgets and updates mockData usage

import 'dart:io';

void main() {
  print('🔧 Converting to Provider-Based Architecture...\n');
  
  final converter = ProviderConverter();
  converter.run();
}

class ProviderConverter {
  final List<String> filesToConvert = [
    'lib/features/tourist/screens/attractions_list_screen.dart',
    'lib/features/tourist/screens/restaurants_list_screen.dart',
    'lib/features/tourist/screens/siwa_info_screen.dart',
    'lib/features/tourist/screens/tourist_challenges_screen.dart',
    'lib/features/tourist/screens/tourist_profile_screen.dart',
    'lib/features/tourist/screens/tour_guides_list_screen.dart',
    'lib/features/tourist/screens/transportation_list_screen.dart',
  ];
  
  int successCount = 0;
  int errorCount = 0;
  final List<String> convertedFiles = [];
  
  void run() {
    print('📋 Converting ${filesToConvert.length} files...\n');
    
    for (final filePath in filesToConvert) {
      try {
        if (_convertFile(filePath)) {
          successCount++;
          convertedFiles.add(filePath);
        }
      } catch (e) {
        print('❌ Error converting $filePath: $e\n');
        errorCount++;
      }
    }
    
    _printReport();
  }
  
  bool _convertFile(String filePath) {
    final file = File(filePath);
    
    if (!file.existsSync()) {
      print('⚠️  File not found: $filePath\n');
      return false;
    }
    
    print('🔄 Converting: ${_getFileName(filePath)}');
    
    String content = file.readAsStringSync();
    final originalContent = content;
    bool modified = false;
    
    // Add imports
    if (!content.contains("import 'package:flutter_riverpod/flutter_riverpod.dart'")) {
      content = _addImport(content, "import 'package:flutter_riverpod/flutter_riverpod.dart';");
      modified = true;
      print('   ✓ Added flutter_riverpod import');
    }
    
    if (!content.contains("import 'package:siwa/providers/mock_data_provider.dart'")) {
      content = _addImport(content, "import 'package:siwa/providers/mock_data_provider.dart';");
      modified = true;
      print('   ✓ Added mock_data_provider import');
    }
    
    // Convert StatefulWidget to ConsumerStatefulWidget
    if (content.contains('extends StatefulWidget')) {
      content = content.replaceAllMapped(
        RegExp(r'class\s+(\w+)\s+extends\s+StatefulWidget'),
        (match) => 'class ${match.group(1)} extends ConsumerStatefulWidget',
      );
      modified = true;
      print('   ✓ Changed to ConsumerStatefulWidget');
    }
    
    // Convert State to ConsumerState
    if (content.contains('extends State<')) {
      content = content.replaceAllMapped(
        RegExp(r'class\s+(\w+)\s+extends\s+State<(\w+)>'),
        (match) => 'class ${match.group(1)} extends ConsumerState<${match.group(2)}>',
      );
      modified = true;
      print('   ✓ Changed State to ConsumerState');
    }
    
    // Update createState return type
    if (content.contains('State<')) {
      content = content.replaceAllMapped(
        RegExp(r'State<(\w+)>\s+createState\(\)'),
        (match) => 'ConsumerState<${match.group(1)}> createState()',
      );
      modified = true;
      print('   ✓ Updated createState return type');
    }
    
    // Replace mockData.getAllX() with ref.watch(mockDataProvider).getAllX()
    final mockDataMethodPattern = RegExp(
      r'mockData\.(getAll\w+|search\w+|getBookingsByUserId)\(\)',
      multiLine: true,
    );
    
    if (mockDataMethodPattern.hasMatch(content)) {
      final matchCount = mockDataMethodPattern.allMatches(content).length;
      content = content.replaceAllMapped(
        mockDataMethodPattern,
        (match) => 'ref.watch(mockDataProvider).${match.group(1)}()',
      );
      modified = true;
      print('   ✓ Replaced $matchCount mockData method calls');
    }
    
    // Replace direct list access (mockData.restaurants, etc.)
    final mockDataListPattern = RegExp(
      r'mockData\.(restaurants|guides|transportation|attractions|products|bookings|hotels|reviews|badges|other)\b',
      multiLine: true,
    );
    
    if (mockDataListPattern.hasMatch(content)) {
      final matchCount = mockDataListPattern.allMatches(content).length;
      content = content.replaceAllMapped(
        mockDataListPattern,
        (match) {
          final listName = match.group(1)!;
          final methodName = _listToMethodName(listName);
          return 'ref.watch(mockDataProvider).$methodName()';
        },
      );
      modified = true;
      print('   ✓ Replaced $matchCount direct list access');
    }
    
    // Remove old imports
    if (content.contains("import 'package:siwa/data/mock_data_repository.dart'")) {
      content = content.replaceAll(
        RegExp(r"import 'package:siwa/data/mock_data_repository\.dart';\n?"),
        '',
      );
      modified = true;
      print('   ✓ Removed old mock_data_repository import');
    }
    
    if (content.contains("import 'package:siwa/data/mock_data_repository_ar.dart'")) {
      content = content.replaceAll(
        RegExp(r"import 'package:siwa/data/mock_data_repository_ar\.dart';\n?"),
        '',
      );
      modified = true;
      print('   ✓ Removed old mock_data_repository_ar import');
    }
    
    // Write changes
    if (modified && content != originalContent) {
      file.writeAsStringSync(content);
      print('   ✅ Successfully converted!\n');
      return true;
    } else if (!modified) {
      print('   ⚠️  No changes needed\n');
      return false;
    }
    
    return false;
  }
  
  String _getFileName(String path) {
    return path.split('/').last.split('\\').last;
  }
  
  String _addImport(String content, String importStatement) {
    final importPattern = RegExp(r"^import .*?;\s*$", multiLine: true);
    final matches = importPattern.allMatches(content);
    
    if (matches.isEmpty) {
      return "$importStatement\n\n$content";
    }
    
    final lastImport = matches.last;
    final insertPosition = lastImport.end;
    
    return "${content.substring(0, insertPosition)}\n$importStatement${content.substring(insertPosition)}";
  }
  
  String _listToMethodName(String listName) {
    final map = {
      'restaurants': 'getAllRestaurants',
      'guides': 'getAllTourGuides',
      'transportation': 'getAllTransportation',
      'attractions': 'getAllAttractions',
      'products': 'getAllProducts',
      'bookings': 'getAllBookings',
      'hotels': 'getAllHotels',
      'reviews': 'getAllReviews',
      'badges': 'getAllBadges',
      'other': 'getAllOther',
    };
    return map[listName] ?? 'getAll${_capitalize(listName)}';
  }
  
  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
  
  void _printReport() {
    print('═' * 70);
    print('📊 CONVERSION REPORT');
    print('═' * 70);
    print('✅ Successfully converted: $successCount files');
    print('❌ Errors: $errorCount files');
    print('═' * 70);
    
    if (convertedFiles.isNotEmpty) {
      print('\n✅ Converted files:');
      for (final file in convertedFiles) {
        print('   • ${_getFileName(file)}');
      }
    }
    
    print('\n');
    
    if (successCount > 0) {
      print('🎉 Migration Complete!\n');
      print('📝 Next steps:');
      print('   1. Run: dart verify_migration.dart');
      print('   2. Run: flutter analyze');
      print('   3. Run: flutter run');
      print('   4. Test all features\n');
      print('💡 Tip: Test language switching (EN ↔ AR) and offline mode');
    }
    
    if (errorCount > 0) {
      print('⚠️  Some files had errors. Please check output above.');
    }
    
    print('\n${'═' * 70}');
  }
}