import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/database/db/db.dart';
import 'package:locate_me/core/common_features/database/repository/location/location_repository_impl.dart';
import 'package:locate_me/core/common_features/database/repository/map/map_repository_impl.dart';
import 'package:locate_me/core/common_features/database/service/app_settings/app_settings_service_impl.dart';
import 'package:locate_me/core/common_features/database/service/location/location_service_impl.dart';
import 'package:locate_me/core/common_features/database/service/map/map_service_impl.dart';

import '../repository/app_settings/app_settings_repository_impl.dart';

final databaseProvider = Provider<DB>((ref) {
  return DB();
});

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
