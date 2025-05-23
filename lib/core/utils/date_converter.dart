import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../features/setting/provider/settings_provider.dart';

class DateConverter {
  // Convert ISO8601 string to Shamsi (Jalali) date string
  static String toShamsi(String iso8601String) {
    DateTime date = DateTime.parse(iso8601String);
    final jalali = Jalali.fromDateTime(date);
    return '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}';
  }

// Convert ISO8601 string to Gregorian date string
  static String toGregorian(String iso8601String) {
    DateTime date = DateTime.parse(iso8601String);
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

// Convert ISO8601 string to Gregorian date string
  static String autoConverter(String iso8601String, {WidgetRef? ref}) {
    final readRef = ProviderContainer();
    final language = ref != null
        ? ref.watch(languageNotifierProvider).value
        : readRef.read(languageNotifierProvider).value;
    final languageLocale = language ?? "fa";
    if (languageLocale == 'fa') {
      return toShamsi(iso8601String);
    } else {
      return toGregorian(iso8601String);
    }
  }
}
