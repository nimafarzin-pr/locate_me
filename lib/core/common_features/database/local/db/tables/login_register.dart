import 'package:drift/drift.dart';

class LoginRegisterTB extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get password => text().nullable()(); // New password column
}
