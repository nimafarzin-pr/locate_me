// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_database_impl.dart';

// ignore_for_file: type=lint
class $LocationDBTable extends LocationDB
    with TableInfo<$LocationDBTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationDBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vicinityMeta =
      const VerificationMeta('vicinity');
  @override
  late final GeneratedColumn<String> vicinity = GeneratedColumn<String>(
      'vicinity', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        vicinity,
        latitude,
        longitude,
        address,
        category,
        description
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_d_b';
  @override
  VerificationContext validateIntegrity(Insertable<Location> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('vicinity')) {
      context.handle(_vicinityMeta,
          vicinity.isAcceptableOrUnknown(data['vicinity']!, _vicinityMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      vicinity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vicinity']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $LocationDBTable createAlias(String alias) {
    return $LocationDBTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final int id;
  final String title;
  final String? vicinity;
  final double latitude;
  final double longitude;
  final String? address;
  final String category;
  final String? description;
  const Location(
      {required this.id,
      required this.title,
      this.vicinity,
      required this.latitude,
      required this.longitude,
      this.address,
      required this.category,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || vicinity != null) {
      map['vicinity'] = Variable<String>(vicinity);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  LocationDBCompanion toCompanion(bool nullToAbsent) {
    return LocationDBCompanion(
      id: Value(id),
      title: Value(title),
      vicinity: vicinity == null && nullToAbsent
          ? const Value.absent()
          : Value(vicinity),
      latitude: Value(latitude),
      longitude: Value(longitude),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      category: Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      vicinity: serializer.fromJson<String?>(json['vicinity']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      address: serializer.fromJson<String?>(json['address']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'vicinity': serializer.toJson<String?>(vicinity),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'address': serializer.toJson<String?>(address),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String?>(description),
    };
  }

  Location copyWith(
          {int? id,
          String? title,
          Value<String?> vicinity = const Value.absent(),
          double? latitude,
          double? longitude,
          Value<String?> address = const Value.absent(),
          String? category,
          Value<String?> description = const Value.absent()}) =>
      Location(
        id: id ?? this.id,
        title: title ?? this.title,
        vicinity: vicinity.present ? vicinity.value : this.vicinity,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        address: address.present ? address.value : this.address,
        category: category ?? this.category,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('vicinity: $vicinity, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('category: $category, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, vicinity, latitude, longitude, address, category, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.title == this.title &&
          other.vicinity == this.vicinity &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.address == this.address &&
          other.category == this.category &&
          other.description == this.description);
}

class LocationDBCompanion extends UpdateCompanion<Location> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> vicinity;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String?> address;
  final Value<String> category;
  final Value<String?> description;
  const LocationDBCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.vicinity = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
  });
  LocationDBCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.vicinity = const Value.absent(),
    required double latitude,
    required double longitude,
    this.address = const Value.absent(),
    required String category,
    this.description = const Value.absent(),
  })  : title = Value(title),
        latitude = Value(latitude),
        longitude = Value(longitude),
        category = Value(category);
  static Insertable<Location> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? vicinity,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? address,
    Expression<String>? category,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (vicinity != null) 'vicinity': vicinity,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
    });
  }

  LocationDBCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? vicinity,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<String?>? address,
      Value<String>? category,
      Value<String?>? description}) {
    return LocationDBCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      vicinity: vicinity ?? this.vicinity,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (vicinity.present) {
      map['vicinity'] = Variable<String>(vicinity.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationDBCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('vicinity: $vicinity, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('category: $category, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocationDatabaseImpl extends GeneratedDatabase {
  _$LocationDatabaseImpl(QueryExecutor e) : super(e);
  _$LocationDatabaseImplManager get managers =>
      _$LocationDatabaseImplManager(this);
  late final $LocationDBTable locationDB = $LocationDBTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [locationDB];
}

typedef $$LocationDBTableInsertCompanionBuilder = LocationDBCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> vicinity,
  required double latitude,
  required double longitude,
  Value<String?> address,
  required String category,
  Value<String?> description,
});
typedef $$LocationDBTableUpdateCompanionBuilder = LocationDBCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> vicinity,
  Value<double> latitude,
  Value<double> longitude,
  Value<String?> address,
  Value<String> category,
  Value<String?> description,
});

class $$LocationDBTableTableManager extends RootTableManager<
    _$LocationDatabaseImpl,
    $LocationDBTable,
    Location,
    $$LocationDBTableFilterComposer,
    $$LocationDBTableOrderingComposer,
    $$LocationDBTableProcessedTableManager,
    $$LocationDBTableInsertCompanionBuilder,
    $$LocationDBTableUpdateCompanionBuilder> {
  $$LocationDBTableTableManager(
      _$LocationDatabaseImpl db, $LocationDBTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LocationDBTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LocationDBTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$LocationDBTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> vicinity = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              LocationDBCompanion(
            id: id,
            title: title,
            vicinity: vicinity,
            latitude: latitude,
            longitude: longitude,
            address: address,
            category: category,
            description: description,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String?> vicinity = const Value.absent(),
            required double latitude,
            required double longitude,
            Value<String?> address = const Value.absent(),
            required String category,
            Value<String?> description = const Value.absent(),
          }) =>
              LocationDBCompanion.insert(
            id: id,
            title: title,
            vicinity: vicinity,
            latitude: latitude,
            longitude: longitude,
            address: address,
            category: category,
            description: description,
          ),
        ));
}

class $$LocationDBTableProcessedTableManager extends ProcessedTableManager<
    _$LocationDatabaseImpl,
    $LocationDBTable,
    Location,
    $$LocationDBTableFilterComposer,
    $$LocationDBTableOrderingComposer,
    $$LocationDBTableProcessedTableManager,
    $$LocationDBTableInsertCompanionBuilder,
    $$LocationDBTableUpdateCompanionBuilder> {
  $$LocationDBTableProcessedTableManager(super.$state);
}

class $$LocationDBTableFilterComposer
    extends FilterComposer<_$LocationDatabaseImpl, $LocationDBTable> {
  $$LocationDBTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get vicinity => $state.composableBuilder(
      column: $state.table.vicinity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LocationDBTableOrderingComposer
    extends OrderingComposer<_$LocationDatabaseImpl, $LocationDBTable> {
  $$LocationDBTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get vicinity => $state.composableBuilder(
      column: $state.table.vicinity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get longitude => $state.composableBuilder(
      column: $state.table.longitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$LocationDatabaseImplManager {
  final _$LocationDatabaseImpl _db;
  _$LocationDatabaseImplManager(this._db);
  $$LocationDBTableTableManager get locationDB =>
      $$LocationDBTableTableManager(_db, _db.locationDB);
}
