import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:locate_me/core/common_features/database/local/service/app_settings/app_settings_service.dart';

import '../../db/db.dart';

class AppSettingsServiceImpl implements IAppSettingsService {
  final DB _database;

  AppSettingsServiceImpl(this._database);

  @override
  Future<int> getThemeMode() async {
    final query = _database.select(_database.appSettingsTB);
    final result = await query.getSingleOrNull();

    return result?.themeMode ?? 2; // Default to Auto
  }

  @override
  Future<void> setThemeMode(int mode) async {
    _database
        .into(_database.appSettingsTB)
        .insertOnConflictUpdate(AppSettingsTBCompanion(
          id: const Value(0),
          themeMode: Value(mode),
        ));
  }

  @override
  Future<String> getLanguage() async {
    final query = _database.select(_database.appSettingsTB);
    final result = await query.getSingleOrNull();
    return result?.language ?? 'fa';
  }

  @override
  Future<void> setLanguage(String language) async {
    await _database.into(_database.appSettingsTB).insertOnConflictUpdate(
        AppSettingsTBCompanion(id: const Value(0), language: Value(language)));
  }

  @override
  Stream<String?> watchLanguage() {
    return _database
        .select(_database.appSettingsTB)
        .watchSingle()
        .map((row) => row.language);
  }

  @override
  Future<void> addCategory(String name, String emoji, int color) async {
    await _database.into(_database.categoriesTB).insert(CategoriesTBCompanion(
        name: Value(name), emoji: Value(emoji), color: Value(color)));
  }

  @override
  Future<void> deleteCategory(int id) async {
    await (_database.delete(_database.categoriesTB)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<List<Categories>> getAllCategories() async {
    return await _database.select(_database.categoriesTB).get();
  }

  @override
  Stream<List<Categories>> watchCategories() {
    try {
      return _database
          .select(_database.categoriesTB)
          .watch()
          .asBroadcastStream();
    } catch (e) {
      log("::: $e");
      rethrow;
    }
  }

  @override
  Future<void> toggleAutoLogin() async {
    try {
      // Fetch the current autoLogin value
      final currentSetting = await (_database.select(_database.appSettingsTB)
            ..where((tbl) => tbl.id.equals(0)))
          .getSingleOrNull();

      // If the setting exists, toggle the autoLogin value and update
      bool updatedAutoLogin =
          currentSetting != null ? !(currentSetting.autoLogin) : true;

      await _database.into(_database.appSettingsTB).insertOnConflictUpdate(
          AppSettingsTBCompanion(
              autoLogin: Value(updatedAutoLogin), id: const Value(0)));
    } catch (e) {
      log("ERR : $e");
    }
  }

  @override
  Future<bool> getAutoLoginStatus() async {
    final result =
        await (_database.select(_database.appSettingsTB)..limit(0)).getSingle();
    return result.autoLogin;
  }

  @override
  Stream<bool> watchAutoLoginState() {
    return _database
        .select(_database.appSettingsTB)
        .watchSingle()
        .map((data) => data.autoLogin);
  }

  @override
  Future<bool> getAutoLoginState() async {
    // Fetch the current autoLogin value
    final currentSetting = await (_database.select(_database.appSettingsTB)
          ..where((tbl) => tbl.id.equals(0)))
        .getSingleOrNull();

    return currentSetting?.autoLogin ?? false;
  }
}
