abstract class ILoginRegisterService {
  Future<void> setPassword(String newPassword);

  Future<void> updatePassword(String newPassword);
}
