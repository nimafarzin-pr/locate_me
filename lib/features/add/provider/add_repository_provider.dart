import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/add/repository/add_repository.dart';

import '../../../core/common_features/database/provider/db_provider.dart';

final addRepositoryProvider = FutureProvider<AddRepository>((ref) async {
  final repo = ref.watch(locationDBRepositoryProvider);
  return AddRepository(repo);
});
