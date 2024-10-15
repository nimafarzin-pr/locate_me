import 'package:drift/drift.dart';

//* best practice for saving data like this is to use shared preferences or hive but for experience I used single row approach
@DataClassName('Categories')
class CategoriesTB extends Table {
  IntColumn get id =>
      integer().autoIncrement().withDefault(const Constant(0))();
  IntColumn get color => integer().withDefault(const Constant(0000000))();
  TextColumn get name => text().withDefault(const Constant(""))();
  TextColumn get emoji =>
      text().withDefault(const Constant(""))(); // 0: Light, 1: Dark, 2: Auto
}
