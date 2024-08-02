import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common_features/database/provider/db_provider.dart';
import '../repository/add_repository.dart';

final addRepositoryProvider = FutureProvider<AddRepository>((ref) async {
  final repo = ref.watch(locationDBRepositoryProvider);
  return AddRepository(repo);
});
