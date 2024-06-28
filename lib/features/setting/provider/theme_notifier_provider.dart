import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/enums/enums.dart';
import '../viewmodel/theme_notifier.dart';

final themeNotifierProvider =
    AsyncNotifierProvider<ThemeNotifier, AppThemeMode>(ThemeNotifier.new);
