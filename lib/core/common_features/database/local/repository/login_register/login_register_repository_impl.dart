import 'package:locate_me/core/common_features/database/local/repository/login_register/login_register_repository.dart';

import '../../service/login_register/login_register_service.dart';

class LoginRegisterRepositoryImpl implements ILoginRegisterRepository {
  final ILoginRegisterService repo;

  LoginRegisterRepositoryImpl(this.repo);

  @override
  Future<bool> setPassword(String newPassword) async {
    return await repo.setPassword(newPassword);
  }

  @override
  Future<bool> updatePassword(String newPassword) async {
    return await repo.updatePassword(newPassword);
  }

  @override
  Future<bool> isPasswordSet() async {
    return await repo.isPasswordSet();
  }

  @override
  Future<bool> authenticate(String enteredPassword) async {
    return await repo.authenticate(enteredPassword);
  }
}
