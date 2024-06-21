import 'package:drift/drift.dart';
import 'package:locate_me/core/common_features/database/service/app_settings/app_settings_service.dart';

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
}
