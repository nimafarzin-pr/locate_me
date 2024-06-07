import 'package:locate_me/features/home/repository/locations_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/provider/db_provider.dart';

final homeScreenRepositoryProvider = Provider<HomeScreenRepository>((ref) {
  final repo = ref.watch(locationRepositoryProvider);
  return HomeScreenRepository(repo);
});
