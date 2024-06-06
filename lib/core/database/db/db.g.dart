// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $LocationTBTable extends LocationTB
    with TableInfo<$LocationTBTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationTBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
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
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
      'rate', aliasedName, false,
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
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        vicinity,
        icon,
        latitude,
        rate,
        longitude,
        address,
        category,
        description,
        isFavorite
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_t_b';
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
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
          _rateMeta, rate.isAcceptableOrUnknown(data['rate']!, _rateMeta));
    } else if (isInserting) {
      context.missing(_rateMeta);
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
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
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
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      vicinity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vicinity']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      rate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $LocationTBTable createAlias(String alias) {
    return $LocationTBTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final int? id;
  final String title;
  final String? vicinity;
  final String icon;
  final double latitude;
  final double rate;
  final double longitude;
  final String? address;
  final String category;
  final String? description;
  final bool isFavorite;
  const Location(
      {this.id,
      required this.title,
      this.vicinity,
      required this.icon,
      required this.latitude,
      required this.rate,
      required this.longitude,
      this.address,
      required this.category,
      this.description,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || vicinity != null) {
      map['vicinity'] = Variable<String>(vicinity);
    }
    map['icon'] = Variable<String>(icon);
    map['latitude'] = Variable<double>(latitude);
    map['rate'] = Variable<double>(rate);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  LocationTBCompanion toCompanion(bool nullToAbsent) {
    return LocationTBCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title: Value(title),
      vicinity: vicinity == null && nullToAbsent
          ? const Value.absent()
          : Value(vicinity),
      icon: Value(icon),
      latitude: Value(latitude),
      rate: Value(rate),
      longitude: Value(longitude),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      category: Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isFavorite: Value(isFavorite),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<int?>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      vicinity: serializer.fromJson<String?>(json['vicinity']),
      icon: serializer.fromJson<String>(json['icon']),
      latitude: serializer.fromJson<double>(json['latitude']),
      rate: serializer.fromJson<double>(json['rate']),
      longitude: serializer.fromJson<double>(json['longitude']),
      address: serializer.fromJson<String?>(json['address']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'title': serializer.toJson<String>(title),
      'vicinity': serializer.toJson<String?>(vicinity),
      'icon': serializer.toJson<String>(icon),
      'latitude': serializer.toJson<double>(latitude),
      'rate': serializer.toJson<double>(rate),
      'longitude': serializer.toJson<double>(longitude),
      'address': serializer.toJson<String?>(address),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String?>(description),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Location copyWith(
          {Value<int?> id = const Value.absent(),
          String? title,
          Value<String?> vicinity = const Value.absent(),
          String? icon,
          double? latitude,
          double? rate,
          double? longitude,
          Value<String?> address = const Value.absent(),
          String? category,
          Value<String?> description = const Value.absent(),
          bool? isFavorite}) =>
      Location(
        id: id.present ? id.value : this.id,
        title: title ?? this.title,
        vicinity: vicinity.present ? vicinity.value : this.vicinity,
        icon: icon ?? this.icon,
        latitude: latitude ?? this.latitude,
        rate: rate ?? this.rate,
        longitude: longitude ?? this.longitude,
        address: address.present ? address.value : this.address,
        category: category ?? this.category,
        description: description.present ? description.value : this.description,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('vicinity: $vicinity, ')
          ..write('icon: $icon, ')
          ..write('latitude: $latitude, ')
          ..write('rate: $rate, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, vicinity, icon, latitude, rate,
      longitude, address, category, description, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.title == this.title &&
          other.vicinity == this.vicinity &&
          other.icon == this.icon &&
          other.latitude == this.latitude &&
          other.rate == this.rate &&
          other.longitude == this.longitude &&
          other.address == this.address &&
          other.category == this.category &&
          other.description == this.description &&
          other.isFavorite == this.isFavorite);
}

class LocationTBCompanion extends UpdateCompanion<Location> {
  final Value<int?> id;
  final Value<String> title;
  final Value<String?> vicinity;
  final Value<String> icon;
  final Value<double> latitude;
  final Value<double> rate;
  final Value<double> longitude;
  final Value<String?> address;
  final Value<String> category;
  final Value<String?> description;
  final Value<bool> isFavorite;
  const LocationTBCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.vicinity = const Value.absent(),
    this.icon = const Value.absent(),
    this.latitude = const Value.absent(),
    this.rate = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  LocationTBCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.vicinity = const Value.absent(),
    required String icon,
    required double latitude,
    required double rate,
    required double longitude,
    this.address = const Value.absent(),
    required String category,
    this.description = const Value.absent(),
    this.isFavorite = const Value.absent(),
  })  : title = Value(title),
        icon = Value(icon),
        latitude = Value(latitude),
        rate = Value(rate),
        longitude = Value(longitude),
        category = Value(category);
  static Insertable<Location> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? vicinity,
    Expression<String>? icon,
    Expression<double>? latitude,
    Expression<double>? rate,
    Expression<double>? longitude,
    Expression<String>? address,
    Expression<String>? category,
    Expression<String>? description,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (vicinity != null) 'vicinity': vicinity,
      if (icon != null) 'icon': icon,
      if (latitude != null) 'latitude': latitude,
      if (rate != null) 'rate': rate,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  LocationTBCompanion copyWith(
      {Value<int?>? id,
      Value<String>? title,
      Value<String?>? vicinity,
      Value<String>? icon,
      Value<double>? latitude,
      Value<double>? rate,
      Value<double>? longitude,
      Value<String?>? address,
      Value<String>? category,
      Value<String?>? description,
      Value<bool>? isFavorite}) {
    return LocationTBCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      vicinity: vicinity ?? this.vicinity,
      icon: icon ?? this.icon,
      latitude: latitude ?? this.latitude,
      rate: rate ?? this.rate,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      category: category ?? this.category,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
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
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
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
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationTBCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('vicinity: $vicinity, ')
          ..write('icon: $icon, ')
          ..write('latitude: $latitude, ')
          ..write('rate: $rate, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $MapSettingsTBTable extends MapSettingsTB
    with TableInfo<$MapSettingsTBTable, MapSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MapSettingsTBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
      defaultValue: const Constant(0));
  static const VerificationMeta _mapLayerMeta =
      const VerificationMeta('mapLayer');
  @override
  late final GeneratedColumnWithTypeConverter<MapLayer?, int> mapLayer =
      GeneratedColumn<int>('map_layer', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<MapLayer?>($MapSettingsTBTable.$convertermapLayern);
  static const VerificationMeta _mapStyleMeta =
      const VerificationMeta('mapStyle');
  @override
  late final GeneratedColumnWithTypeConverter<MapStyle?, int> mapStyle =
      GeneratedColumn<int>('map_style', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<MapStyle?>($MapSettingsTBTable.$convertermapStylen);
  @override
  List<GeneratedColumn> get $columns => [id, mapLayer, mapStyle];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'map_settings_t_b';
  @override
  VerificationContext validateIntegrity(Insertable<MapSettings> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_mapLayerMeta, const VerificationResult.success());
    context.handle(_mapStyleMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MapSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MapSettings(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mapLayer: $MapSettingsTBTable.$convertermapLayern.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}map_layer'])),
      mapStyle: $MapSettingsTBTable.$convertermapStylen.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}map_style'])),
    );
  }

  @override
  $MapSettingsTBTable createAlias(String alias) {
    return $MapSettingsTBTable(attachedDatabase, alias);
  }

  static TypeConverter<MapLayer, int> $convertermapLayer =
      const MapLayerConverter();
  static TypeConverter<MapLayer?, int?> $convertermapLayern =
      NullAwareTypeConverter.wrap($convertermapLayer);
  static TypeConverter<MapStyle, int> $convertermapStyle =
      const MapStyleConverter();
  static TypeConverter<MapStyle?, int?> $convertermapStylen =
      NullAwareTypeConverter.wrap($convertermapStyle);
}

class MapSettings extends DataClass implements Insertable<MapSettings> {
  final int id;
  final MapLayer? mapLayer;
  final MapStyle? mapStyle;
  const MapSettings({required this.id, this.mapLayer, this.mapStyle});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || mapLayer != null) {
      map['map_layer'] = Variable<int>(
          $MapSettingsTBTable.$convertermapLayern.toSql(mapLayer));
    }
    if (!nullToAbsent || mapStyle != null) {
      map['map_style'] = Variable<int>(
          $MapSettingsTBTable.$convertermapStylen.toSql(mapStyle));
    }
    return map;
  }

  MapSettingsTBCompanion toCompanion(bool nullToAbsent) {
    return MapSettingsTBCompanion(
      id: Value(id),
      mapLayer: mapLayer == null && nullToAbsent
          ? const Value.absent()
          : Value(mapLayer),
      mapStyle: mapStyle == null && nullToAbsent
          ? const Value.absent()
          : Value(mapStyle),
    );
  }

  factory MapSettings.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MapSettings(
      id: serializer.fromJson<int>(json['id']),
      mapLayer: serializer.fromJson<MapLayer?>(json['mapLayer']),
      mapStyle: serializer.fromJson<MapStyle?>(json['mapStyle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mapLayer': serializer.toJson<MapLayer?>(mapLayer),
      'mapStyle': serializer.toJson<MapStyle?>(mapStyle),
    };
  }

  MapSettings copyWith(
          {int? id,
          Value<MapLayer?> mapLayer = const Value.absent(),
          Value<MapStyle?> mapStyle = const Value.absent()}) =>
      MapSettings(
        id: id ?? this.id,
        mapLayer: mapLayer.present ? mapLayer.value : this.mapLayer,
        mapStyle: mapStyle.present ? mapStyle.value : this.mapStyle,
      );
  @override
  String toString() {
    return (StringBuffer('MapSettings(')
          ..write('id: $id, ')
          ..write('mapLayer: $mapLayer, ')
          ..write('mapStyle: $mapStyle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mapLayer, mapStyle);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MapSettings &&
          other.id == this.id &&
          other.mapLayer == this.mapLayer &&
          other.mapStyle == this.mapStyle);
}

class MapSettingsTBCompanion extends UpdateCompanion<MapSettings> {
  final Value<int> id;
  final Value<MapLayer?> mapLayer;
  final Value<MapStyle?> mapStyle;
  const MapSettingsTBCompanion({
    this.id = const Value.absent(),
    this.mapLayer = const Value.absent(),
    this.mapStyle = const Value.absent(),
  });
  MapSettingsTBCompanion.insert({
    this.id = const Value.absent(),
    this.mapLayer = const Value.absent(),
    this.mapStyle = const Value.absent(),
  });
  static Insertable<MapSettings> custom({
    Expression<int>? id,
    Expression<int>? mapLayer,
    Expression<int>? mapStyle,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mapLayer != null) 'map_layer': mapLayer,
      if (mapStyle != null) 'map_style': mapStyle,
    });
  }

  MapSettingsTBCompanion copyWith(
      {Value<int>? id,
      Value<MapLayer?>? mapLayer,
      Value<MapStyle?>? mapStyle}) {
    return MapSettingsTBCompanion(
      id: id ?? this.id,
      mapLayer: mapLayer ?? this.mapLayer,
      mapStyle: mapStyle ?? this.mapStyle,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mapLayer.present) {
      map['map_layer'] = Variable<int>(
          $MapSettingsTBTable.$convertermapLayern.toSql(mapLayer.value));
    }
    if (mapStyle.present) {
      map['map_style'] = Variable<int>(
          $MapSettingsTBTable.$convertermapStylen.toSql(mapStyle.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MapSettingsTBCompanion(')
          ..write('id: $id, ')
          ..write('mapLayer: $mapLayer, ')
          ..write('mapStyle: $mapStyle')
          ..write(')'))
        .toString();
  }
}

abstract class _$DB extends GeneratedDatabase {
  _$DB(QueryExecutor e) : super(e);
  _$DBManager get managers => _$DBManager(this);
  late final $LocationTBTable locationTB = $LocationTBTable(this);
  late final $MapSettingsTBTable mapSettingsTB = $MapSettingsTBTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [locationTB, mapSettingsTB];
}

typedef $$LocationTBTableInsertCompanionBuilder = LocationTBCompanion Function({
  Value<int?> id,
  required String title,
  Value<String?> vicinity,
  required String icon,
  required double latitude,
  required double rate,
  required double longitude,
  Value<String?> address,
  required String category,
  Value<String?> description,
  Value<bool> isFavorite,
});
typedef $$LocationTBTableUpdateCompanionBuilder = LocationTBCompanion Function({
  Value<int?> id,
  Value<String> title,
  Value<String?> vicinity,
  Value<String> icon,
  Value<double> latitude,
  Value<double> rate,
  Value<double> longitude,
  Value<String?> address,
  Value<String> category,
  Value<String?> description,
  Value<bool> isFavorite,
});

class $$LocationTBTableTableManager extends RootTableManager<
    _$DB,
    $LocationTBTable,
    Location,
    $$LocationTBTableFilterComposer,
    $$LocationTBTableOrderingComposer,
    $$LocationTBTableProcessedTableManager,
    $$LocationTBTableInsertCompanionBuilder,
    $$LocationTBTableUpdateCompanionBuilder> {
  $$LocationTBTableTableManager(_$DB db, $LocationTBTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LocationTBTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LocationTBTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$LocationTBTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int?> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> vicinity = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> rate = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
          }) =>
              LocationTBCompanion(
            id: id,
            title: title,
            vicinity: vicinity,
            icon: icon,
            latitude: latitude,
            rate: rate,
            longitude: longitude,
            address: address,
            category: category,
            description: description,
            isFavorite: isFavorite,
          ),
          getInsertCompanionBuilder: ({
            Value<int?> id = const Value.absent(),
            required String title,
            Value<String?> vicinity = const Value.absent(),
            required String icon,
            required double latitude,
            required double rate,
            required double longitude,
            Value<String?> address = const Value.absent(),
            required String category,
            Value<String?> description = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
          }) =>
              LocationTBCompanion.insert(
            id: id,
            title: title,
            vicinity: vicinity,
            icon: icon,
            latitude: latitude,
            rate: rate,
            longitude: longitude,
            address: address,
            category: category,
            description: description,
            isFavorite: isFavorite,
          ),
        ));
}

class $$LocationTBTableProcessedTableManager extends ProcessedTableManager<
    _$DB,
    $LocationTBTable,
    Location,
    $$LocationTBTableFilterComposer,
    $$LocationTBTableOrderingComposer,
    $$LocationTBTableProcessedTableManager,
    $$LocationTBTableInsertCompanionBuilder,
    $$LocationTBTableUpdateCompanionBuilder> {
  $$LocationTBTableProcessedTableManager(super.$state);
}

class $$LocationTBTableFilterComposer
    extends FilterComposer<_$DB, $LocationTBTable> {
  $$LocationTBTableFilterComposer(super.$state);
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

  ColumnFilters<String> get icon => $state.composableBuilder(
      column: $state.table.icon,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get rate => $state.composableBuilder(
      column: $state.table.rate,
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

  ColumnFilters<bool> get isFavorite => $state.composableBuilder(
      column: $state.table.isFavorite,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LocationTBTableOrderingComposer
    extends OrderingComposer<_$DB, $LocationTBTable> {
  $$LocationTBTableOrderingComposer(super.$state);
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

  ColumnOrderings<String> get icon => $state.composableBuilder(
      column: $state.table.icon,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get latitude => $state.composableBuilder(
      column: $state.table.latitude,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get rate => $state.composableBuilder(
      column: $state.table.rate,
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

  ColumnOrderings<bool> get isFavorite => $state.composableBuilder(
      column: $state.table.isFavorite,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MapSettingsTBTableInsertCompanionBuilder = MapSettingsTBCompanion
    Function({
  Value<int> id,
  Value<MapLayer?> mapLayer,
  Value<MapStyle?> mapStyle,
});
typedef $$MapSettingsTBTableUpdateCompanionBuilder = MapSettingsTBCompanion
    Function({
  Value<int> id,
  Value<MapLayer?> mapLayer,
  Value<MapStyle?> mapStyle,
});

class $$MapSettingsTBTableTableManager extends RootTableManager<
    _$DB,
    $MapSettingsTBTable,
    MapSettings,
    $$MapSettingsTBTableFilterComposer,
    $$MapSettingsTBTableOrderingComposer,
    $$MapSettingsTBTableProcessedTableManager,
    $$MapSettingsTBTableInsertCompanionBuilder,
    $$MapSettingsTBTableUpdateCompanionBuilder> {
  $$MapSettingsTBTableTableManager(_$DB db, $MapSettingsTBTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MapSettingsTBTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MapSettingsTBTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$MapSettingsTBTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<MapLayer?> mapLayer = const Value.absent(),
            Value<MapStyle?> mapStyle = const Value.absent(),
          }) =>
              MapSettingsTBCompanion(
            id: id,
            mapLayer: mapLayer,
            mapStyle: mapStyle,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<MapLayer?> mapLayer = const Value.absent(),
            Value<MapStyle?> mapStyle = const Value.absent(),
          }) =>
              MapSettingsTBCompanion.insert(
            id: id,
            mapLayer: mapLayer,
            mapStyle: mapStyle,
          ),
        ));
}

class $$MapSettingsTBTableProcessedTableManager extends ProcessedTableManager<
    _$DB,
    $MapSettingsTBTable,
    MapSettings,
    $$MapSettingsTBTableFilterComposer,
    $$MapSettingsTBTableOrderingComposer,
    $$MapSettingsTBTableProcessedTableManager,
    $$MapSettingsTBTableInsertCompanionBuilder,
    $$MapSettingsTBTableUpdateCompanionBuilder> {
  $$MapSettingsTBTableProcessedTableManager(super.$state);
}

class $$MapSettingsTBTableFilterComposer
    extends FilterComposer<_$DB, $MapSettingsTBTable> {
  $$MapSettingsTBTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<MapLayer?, MapLayer, int> get mapLayer =>
      $state.composableBuilder(
          column: $state.table.mapLayer,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));

  ColumnWithTypeConverterFilters<MapStyle?, MapStyle, int> get mapStyle =>
      $state.composableBuilder(
          column: $state.table.mapStyle,
          builder: (column, joinBuilders) => ColumnWithTypeConverterFilters(
              column,
              joinBuilders: joinBuilders));
}

class $$MapSettingsTBTableOrderingComposer
    extends OrderingComposer<_$DB, $MapSettingsTBTable> {
  $$MapSettingsTBTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get mapLayer => $state.composableBuilder(
      column: $state.table.mapLayer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get mapStyle => $state.composableBuilder(
      column: $state.table.mapStyle,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$DBManager {
  final _$DB _db;
  _$DBManager(this._db);
  $$LocationTBTableTableManager get locationTB =>
      $$LocationTBTableTableManager(_db, _db.locationTB);
  $$MapSettingsTBTableTableManager get mapSettingsTB =>
      $$MapSettingsTBTableTableManager(_db, _db.mapSettingsTB);
}
