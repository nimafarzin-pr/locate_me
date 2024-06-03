import 'package:drift/drift.dart';

@DataClassName('Location')
class LocationTB extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();
  TextColumn get title => text()();
  TextColumn get vicinity => text().nullable()();
  TextColumn get icon => text()();
  RealColumn get latitude => real()();
  RealColumn get rate => real()();
  RealColumn get longitude => real()();
  TextColumn get address => text().nullable()();
  TextColumn get category => text()();
  TextColumn get description => text().nullable()();
}
