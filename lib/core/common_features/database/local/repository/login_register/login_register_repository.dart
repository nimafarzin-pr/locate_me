abstract class ILoginRegisterRepository {
  Future<bool> setPassword(String newPassword);
  Future<bool> updatePassword(String newPassword);
  Future<bool> isPasswordSet();
  Future<bool> authenticate(String enteredPassword);
}
