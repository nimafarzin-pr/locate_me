import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/database/local/db/db.dart';
import 'package:locate_me/core/common_features/database/local/repository/location/location_repository_impl.dart';
import 'package:locate_me/core/common_features/database/local/repository/login_register/login_register_repository_impl.dart';
import 'package:locate_me/core/common_features/database/local/repository/map/map_repository_impl.dart';
import 'package:locate_me/core/common_features/database/local/service/app_settings/app_settings_service_impl.dart';
import 'package:locate_me/core/common_features/database/local/service/location/location_service_impl.dart';
import 'package:locate_me/core/common_features/database/local/service/map/map_service_impl.dart';

import '../repository/app_settings/app_settings_repository_impl.dart';
import '../service/login_register/login_register_service_impl.dart';

//db
final databaseProvider = Provider<DB>((ref) {
  return DB();
});

//services
final locationDBServiceProvider = Provider<LocationServiceImpl>((ref) {
  final database = ref.watch(databaseProvider);
  return LocationServiceImpl(database);
});
final mapDBSettingServiceProvider = Provider<MapServiceImpl>((ref) {
  final database = ref.watch(databaseProvider);
  return MapServiceImpl(database);
});
final appDBSettingServiceProvider = Provider<AppSettingsServiceImpl>((ref) {
  final database = ref.watch(databaseProvider);
  return AppSettingsServiceImpl(database);
});
final appDBLoginRegisterServiceProvider =
    Provider<LoginRegisterServiceImpl>((ref) {
  final database = ref.watch(databaseProvider);
  return LoginRegisterServiceImpl(database);
});

//repo
final locationDBRepositoryProvider = Provider<LocationRepositoryImpl>((ref) {
  final service = ref.watch(locationDBServiceProvider);
  return LocationRepositoryImpl(service);
});
final mapDBSettingRepositoryProvider = Provider<MapRepositoryImpl>((ref) {
  final service = ref.watch(mapDBSettingServiceProvider);
  return MapRepositoryImpl(service);
});
final appDBSettingsRepositoryProvider =
    Provider<AppSettingsRepositoryImpl>((ref) {
  final service = ref.watch(appDBSettingServiceProvider);
  return AppSettingsRepositoryImpl(service);
});

final appDBLoginRegisterRepositoryProvider =
    Provider<LoginRegisterRepositoryImpl>((ref) {
  final service = ref.watch(appDBLoginRegisterServiceProvider);
  return LoginRegisterRepositoryImpl(service);
});
