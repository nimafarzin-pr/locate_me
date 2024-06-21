abstract class IAppSettingsService {
  Future<int> getThemeMode();

  Future<void> setThemeMode(int mode);

  Stream<String?> watchLanguage();

  Future<String> getLanguage();

  Future<void> setLanguage(String language);
}
