import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common_features/database/local/provider/db_provider.dart';
import '../../../../core/common_features/database/local/repository/login_register/login_register_repository.dart';

class ChangePasswordNotifier extends AsyncNotifier<bool?> {
  late final ILoginRegisterRepository _dbRepository;

  @override
  Future<bool>? build() {
    _dbRepository = ref.watch(appDBLoginRegisterRepositoryProvider);
    return null;
  }

  Future<bool> updatePassword(String newPassword) async {
    return await _dbRepository.updatePassword(newPassword);
  }
}
