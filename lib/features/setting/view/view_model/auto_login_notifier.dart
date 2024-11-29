import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/common_features/database/local/repository/app_settings/app_settings_repository.dart';

import '../../../../core/common_features/database/local/provider/db_provider.dart';

class AutoLoginNotifier extends AsyncNotifier<bool> {
  late final IAppSettingsRepository _dbRepository;

  @override
  Future<bool> build() async {
    _dbRepository = ref.watch(appDBSettingsRepositoryProvider);
    final result = await getAutoLoginState();
    state = AsyncData(result);
    return result;
  }

  Future<void> updateAutoLoginState() async {
    await _dbRepository.toggleAutoLogin();
    final result = await _dbRepository.getAutoLoginState();
    state = AsyncData(result);
  }

  Stream<bool> watchAutoLoginState() {
    return _dbRepository.watchAutoLoginState();
  }

  Future<bool> getAutoLoginState() async {
    final result = await _dbRepository.getAutoLoginState();
    state = AsyncData(result);

    return result;
  }
}
