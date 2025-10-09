import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class CurrencyFormatter {
  static String format(double amount, BuildContext context) {
    final locale = context.locale.languageCode;
    
    if (locale == 'ar') {
      // Arabic currency format (Egyptian Pound)
      final formatter = NumberFormat.currency(
        locale: 'ar_EG',
        symbol: 'ج.م',
        decimalDigits: 0,
      );
      return formatter.format(amount);
    } else {
      // English currency format (USD)
      final formatter = NumberFormat.currency(
        locale: 'en_US',
        symbol: '',
        decimalDigits: 0,
      );
      return formatter.format(amount);
    }
  }
  
  static String formatWithLabel(double amount, String period, BuildContext context) {
    final formattedAmount = format(amount, context);
    final periodLabel = 'common.$period'.tr();
    
    if (context.locale.languageCode == 'ar') {
      return '$formattedAmount $periodLabel';
    } else {
      return '$formattedAmount $periodLabel';
    }
  }
}