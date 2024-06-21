import 'package:locate_me/core/common_features/database/provider/db_provider.dart';
import 'package:locate_me/features/setting/repository/settings_repository.dart';
import 'package:riverpod/riverpod.dart';

final appSettingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final repo = ref.read(appDBSettingsRepositoryProvider);

  return SettingsRepository(repo);
});
