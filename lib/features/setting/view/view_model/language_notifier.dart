import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/settings_provider.dart';

class LanguageNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    return await loadLanguage();
  }

  Future<String> loadLanguage() async {
    final repo = ref.read(appSettingsRepositoryProvider);
    final language = await repo.getLanguage();
    state = AsyncData(language);
    return language;
  }

  void setLanguage(String language) async {
    final repo = ref.read(appSettingsRepositoryProvider);
    await repo.setLanguage(language);
    state = AsyncData(language);
  }
}
