import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:siwa/providers/mock_data_provider.dart';

/// Language Switcher Widget
/// Can be used as a button, toggle, or dropdown
class LanguageSwitcher extends ConsumerWidget {
  final LanguageSwitcherStyle style;
  
  const LanguageSwitcher({
    super.key,
    this.style = LanguageSwitcherStyle.toggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (style) {
      case LanguageSwitcherStyle.toggle:
        return _ToggleLanguageSwitcher();
      case LanguageSwitcherStyle.button:
        return _ButtonLanguageSwitcher();
      case LanguageSwitcherStyle.dropdown:
        return _DropdownLanguageSwitcher();
      case LanguageSwitcherStyle.fab:
        return _FabLanguageSwitcher();
      case LanguageSwitcherStyle.iconButton:
        return _IconButtonLanguageSwitcher();
    }
  }
}

enum LanguageSwitcherStyle {
  toggle,    // Toggle switch style
  button,    // Button style
  dropdown,  // Dropdown menu
  fab,       // Floating action button
  iconButton // Icon button in AppBar
}

/// Helper function to change language with Riverpod integration
Future<void> changeLanguage(BuildContext context, WidgetRef ref, String languageCode) async {
  try {
    // 1. Update Riverpod locale provider FIRST
    ref.read(currentLocaleProvider.notifier).state = Locale(languageCode);
    
    // 2. Update EasyLocalization locale
    await context.setLocale(Locale(languageCode));
    
    // 3. Force rebuild by invalidating providers (optional but recommended)
    ref.invalidate(mockDataProvider);
    
    // 4. Show confirmation
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            languageCode == 'ar' 
                ? 'تم التبديل إلى العربية' 
                : 'Switched to English',
          ),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  } catch (e) {
    debugPrint('Error changing language: $e');
  }
}

/// Toggle Switch Style (Recommended for Settings)
class _ToggleLanguageSwitcher extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch both EasyLocalization and Riverpod locale
    final currentLocale = ref.watch(currentLocaleProvider);
    final isArabic = currentLocale.languageCode == 'ar';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'English',
            style: TextStyle(
              fontWeight: !isArabic ? FontWeight.bold : FontWeight.normal,
              color: !isArabic 
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: isArabic,
            onChanged: (value) {
              changeLanguage(context, ref, value ? 'ar' : 'en');
            },
            activeThumbColor: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Text(
            'العربية',
            style: TextStyle(
              fontWeight: isArabic ? FontWeight.bold : FontWeight.normal,
              color: isArabic 
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

/// Button Style (Good for prominent placement)
class _ButtonLanguageSwitcher extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);
    final isArabic = currentLocale.languageCode == 'ar';
    
    return ElevatedButton.icon(
      onPressed: () {
        changeLanguage(context, ref, isArabic ? 'en' : 'ar');
      },
      icon: const Icon(Icons.language),
      label: Text(isArabic ? 'English' : 'العربية'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

/// Dropdown Menu Style (Compact, good for AppBar)
class _DropdownLanguageSwitcher extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);
    
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: 'Language',
      onSelected: (languageCode) {
        changeLanguage(context, ref, languageCode);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'en',
          child: Row(
            children: [
              const Text('🇬🇧', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              const Text('English'),
              if (currentLocale.languageCode == 'en') ...[
                const Spacer(),
                const Icon(Icons.check, color: Colors.green, size: 20),
              ],
            ],
          ),
        ),
        PopupMenuItem(
          value: 'ar',
          child: Row(
            children: [
              const Text('🇪🇬', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              const Text('العربية'),
              if (currentLocale.languageCode == 'ar') ...[
                const Spacer(),
                const Icon(Icons.check, color: Colors.green, size: 20),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// FAB Style (Floating Action Button)
class _FabLanguageSwitcher extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);
    final isArabic = currentLocale.languageCode == 'ar';
    
    return FloatingActionButton.extended(
      onPressed: () {
        changeLanguage(context, ref, isArabic ? 'en' : 'ar');
      },
      icon: const Icon(Icons.language),
      label: Text(isArabic ? 'EN' : 'ع'),
      tooltip: isArabic ? 'Switch to English' : 'التبديل للعربية',
    );
  }
}

/// Icon Button Style (Minimal, good for AppBar)
class _IconButtonLanguageSwitcher extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);
    final isArabic = currentLocale.languageCode == 'ar';
    
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          isArabic ? 'EN' : 'ع',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      tooltip: isArabic ? 'Switch to English' : 'التبديل للعربية',
      onPressed: () {
        changeLanguage(context, ref, isArabic ? 'en' : 'ar');
      },
    );
  }
}

/// List Tile Style (Perfect for Settings Screen)
class LanguageSwitcherListTile extends ConsumerWidget {
  const LanguageSwitcherListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleProvider);
    final isArabic = currentLocale.languageCode == 'ar';
    
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.language,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      title: const Text('Language'),
      subtitle: Text(isArabic ? 'العربية' : 'English'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        _showLanguageDialog(context, ref);
      },
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.read(currentLocaleProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(context, ref, 'en', 'English', '🇬🇧', currentLocale),
            const SizedBox(height: 8),
            _buildLanguageOption(context, ref, 'ar', 'العربية', '🇪🇬', currentLocale),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, 
    WidgetRef ref, 
    String code, 
    String label, 
    String flag,
    Locale currentLocale,
  ) {
    final isSelected = currentLocale.languageCode == code;
    
    return InkWell(
      onTap: () {
        changeLanguage(context, ref, code);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}