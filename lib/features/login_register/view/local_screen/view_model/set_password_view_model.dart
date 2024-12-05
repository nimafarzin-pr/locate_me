import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common_features/database/local/provider/db_provider.dart';
import '../../../../../core/common_features/database/local/repository/login_register/login_register_repository.dart';

class SetPasswordNotifier extends AsyncNotifier<bool?> {
  late final ILoginRegisterRepository _dbRepository;

  @override
  Future<bool?> build() async {
    _dbRepository = ref.watch(appDBLoginRegisterRepositoryProvider);
    return null;
  }

  Future<bool> setPassword({required String password}) async {
    try {
      state = const AsyncData(true);
      return await _dbRepository.setPassword(password);
    } catch (e) {
      log('ERROR isPasswordSet: $e');
      state = const AsyncData(false);

      return false;
    }
  }
}
