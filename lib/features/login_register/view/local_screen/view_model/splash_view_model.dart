import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common_features/database/local/provider/db_provider.dart';
import '../../../../../core/common_features/database/local/repository/login_register/login_register_repository.dart';

class SplashNotifier extends AsyncNotifier<bool> {
  late final ILoginRegisterRepository _dbRepository;

  @override
  Future<bool> build() async {
    _dbRepository = ref.watch(appDBLoginRegisterRepositoryProvider);
    // Load the current session state when the provider is first initialized
    final isSet = await _dbRepository.isPasswordSet();
    log('isSet: $isSet');
    state = AsyncData(isSet);
    return isSet;
  }

  Future<bool> isPasswordSet() async {
    return await _dbRepository.isPasswordSet();
  }
}
