import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/features/add/repository/add_repository.dart';

import '../../../core/database/provider/db_provider.dart';

final addRepositoryProvider = FutureProvider<AddRepository>((ref) async {
  final repo = ref.watch(locationRepositoryProvider);
  return AddRepository(repo);
});
