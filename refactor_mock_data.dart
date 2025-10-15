import 'dart:io';
import 'package:path/path.dart' as path;

void main() {
  // Define the project directory (adjust as needed)
  final projectDir = Directory.current.path;
  final libDir = Directory(path.join(projectDir, 'lib'));

  if (!libDir.existsSync()) {
    print('Error: lib directory not found at $libDir');
    return;
  }

  // Track changes and errors
  int filesModified = 0;
  int errors = 0;

  // Recursively process all .dart files in lib/
  void processDirectory(Directory dir) {
    for (var entity in dir.listSync(recursive: true, followLinks: false)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        try {
          String content = entity.readAsStringSync();
          bool modified = false;

          // Check if file imports mock_data_repository.dart
          if (content.contains("import 'package:siwa/data/mock_data_repository.dart';")) {
            // Replace import
            content = content.replaceAll(
              "import 'package:siwa/data/mock_data_repository.dart';",
              "import 'package:siwa/providers/mock_data_provider.dart';",
            );
            modified = true;

            // Check for mockData usage within ConsumerWidget or ConsumerState
            if (content.contains('ConsumerWidget') || content.contains('ConsumerState')) {
              content = content.replaceAllMapped(
                RegExp(r'(mockData\.(getAll[A-Za-z]+)\(\))'),
                (match) => 'ref.watch(mockDataProvider).${match.group(2)}()',
              );
              modified = true;

              // Handle standalone mockData assignments if any
              content = content.replaceAllMapped(
                RegExp(r'(final\s+mockData\s*=\s*mockData;)'),
                (match) => 'final mockData = ref.watch(mockDataProvider);',
              );
              modified = true;
            }

            if (modified) {
              entity.writeAsStringSync(content);
              filesModified++;
              print('Modified: ${entity.path}');
            }
          }
        } catch (e) {
          errors++;
          print('Error processing ${entity.path}: $e');
        }
      }
    }
  }

  // Process the lib directory
  processDirectory(libDir);

  // Summary
  print('\nRefactoring Summary:');
  print('Files modified: $filesModified');
  print('Errors encountered: $errors');
  if (errors > 0) {
    print('Please review error logs and fix manually if needed.');
  } else {
    print('Refactoring completed successfully!');
  }
}