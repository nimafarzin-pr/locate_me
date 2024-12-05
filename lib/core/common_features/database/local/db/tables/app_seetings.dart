import 'package:drift/drift.dart';

//* best practice for saving data like this is to use shared preferences or hive but for experience I used single row approach
@DataClassName('AppSettings')
class AppSettingsTB extends Table {
  IntColumn get id =>
      integer().autoIncrement().withDefault(const Constant(0))();
  TextColumn get language =>
      text().nullable().withDefault(const Constant("fa"))();
  IntColumn get themeMode => integer()
      .nullable()
      .withDefault(const Constant(2))(); // 0: Light, 1: Dark, 2: Auto

  BoolColumn get autoLogin =>
      boolean().withDefault(const Constant(false))(); // New auto-login column
}
