import 'package:locate_me/features/setting/model/category_model.dart';

import '../../../../../../features/home/model/place_item_model.dart';

abstract class IAppSettingsRepository {
  Future<int> getThemeMode();

  Future<void> setThemeMode(int mode);

  Stream<String?> watchLanguage();

  Future<String> getLanguage();

  Future<void> setLanguage(String language);

  Future<List<PlaceItemModel>> getLocations();
  Future<void> replaceOrUpdateData(List<PlaceItemModel> data);
  Future<void> addCategory(String name, String emoji, int color);
  Future<void> deleteCategory(int id);
  Future<List<CategoryModel>> getAllCategories();
  Stream<List<CategoryModel>> watchCategories();
  Future<void> toggleAutoLogin();
  Stream<bool> watchAutoLoginState();
  Future<bool> getAutoLoginState();
}
