import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common_features/database/local/provider/db_provider.dart';
import '../../../../../core/common_features/database/local/repository/login_register/login_register_repository.dart';

class LoginNotifier extends AsyncNotifier<bool?> {
  late final ILoginRegisterRepository _dbRepository;

  @override
  Future<bool?> build() async {
    _dbRepository = ref.watch(appDBLoginRegisterRepositoryProvider);
    return null;
  }

  Future<bool> authenticate({required String enteredPassword}) async {
    final result = await _dbRepository.authenticate(enteredPassword);
    return result;
  }
}
