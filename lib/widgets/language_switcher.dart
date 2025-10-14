import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// Language Switcher Widget
/// Can be used as a button, toggle, or dropdown
class LanguageSwitcher extends StatelessWidget {
  final LanguageSwitcherStyle style;

  const LanguageSwitcher({Key? key, this.style = LanguageSwitcherStyle.toggle})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  toggle, // Toggle switch style
  button, // Button style
  dropdown, // Dropdown menu
  fab, // Floating action button
  iconButton, // Icon button in AppBar
}

/// Toggle Switch Style (Recommended for Settings)
class _ToggleLanguageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
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
          SizedBox(width: 12),
          Switch(
            value: isArabic,
            onChanged: (value) {
              _changeLanguage(context, value ? 'ar' : 'en');
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 12),
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
class _ButtonLanguageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return ElevatedButton.icon(
      onPressed: () {
        _changeLanguage(context, isArabic ? 'en' : 'ar');
      },
      icon: Icon(Icons.language),
      label: Text(isArabic ? 'English' : 'العربية'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

/// Dropdown Menu Style (Compact, good for AppBar)
class _DropdownLanguageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.language),
      tooltip: 'tour_guides.language'.tr(),
      onSelected: (languageCode) {
        _changeLanguage(context, languageCode);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'en',
          child: Row(
            children: [
              Text('🇬🇧', style: TextStyle(fontSize: 24)),
              SizedBox(width: 12),
              Text('English'),
              if (context.locale.languageCode == 'en') ...[
                Spacer(),
                Icon(Icons.check, color: Colors.green, size: 20),
              ],
            ],
          ),
        ),
        PopupMenuItem(
          value: 'ar',
          child: Row(
            children: [
              Text('🇪🇬', style: TextStyle(fontSize: 24)),
              SizedBox(width: 12),
              Text('العربية'),
              if (context.locale.languageCode == 'ar') ...[
                Spacer(),
                Icon(Icons.check, color: Colors.green, size: 20),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// FAB Style (Floating Action Button)
class _FabLanguageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return FloatingActionButton.extended(
      onPressed: () {
        _changeLanguage(context, isArabic ? 'en' : 'ar');
      },
      icon: Icon(Icons.language),
      label: Text(isArabic ? 'EN' : 'ع'),
      tooltip: isArabic ? 'Switch to English' : 'التبديل للعربية',
    );
  }
}

/// Icon Button Style (Minimal, good for AppBar)
class _IconButtonLanguageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return IconButton(
      icon: Container(
        padding: EdgeInsets.all(6),
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
        _changeLanguage(context, isArabic ? 'en' : 'ar');
      },
    );
  }
}

/// Helper function to change language
void _changeLanguage(BuildContext context, String languageCode) async {
  await context.setLocale(Locale(languageCode));

  // Force rebuild of the entire widget tree
  if (context.mounted) {
    // Pop all routes and rebuild
    Navigator.of(context).popUntil((route) => route.isFirst);

    // Optional: Show a snackbar confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          languageCode == 'ar'
              ? 'تم التبديل إلى العربية'
              : 'Switched to English',
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Animated Language Switcher (Fancy version)
class AnimatedLanguageSwitcher extends StatefulWidget {
  const AnimatedLanguageSwitcher({Key? key}) : super(key: key);

  @override
  State<AnimatedLanguageSwitcher> createState() =>
      _AnimatedLanguageSwitcherState();
}

class _AnimatedLanguageSwitcherState extends State<AnimatedLanguageSwitcher> {
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
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            SizedBox(width: 8),
            if (_isExpanded) ...[
              _buildLanguageOption(context, 'en', 'English', '🇬🇧'),
              SizedBox(width: 8),
              Container(
                height: 24,
                width: 1,
                color: Theme.of(
                  context,
                ).colorScheme.onPrimaryContainer.withOpacity(0.3),
              ),
              SizedBox(width: 8),
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

  Widget _buildLanguageOption(
    BuildContext context,
    String code,
    String label,
    String flag,
  ) {
    final isSelected = context.locale.languageCode == code;

    return GestureDetector(
      onTap: () {
        _changeLanguage(context, code);
        setState(() {
          _isExpanded = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 20)),
            SizedBox(width: 6),
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
class LanguageSwitcherListTile extends StatelessWidget {
  const LanguageSwitcherListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.language,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text('tour_guides.language'.tr()),
      subtitle: Text(isArabic ? 'العربية' : 'English'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        _showLanguageDialog(context);
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('tour_guides.language'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(context, 'en', 'English', '🇬🇧'),
            SizedBox(height: 8),
            _buildLanguageOption(context, 'ar', 'العربية', '🇪🇬'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String code,
    String label,
    String flag,
  ) {
    final isSelected = context.locale.languageCode == code;

    return InkWell(
      onTap: () {
        _changeLanguage(context, code);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
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
            Text(flag, style: TextStyle(fontSize: 28)),
            SizedBox(width: 16),
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
