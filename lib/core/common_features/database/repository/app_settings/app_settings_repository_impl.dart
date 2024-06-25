import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/database/service/app_settings/app_settings_service_impl.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';

import '../../provider/db_provider.dart';
import 'app_settings_repository.dart';

class AppSettingsRepositoryImpl extends IAppSettingsRepository {
  final AppSettingsServiceImpl _appSettingsServiceImpl;

  AppSettingsRepositoryImpl(this._appSettingsServiceImpl);

  @override
  Future<int> getThemeMode() async {
    try {
      return await _appSettingsServiceImpl.getThemeMode();
    } catch (e) {
      log('ERROR getThemeMode : $e');
      rethrow;
    }
  }

  @override
  Future<void> setThemeMode(int mode) async {
    try {
      await _appSettingsServiceImpl.setThemeMode(mode);
    } catch (e) {
      log('ERROR: $e');
      rethrow;
    }
  }

  @override
  Future<String> getLanguage() async {
    try {
      return await _appSettingsServiceImpl.getLanguage();
    } catch (e) {
      log('ERROR getLanguage : $e');

      rethrow;
    }
  }

  @override
  Future<void> setLanguage(String language) async {
    try {
      await _appSettingsServiceImpl.setLanguage(language);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<String?> watchLanguage() {
    try {
      return _appSettingsServiceImpl.watchLanguage();
    } catch (e) {
      log('ERROR watchLanguage : $e');

      rethrow;
    }
  }

  @override
  Future<List<PlaceItemModel>> getLocations() async {
    final riverpod = ProviderContainer();
    final repo = riverpod.read(locationDBRepositoryProvider);
    return await repo.getLocations();
  }

  @override
  Future<void> replaceOrUpdateData(List<PlaceItemModel> data) async {
    final riverpod = ProviderContainer();
    final repo = riverpod.read(locationDBRepositoryProvider);
    await repo.importLocations(data);
  }
}
