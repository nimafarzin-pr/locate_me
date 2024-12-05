import 'package:drift/drift.dart';

class LoginRegisterTB extends Table {
  IntColumn get id =>
      integer().autoIncrement().withDefault(const Constant(0))();
  TextColumn get password => text().nullable()(); // New password column
}
