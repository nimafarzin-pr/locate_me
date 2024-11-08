import 'package:drift/drift.dart';

import '../../db/db.dart';
import 'login_register_service.dart';

class AppSettingsDao implements ILoginRegisterService {
  final DB db;

  AppSettingsDao(this.db);

  @override
  Future<void> setPassword(String newPassword) async {
    await db.into(db.loginRegisterTB).insert(
          LoginRegisterTBCompanion(
            password: Value(newPassword),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    await (db.update(db.loginRegisterTB)
          ..where((tbl) => tbl.id.equals(1))) // Assume one settings record
        .write(LoginRegisterTBCompanion(password: Value(newPassword)));
  }
}
