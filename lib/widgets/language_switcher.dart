import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:siwa/providers/localization_provider.dart';
import 'package:siwa/app/theme.dart';

class LanguageSwitcher extends ConsumerWidget {
  final bool showText;
  
  const LanguageSwitcher({super.key, this.showText = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localizationProvider);
    final isArabic = locale.languageCode == 'ar';
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ref.read(localizationProvider.notifier).toggleLanguage();
          if (isArabic) {
            context.setLocale(const Locale('en'));
          } else {
            context.setLocale(const Locale('ar'));
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primaryOrange),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.language,
                size: 20,
                color: AppTheme.primaryOrange,
              ),
              if (showText) ...[
                const SizedBox(width: 8),
                Text(
                  isArabic ? 'EN' : 'عربي',
                  style: const TextStyle(
                    color: AppTheme.primaryOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}