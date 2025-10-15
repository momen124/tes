import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  final libDir = Directory('lib');
  final dartFiles = libDir.listSync(recursive: true).where((f) => f.path.endsWith('.dart') && !f.path.endsWith('.g.dart'));
  
  // Load JSONs
  final enJson = json.decode(await File('lib/assets/translations/en.json').readAsString()) as Map<String, dynamic>;
  final arJson = json.decode(await File('lib/assets/translations/ar.json').readAsString()) as Map<String, dynamic>;
  final enKeys = enJson.keys.toSet();
  final arKeys = arJson.keys.toSet();

  // Mismatched JSON keys
  final missingInAr = enKeys.difference(arKeys);
  final missingInEn = arKeys.difference(enKeys);
  if (missingInAr.isNotEmpty) print('Missing in ar.json: $missingInAr');
  if (missingInEn.isNotEmpty) print('Missing in en.json: $missingInEn');

  // Extract .tr() keys from code
  final trKeys = <String>{};
  final trRegex = RegExp(r"""['"]([^'"]+)['"]\s*\.tr\(\)""");
  final hardcodedTexts = <String>[]; // Potential leftovers

  for (final fileEntity in dartFiles) {
    final file = File(fileEntity.path);
    final content = await file.readAsString();
    for (final match in trRegex.allMatches(content)) {
      trKeys.add(match.group(1)!);
    }
    // Find potential hardcoded Text (simple heuristic)
    final textRegex = RegExp(r"""Text\s*\(\s*['"]([^'"]+)['"]""");
    for (final match in textRegex.allMatches(content)) {
      final text = match.group(1)!;
      if (!text.contains('{') && text.length > 1 && !trKeys.contains(text)) { // Ignore dynamics/short
        hardcodedTexts.add('${path.basename(file.path)}: "$text"');
      }
    }
  }

  // Code vs JSON check
  final missingInJson = trKeys.difference(enKeys);
  final unusedInJson = enKeys.difference(trKeys);
  if (missingInJson.isNotEmpty) print('Keys in code but missing in JSONs: $missingInJson (add to both en/ar)');
  if (unusedInJson.isNotEmpty) print('Unused JSON keys: $unusedInJson (optional cleanup)');
  if (hardcodedTexts.isNotEmpty) print('Potential hardcoded texts: ${hardcodedTexts.take(50)} (replace with .tr())');

  if (missingInAr.isEmpty && missingInEn.isEmpty && missingInJson.isEmpty && hardcodedTexts.isEmpty) {
    print('Validation passed!');
  } else {
    print('Fix issues, then re-run.');
  }
}