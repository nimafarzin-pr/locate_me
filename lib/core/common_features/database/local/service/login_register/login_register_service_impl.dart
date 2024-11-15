import 'dart:developer';

import 'package:drift/drift.dart';

import '../../db/db.dart';
import 'login_register_service.dart';

class LoginRegisterServiceImpl implements ILoginRegisterService {
  final DB db;

  LoginRegisterServiceImpl(this.db);

  @override
  Future<bool> setPassword(String newPassword) async {
    try {
      await db.into(db.loginRegisterTB).insert(
            LoginRegisterTBCompanion(
              id: const Value(0),
              password: Value(newPassword),
            ),
            mode: InsertMode.insertOrReplace,
          );
      return await authenticate(newPassword);
    } catch (e) {
      log('ERROR setPassword: $e');
      return false;
    }
  }

  @override
  Future<bool> updatePassword(String newPassword) async {
    try {
      await (db.update(db.loginRegisterTB)
            ..where((tbl) => tbl.id.equals(0))) // Assume one settings record
          .write(LoginRegisterTBCompanion(
        password: Value(newPassword),
        id: const Value(0),
      ));

      return await authenticate(newPassword);
    } catch (e) {
      log('ERROR updatePassword: $e');
      return false;
    }
  }

  Future<String?> _getPassword() async {
    final query = db.select(db.loginRegisterTB)
      ..where((tbl) => tbl.id.equals(0));
    final result = await query.getSingleOrNull();
    return result?.password;
  }

  @override
  Future<bool> isPasswordSet() async {
    try {
      final result = await _getPassword();
      log('RRRR $result');
      final password = result != null && result.isNotEmpty;
      return password;
    } catch (e) {
      log('ERROR isPasswordSet: $e');
      return false;
    }
  }

  @override
  Future<bool> authenticate(String enteredPassword) async {
    try {
      final result = await _getPassword();
      log('result: $result');
      final password = await isPasswordSet();
      return password && result.toString().trim() == enteredPassword.trim();
    } catch (e) {
      log('ERROR isPasswordSet:  $e');
      return false;
    }
  }
}
