import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class DateFormatter {
  static String formatDate(DateTime date, BuildContext context) {
    final locale = context.locale.languageCode;
    
    if (locale == 'ar') {
      // Arabic date format
      final formatter = DateFormat('d MMMM yyyy', 'ar');
      return formatter.format(date);
    } else {
      // English date format
      final formatter = DateFormat('MMM d, yyyy', 'en');
      return formatter.format(date);
    }
  }
  
  static String formatBookingDate(DateTime date, BuildContext context) {
    final locale = context.locale.languageCode;
    
    if (locale == 'ar') {
      final formatter = DateFormat('EEEE، d MMMM', 'ar');
      return formatter.format(date);
    } else {
      final formatter = DateFormat('EEEE, MMM d', 'en');
      return formatter.format(date);
    }
  }
  
  static String formatTime(DateTime time, BuildContext context) {
    final locale = context.locale.languageCode;
    
    if (locale == 'ar') {
      final formatter = DateFormat('h:mm a', 'ar');
      return formatter.format(time);
    } else {
      final formatter = DateFormat('h:mm a', 'en');
      return formatter.format(time);
    }
  }
}