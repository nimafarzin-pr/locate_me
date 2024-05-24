import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/database/location/location_database_impl.dart';
import 'package:locate_me/core/database/repository/location_repository_impl.dart';
import 'package:locate_me/core/database/service/location_service_impl.dart';

final databaseProvider = Provider<LocationDatabaseImpl>((ref) {
  return LocationDatabaseImpl();
});

final locationServiceProvider = Provider<LocationServiceImpl>((ref) {
  final database = ref.watch(databaseProvider);
  return LocationServiceImpl(database);
});

final locationRepositoryProvider = Provider<LocationRepositoryImpl>((ref) {
  final service = ref.watch(locationServiceProvider);
  return LocationRepositoryImpl(service);
});
