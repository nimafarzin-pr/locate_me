import 'package:locate_me/core/common_features/database/db/db.dart';

abstract class IAppSettingsService {
  Future<int> getThemeMode();

  Future<void> setThemeMode(int mode);

  Stream<String?> watchLanguage();

  Future<String> getLanguage();

  Future<void> setLanguage(String language);
  Future<void> addCategory(String name, String emoji, int color);
  Future<void> deleteCategory(int id);
  Future<List<Categories>> getAllCategories();
  Stream<List<Categories>> watchCategories();
}
