import 'package:drift/drift.dart';

@DataClassName('Location')
class LocationTB extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();
  TextColumn get title => text()();
  TextColumn get vicinity => text().nullable()();
  TextColumn get picture => text()();
  RealColumn get latitude => real()();
  RealColumn get rate => real()();
  RealColumn get longitude => real()();
  TextColumn get address => text().nullable()();
  TextColumn get categoryIcon => text()();
  TextColumn get categoryName => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}
