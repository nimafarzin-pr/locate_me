import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/database/db/db.dart';
import 'package:locate_me/core/database/repository/location/location_repository_impl.dart';
import 'package:locate_me/core/database/repository/map/map_repository_impl.dart';
import 'package:locate_me/core/database/service/location/location_service_impl.dart';
import 'package:locate_me/core/database/service/map/map_service_impl.dart';

final databaseProvider = Provider<DB>((ref) {
  return DB();
});

final locationServiceProvider = Provider<LocationServiceImpl>((ref) {
  final database = ref.watch(databaseProvider);
  return LocationServiceImpl(database);
});
final mapSettingServiceProvider = Provider<MapServiceImpl>((ref) {
  final database = ref.watch(databaseProvider);
  return MapServiceImpl(database);
});

final locationRepositoryProvider = Provider<LocationRepositoryImpl>((ref) {
  final service = ref.watch(locationServiceProvider);
  return LocationRepositoryImpl(service);
});
final mapSettingRepositoryProvider = Provider<MapRepositoryImpl>((ref) {
  final service = ref.watch(mapSettingServiceProvider);
  return MapRepositoryImpl(service);
});
