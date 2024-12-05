import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/database/local/service/app_settings/app_settings_service_impl.dart';
import 'package:locate_me/features/home/model/place_item_model.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

import '../../provider/db_provider.dart';
import '../../type_converter/category_converter.dart';
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

  @override
  Future<void> addCategory(String name, String emoji, int color) async {
    await _appSettingsServiceImpl.addCategory(name, emoji, color);
  }

  @override
  Future<void> deleteCategory(int id) async {
    await _appSettingsServiceImpl.deleteCategory(id);
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final data = await _appSettingsServiceImpl.getAllCategories();
      final toModel = data
          .map(
            (e) => const DBCategoryConverter().fromSql(e),
          )
          .toList();
      return toModel;
    } catch (e, stackTrace) {
      // Handle or log the error
      print(stackTrace);
      return [];
    }
  }

  @override
  Stream<List<CategoryModel>> watchCategories() {
    final data = _appSettingsServiceImpl.watchCategories();
    return data.map<List<CategoryModel>>((dataList) {
      try {
        return dataList
            .map((data) => const DBCategoryConverter().fromSql(data))
            .toList();
      } catch (e, stackTrace) {
        // Handle or log the error
        print('Error watching locations: $e');
        print(stackTrace);
        return [];
      }
    }).handleError((e, stackTrace) {
      // Handle or log the error in the stream
      print('Error in watchLocations stream: $e');
      print(stackTrace);
      return Exception("Error in watchLocations stream");
    });
  }

  @override
  Future<void> toggleAutoLogin() async {
    await _appSettingsServiceImpl.toggleAutoLogin();
  }

  @override
  Stream<bool> watchAutoLoginState() {
    try {
      return _appSettingsServiceImpl.watchAutoLoginState();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> getAutoLoginState() async {
    return await _appSettingsServiceImpl.getAutoLoginState();
  }
}
