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

/// Toggle Switch Style (Recommended for Settings)
class _ToggleLanguageSwitcher extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = context.locale.languageCode == 'ar';
    
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
              _changeLanguage(context, ref, value ? 'ar' : 'en');
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
    final isArabic = context.locale.languageCode == 'ar';
    
    return ElevatedButton.icon(
      onPressed: () {
        _changeLanguage(context, ref, isArabic ? 'en' : 'ar');
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
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: 'language'.tr(),
      onSelected: (languageCode) {
        _changeLanguage(context, ref, languageCode);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'en',
          child: Row(
            children: [
              const Text('🇬🇧', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              const Text('English'),
              if (context.locale.languageCode == 'en') ...[
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
              if (context.locale.languageCode == 'ar') ...[
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
    final isArabic = context.locale.languageCode == 'ar';
    
    return FloatingActionButton.extended(
      onPressed: () {
        _changeLanguage(context, ref, isArabic ? 'en' : 'ar');
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
    final isArabic = context.locale.languageCode == 'ar';
    
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
        _changeLanguage(context, ref, isArabic ? 'en' : 'ar');
      },
    );
  }
}

/// Helper function to change language with Riverpod integration
void _changeLanguage(BuildContext context, WidgetRef ref, String languageCode) async {
  // Update EasyLocalization locale
  await context.setLocale(Locale(languageCode));
  
  // Update Riverpod locale provider to trigger mock data change
  ref.read(currentLocaleProvider.notifier).state = Locale(languageCode);
  
  // Force rebuild of the entire widget tree
  if (context.mounted) {
    // Optional: Show a snackbar confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          languageCode == 'ar' 
              ? 'تم التبديل إلى العربية' 
              : 'Switched to English',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Animated Language Switcher (Fancy version)
class AnimatedLanguageSwitcher extends ConsumerStatefulWidget {
  const AnimatedLanguageSwitcher({super.key});

  @override
  ConsumerState<AnimatedLanguageSwitcher> createState() => _AnimatedLanguageSwitcherState();
}

class _AnimatedLanguageSwitcherState extends ConsumerState<AnimatedLanguageSwitcher> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.language,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            const SizedBox(width: 8),
            if (_isExpanded) ...[
              _buildLanguageOption(context, 'en', 'English', '🇬🇧'),
              const SizedBox(width: 8),
              Container(
                height: 24,
                width: 1,
                color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
              ),
              const SizedBox(width: 8),
              _buildLanguageOption(context, 'ar', 'العربية', '🇪🇬'),
            ] else ...[
              Text(
                isArabic ? 'العربية' : 'English',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String code, String label, String flag) {
    final isSelected = context.locale.languageCode == code;
    
    return GestureDetector(
      onTap: () {
        _changeLanguage(context, ref, code);
        setState(() {
          _isExpanded = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected 
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// List Tile Style (Perfect for Settings Screen)
class LanguageSwitcherListTile extends ConsumerWidget {
  const LanguageSwitcherListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = context.locale.languageCode == 'ar';
    
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
      title: Text('language'.tr()),
      subtitle: Text(isArabic ? 'العربية' : 'English'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        _showLanguageDialog(context, ref);
      },
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('select_language'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(context, ref, 'en', 'English', '🇬🇧'),
            const SizedBox(height: 8),
            _buildLanguageOption(context, ref, 'ar', 'العربية', '🇪🇬'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, WidgetRef ref, String code, String label, String flag) {
    final isSelected = context.locale.languageCode == code;
    
    return InkWell(
      onTap: () {
        _changeLanguage(context, ref, code);
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