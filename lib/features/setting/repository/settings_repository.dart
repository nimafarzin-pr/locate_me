import 'dart:developer';

import 'package:locate_me/core/common_features/database/local/repository/app_settings/app_settings_repository_impl.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

class SettingsRepository {
  final AppSettingsRepositoryImpl _appSettingsRepositoryImpl;
  SettingsRepository(this._appSettingsRepositoryImpl);

  Future<int> getThemeMode() async {
    return await _appSettingsRepositoryImpl.getThemeMode();
  }

  Future<void> setThemeMode(int mode) async {
    _appSettingsRepositoryImpl.setThemeMode(mode);
  }

  Stream<String?> watchLanguage() {
    return _appSettingsRepositoryImpl.watchLanguage();
  }

  Future<String> getLanguage() async {
    return await _appSettingsRepositoryImpl.getLanguage();
  }

  Future<void> setLanguage(String language) async {
    await _appSettingsRepositoryImpl.setLanguage(language);
  }

  Future<List<PlaceItemModel>> getExportedData() async {
    return await _appSettingsRepositoryImpl.getLocations();
  }

  Future<void> importData(List<PlaceItemModel> data) async {
    await _appSettingsRepositoryImpl.replaceOrUpdateData(data);
  }

  Future<void> addCategory(String name, String emoji, int color) async {
    await _appSettingsRepositoryImpl.addCategory(name, emoji, color);
  }

  Future<void> deleteCategory(int id) async {
    await _appSettingsRepositoryImpl.deleteCategory(id);
  }

  Future<List<CategoryModel>> getAllCategories() async {
    return await _appSettingsRepositoryImpl.getAllCategories();
  }

  Stream<List<CategoryModel>> watchCategories() async* {
    try {
      yield* _appSettingsRepositoryImpl.watchCategories();
    } catch (e) {
      log('IN REPO ERR : $e');
      rethrow;
    }
  }
}
