import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/setting/provider/app_settings_repository_provider.dart';

import '../../../core/enums/enums.dart';

class ThemeNotifier extends AsyncNotifier<AppThemeMode> {
  @override
  Future<AppThemeMode> build() async => await loadTheme();

  Future<AppThemeMode> loadTheme() async {
    final repo = ref.read(appSettingsRepositoryProvider);
    final themeModeIndex = await repo.getThemeMode();
    state = AsyncData(AppThemeMode.values[themeModeIndex]);
    return AppThemeMode.values[themeModeIndex];
  }

  void setTheme(AppThemeMode themeMode) async {
    final repo = ref.read(appSettingsRepositoryProvider);
    await repo.setThemeMode(themeMode.index);
    state = AsyncData(themeMode);
  }
}
