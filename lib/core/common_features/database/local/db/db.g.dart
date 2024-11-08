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
  static const VerificationMeta _pictureMeta =
      const VerificationMeta('picture');
  @override
  late final GeneratedColumn<String> picture = GeneratedColumn<String>(
      'picture', aliasedName, false,
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
  static const VerificationMeta _categoryIconMeta =
      const VerificationMeta('categoryIcon');
  @override
  late final GeneratedColumn<String> categoryIcon = GeneratedColumn<String>(
      'category_icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'category_name', aliasedName, false,
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
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        vicinity,
        picture,
        latitude,
        rate,
        longitude,
        address,
        categoryIcon,
        categoryName,
        description,
        isFavorite,
        timestamp
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
    if (data.containsKey('picture')) {
      context.handle(_pictureMeta,
          picture.isAcceptableOrUnknown(data['picture']!, _pictureMeta));
    } else if (isInserting) {
      context.missing(_pictureMeta);
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
    if (data.containsKey('category_icon')) {
      context.handle(
          _categoryIconMeta,
          categoryIcon.isAcceptableOrUnknown(
              data['category_icon']!, _categoryIconMeta));
    } else if (isInserting) {
      context.missing(_categoryIconMeta);
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
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
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
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
      picture: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}picture'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      rate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rate'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      categoryIcon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_icon'])!,
      categoryName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
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
  final String picture;
  final double latitude;
  final double rate;
  final double longitude;
  final String? address;
  final String categoryIcon;
  final String categoryName;
  final String? description;
  final bool isFavorite;
  final DateTime timestamp;
  const Location(
      {this.id,
      required this.title,
      this.vicinity,
      required this.picture,
      required this.latitude,
      required this.rate,
      required this.longitude,
      this.address,
      required this.categoryIcon,
      required this.categoryName,
      this.description,
      required this.isFavorite,
      required this.timestamp});
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
    map['picture'] = Variable<String>(picture);
    map['latitude'] = Variable<double>(latitude);
    map['rate'] = Variable<double>(rate);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['category_icon'] = Variable<String>(categoryIcon);
    map['category_name'] = Variable<String>(categoryName);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  LocationTBCompanion toCompanion(bool nullToAbsent) {
    return LocationTBCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title: Value(title),
      vicinity: vicinity == null && nullToAbsent
          ? const Value.absent()
          : Value(vicinity),
      picture: Value(picture),
      latitude: Value(latitude),
      rate: Value(rate),
      longitude: Value(longitude),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      categoryIcon: Value(categoryIcon),
      categoryName: Value(categoryName),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isFavorite: Value(isFavorite),
      timestamp: Value(timestamp),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<int?>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      vicinity: serializer.fromJson<String?>(json['vicinity']),
      picture: serializer.fromJson<String>(json['picture']),
      latitude: serializer.fromJson<double>(json['latitude']),
      rate: serializer.fromJson<double>(json['rate']),
      longitude: serializer.fromJson<double>(json['longitude']),
      address: serializer.fromJson<String?>(json['address']),
      categoryIcon: serializer.fromJson<String>(json['categoryIcon']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      description: serializer.fromJson<String?>(json['description']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'title': serializer.toJson<String>(title),
      'vicinity': serializer.toJson<String?>(vicinity),
      'picture': serializer.toJson<String>(picture),
      'latitude': serializer.toJson<double>(latitude),
      'rate': serializer.toJson<double>(rate),
      'longitude': serializer.toJson<double>(longitude),
      'address': serializer.toJson<String?>(address),
      'categoryIcon': serializer.toJson<String>(categoryIcon),
      'categoryName': serializer.toJson<String>(categoryName),
      'description': serializer.toJson<String?>(description),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  Location copyWith(
          {Value<int?> id = const Value.absent(),
          String? title,
          Value<String?> vicinity = const Value.absent(),
          String? picture,
          double? latitude,
          double? rate,
          double? longitude,
          Value<String?> address = const Value.absent(),
          String? categoryIcon,
          String? categoryName,
          Value<String?> description = const Value.absent(),
          bool? isFavorite,
          DateTime? timestamp}) =>
      Location(
        id: id.present ? id.value : this.id,
        title: title ?? this.title,
        vicinity: vicinity.present ? vicinity.value : this.vicinity,
        picture: picture ?? this.picture,
        latitude: latitude ?? this.latitude,
        rate: rate ?? this.rate,
        longitude: longitude ?? this.longitude,
        address: address.present ? address.value : this.address,
        categoryIcon: categoryIcon ?? this.categoryIcon,
        categoryName: categoryName ?? this.categoryName,
        description: description.present ? description.value : this.description,
        isFavorite: isFavorite ?? this.isFavorite,
        timestamp: timestamp ?? this.timestamp,
      );
  Location copyWithCompanion(LocationTBCompanion data) {
    return Location(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      vicinity: data.vicinity.present ? data.vicinity.value : this.vicinity,
      picture: data.picture.present ? data.picture.value : this.picture,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      rate: data.rate.present ? data.rate.value : this.rate,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      address: data.address.present ? data.address.value : this.address,
      categoryIcon: data.categoryIcon.present
          ? data.categoryIcon.value
          : this.categoryIcon,
      categoryName: data.categoryName.present
          ? data.categoryName.value
          : this.categoryName,
      description:
          data.description.present ? data.description.value : this.description,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('vicinity: $vicinity, ')
          ..write('picture: $picture, ')
          ..write('latitude: $latitude, ')
          ..write('rate: $rate, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('categoryIcon: $categoryIcon, ')
          ..write('categoryName: $categoryName, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      vicinity,
      picture,
      latitude,
      rate,
      longitude,
      address,
      categoryIcon,
      categoryName,
      description,
      isFavorite,
      timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.title == this.title &&
          other.vicinity == this.vicinity &&
          other.picture == this.picture &&
          other.latitude == this.latitude &&
          other.rate == this.rate &&
          other.longitude == this.longitude &&
          other.address == this.address &&
          other.categoryIcon == this.categoryIcon &&
          other.categoryName == this.categoryName &&
          other.description == this.description &&
          other.isFavorite == this.isFavorite &&
          other.timestamp == this.timestamp);
}

class LocationTBCompanion extends UpdateCompanion<Location> {
  final Value<int?> id;
  final Value<String> title;
  final Value<String?> vicinity;
  final Value<String> picture;
  final Value<double> latitude;
  final Value<double> rate;
  final Value<double> longitude;
  final Value<String?> address;
  final Value<String> categoryIcon;
  final Value<String> categoryName;
  final Value<String?> description;
  final Value<bool> isFavorite;
  final Value<DateTime> timestamp;
  const LocationTBCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.vicinity = const Value.absent(),
    this.picture = const Value.absent(),
    this.latitude = const Value.absent(),
    this.rate = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
    this.categoryIcon = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.description = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  LocationTBCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.vicinity = const Value.absent(),
    required String picture,
    required double latitude,
    required double rate,
    required double longitude,
    this.address = const Value.absent(),
    required String categoryIcon,
    required String categoryName,
    this.description = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.timestamp = const Value.absent(),
  })  : title = Value(title),
        picture = Value(picture),
        latitude = Value(latitude),
        rate = Value(rate),
        longitude = Value(longitude),
        categoryIcon = Value(categoryIcon),
        categoryName = Value(categoryName);
  static Insertable<Location> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? vicinity,
    Expression<String>? picture,
    Expression<double>? latitude,
    Expression<double>? rate,
    Expression<double>? longitude,
    Expression<String>? address,
    Expression<String>? categoryIcon,
    Expression<String>? categoryName,
    Expression<String>? description,
    Expression<bool>? isFavorite,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (vicinity != null) 'vicinity': vicinity,
      if (picture != null) 'picture': picture,
      if (latitude != null) 'latitude': latitude,
      if (rate != null) 'rate': rate,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
      if (categoryIcon != null) 'category_icon': categoryIcon,
      if (categoryName != null) 'category_name': categoryName,
      if (description != null) 'description': description,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  LocationTBCompanion copyWith(
      {Value<int?>? id,
      Value<String>? title,
      Value<String?>? vicinity,
      Value<String>? picture,
      Value<double>? latitude,
      Value<double>? rate,
      Value<double>? longitude,
      Value<String?>? address,
      Value<String>? categoryIcon,
      Value<String>? categoryName,
      Value<String?>? description,
      Value<bool>? isFavorite,
      Value<DateTime>? timestamp}) {
    return LocationTBCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      vicinity: vicinity ?? this.vicinity,
      picture: picture ?? this.picture,
      latitude: latitude ?? this.latitude,
      rate: rate ?? this.rate,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      timestamp: timestamp ?? this.timestamp,
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
    if (picture.present) {
      map['picture'] = Variable<String>(picture.value);
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
    if (categoryIcon.present) {
      map['category_icon'] = Variable<String>(categoryIcon.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationTBCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('vicinity: $vicinity, ')
          ..write('picture: $picture, ')
          ..write('latitude: $latitude, ')
          ..write('rate: $rate, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('categoryIcon: $categoryIcon, ')
          ..write('categoryName: $categoryName, ')
          ..write('description: $description, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('timestamp: $timestamp')
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
      const DBMapLayerConverter();
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
  MapSettings copyWithCompanion(MapSettingsTBCompanion data) {
    return MapSettings(
      id: data.id.present ? data.id.value : this.id,
      mapLayer: data.mapLayer.present ? data.mapLayer.value : this.mapLayer,
      mapStyle: data.mapStyle.present ? data.mapStyle.value : this.mapStyle,
    );
  }

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

class $AppSettingsTBTable extends AppSettingsTB
    with TableInfo<$AppSettingsTBTable, AppSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTBTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant("fa"));
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumn<int> themeMode = GeneratedColumn<int>(
      'theme_mode', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(2));
  static const VerificationMeta _autoLoginMeta =
      const VerificationMeta('autoLogin');
  @override
  late final GeneratedColumn<bool> autoLogin = GeneratedColumn<bool>(
      'auto_login', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("auto_login" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, language, themeMode, autoLogin];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_t_b';
  @override
  VerificationContext validateIntegrity(Insertable<AppSettings> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(_themeModeMeta,
          themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta));
    }
    if (data.containsKey('auto_login')) {
      context.handle(_autoLoginMeta,
          autoLogin.isAcceptableOrUnknown(data['auto_login']!, _autoLoginMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettings(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language']),
      themeMode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}theme_mode']),
      autoLogin: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}auto_login'])!,
    );
  }

  @override
  $AppSettingsTBTable createAlias(String alias) {
    return $AppSettingsTBTable(attachedDatabase, alias);
  }
}

class AppSettings extends DataClass implements Insertable<AppSettings> {
  final int id;
  final String? language;
  final int? themeMode;
  final bool autoLogin;
  const AppSettings(
      {required this.id,
      this.language,
      this.themeMode,
      required this.autoLogin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    if (!nullToAbsent || themeMode != null) {
      map['theme_mode'] = Variable<int>(themeMode);
    }
    map['auto_login'] = Variable<bool>(autoLogin);
    return map;
  }

  AppSettingsTBCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTBCompanion(
      id: Value(id),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      themeMode: themeMode == null && nullToAbsent
          ? const Value.absent()
          : Value(themeMode),
      autoLogin: Value(autoLogin),
    );
  }

  factory AppSettings.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettings(
      id: serializer.fromJson<int>(json['id']),
      language: serializer.fromJson<String?>(json['language']),
      themeMode: serializer.fromJson<int?>(json['themeMode']),
      autoLogin: serializer.fromJson<bool>(json['autoLogin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'language': serializer.toJson<String?>(language),
      'themeMode': serializer.toJson<int?>(themeMode),
      'autoLogin': serializer.toJson<bool>(autoLogin),
    };
  }

  AppSettings copyWith(
          {int? id,
          Value<String?> language = const Value.absent(),
          Value<int?> themeMode = const Value.absent(),
          bool? autoLogin}) =>
      AppSettings(
        id: id ?? this.id,
        language: language.present ? language.value : this.language,
        themeMode: themeMode.present ? themeMode.value : this.themeMode,
        autoLogin: autoLogin ?? this.autoLogin,
      );
  AppSettings copyWithCompanion(AppSettingsTBCompanion data) {
    return AppSettings(
      id: data.id.present ? data.id.value : this.id,
      language: data.language.present ? data.language.value : this.language,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      autoLogin: data.autoLogin.present ? data.autoLogin.value : this.autoLogin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettings(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('themeMode: $themeMode, ')
          ..write('autoLogin: $autoLogin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, language, themeMode, autoLogin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettings &&
          other.id == this.id &&
          other.language == this.language &&
          other.themeMode == this.themeMode &&
          other.autoLogin == this.autoLogin);
}

class AppSettingsTBCompanion extends UpdateCompanion<AppSettings> {
  final Value<int> id;
  final Value<String?> language;
  final Value<int?> themeMode;
  final Value<bool> autoLogin;
  const AppSettingsTBCompanion({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.autoLogin = const Value.absent(),
  });
  AppSettingsTBCompanion.insert({
    this.id = const Value.absent(),
    this.language = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.autoLogin = const Value.absent(),
  });
  static Insertable<AppSettings> custom({
    Expression<int>? id,
    Expression<String>? language,
    Expression<int>? themeMode,
    Expression<bool>? autoLogin,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (language != null) 'language': language,
      if (themeMode != null) 'theme_mode': themeMode,
      if (autoLogin != null) 'auto_login': autoLogin,
    });
  }

  AppSettingsTBCompanion copyWith(
      {Value<int>? id,
      Value<String?>? language,
      Value<int?>? themeMode,
      Value<bool>? autoLogin}) {
    return AppSettingsTBCompanion(
      id: id ?? this.id,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      autoLogin: autoLogin ?? this.autoLogin,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<int>(themeMode.value);
    }
    if (autoLogin.present) {
      map['auto_login'] = Variable<bool>(autoLogin.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTBCompanion(')
          ..write('id: $id, ')
          ..write('language: $language, ')
          ..write('themeMode: $themeMode, ')
          ..write('autoLogin: $autoLogin')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTBTable extends CategoriesTB
    with TableInfo<$CategoriesTBTable, Categories> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTBTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0000000));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
      'emoji', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  @override
  List<GeneratedColumn> get $columns => [id, color, name, emoji];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_t_b';
  @override
  VerificationContext validateIntegrity(Insertable<Categories> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('emoji')) {
      context.handle(
          _emojiMeta, emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categories map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categories(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      emoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emoji'])!,
    );
  }

  @override
  $CategoriesTBTable createAlias(String alias) {
    return $CategoriesTBTable(attachedDatabase, alias);
  }
}

class Categories extends DataClass implements Insertable<Categories> {
  final int id;
  final int color;
  final String name;
  final String emoji;
  const Categories(
      {required this.id,
      required this.color,
      required this.name,
      required this.emoji});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['color'] = Variable<int>(color);
    map['name'] = Variable<String>(name);
    map['emoji'] = Variable<String>(emoji);
    return map;
  }

  CategoriesTBCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTBCompanion(
      id: Value(id),
      color: Value(color),
      name: Value(name),
      emoji: Value(emoji),
    );
  }

  factory Categories.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categories(
      id: serializer.fromJson<int>(json['id']),
      color: serializer.fromJson<int>(json['color']),
      name: serializer.fromJson<String>(json['name']),
      emoji: serializer.fromJson<String>(json['emoji']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'color': serializer.toJson<int>(color),
      'name': serializer.toJson<String>(name),
      'emoji': serializer.toJson<String>(emoji),
    };
  }

  Categories copyWith({int? id, int? color, String? name, String? emoji}) =>
      Categories(
        id: id ?? this.id,
        color: color ?? this.color,
        name: name ?? this.name,
        emoji: emoji ?? this.emoji,
      );
  Categories copyWithCompanion(CategoriesTBCompanion data) {
    return Categories(
      id: data.id.present ? data.id.value : this.id,
      color: data.color.present ? data.color.value : this.color,
      name: data.name.present ? data.name.value : this.name,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categories(')
          ..write('id: $id, ')
          ..write('color: $color, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, color, name, emoji);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categories &&
          other.id == this.id &&
          other.color == this.color &&
          other.name == this.name &&
          other.emoji == this.emoji);
}

class CategoriesTBCompanion extends UpdateCompanion<Categories> {
  final Value<int> id;
  final Value<int> color;
  final Value<String> name;
  final Value<String> emoji;
  const CategoriesTBCompanion({
    this.id = const Value.absent(),
    this.color = const Value.absent(),
    this.name = const Value.absent(),
    this.emoji = const Value.absent(),
  });
  CategoriesTBCompanion.insert({
    this.id = const Value.absent(),
    this.color = const Value.absent(),
    this.name = const Value.absent(),
    this.emoji = const Value.absent(),
  });
  static Insertable<Categories> custom({
    Expression<int>? id,
    Expression<int>? color,
    Expression<String>? name,
    Expression<String>? emoji,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (color != null) 'color': color,
      if (name != null) 'name': name,
      if (emoji != null) 'emoji': emoji,
    });
  }

  CategoriesTBCompanion copyWith(
      {Value<int>? id,
      Value<int>? color,
      Value<String>? name,
      Value<String>? emoji}) {
    return CategoriesTBCompanion(
      id: id ?? this.id,
      color: color ?? this.color,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTBCompanion(')
          ..write('id: $id, ')
          ..write('color: $color, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji')
          ..write(')'))
        .toString();
  }
}

class $LoginRegisterTBTable extends LoginRegisterTB
    with TableInfo<$LoginRegisterTBTable, LoginRegisterTBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoginRegisterTBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'login_register_t_b';
  @override
  VerificationContext validateIntegrity(
      Insertable<LoginRegisterTBData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoginRegisterTBData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoginRegisterTBData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
    );
  }

  @override
  $LoginRegisterTBTable createAlias(String alias) {
    return $LoginRegisterTBTable(attachedDatabase, alias);
  }
}

class LoginRegisterTBData extends DataClass
    implements Insertable<LoginRegisterTBData> {
  final int id;
  final String? password;
  const LoginRegisterTBData({required this.id, this.password});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    return map;
  }

  LoginRegisterTBCompanion toCompanion(bool nullToAbsent) {
    return LoginRegisterTBCompanion(
      id: Value(id),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
    );
  }

  factory LoginRegisterTBData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoginRegisterTBData(
      id: serializer.fromJson<int>(json['id']),
      password: serializer.fromJson<String?>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'password': serializer.toJson<String?>(password),
    };
  }

  LoginRegisterTBData copyWith(
          {int? id, Value<String?> password = const Value.absent()}) =>
      LoginRegisterTBData(
        id: id ?? this.id,
        password: password.present ? password.value : this.password,
      );
  LoginRegisterTBData copyWithCompanion(LoginRegisterTBCompanion data) {
    return LoginRegisterTBData(
      id: data.id.present ? data.id.value : this.id,
      password: data.password.present ? data.password.value : this.password,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoginRegisterTBData(')
          ..write('id: $id, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginRegisterTBData &&
          other.id == this.id &&
          other.password == this.password);
}

class LoginRegisterTBCompanion extends UpdateCompanion<LoginRegisterTBData> {
  final Value<int> id;
  final Value<String?> password;
  const LoginRegisterTBCompanion({
    this.id = const Value.absent(),
    this.password = const Value.absent(),
  });
  LoginRegisterTBCompanion.insert({
    this.id = const Value.absent(),
    this.password = const Value.absent(),
  });
  static Insertable<LoginRegisterTBData> custom({
    Expression<int>? id,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (password != null) 'password': password,
    });
  }

  LoginRegisterTBCompanion copyWith(
      {Value<int>? id, Value<String?>? password}) {
    return LoginRegisterTBCompanion(
      id: id ?? this.id,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoginRegisterTBCompanion(')
          ..write('id: $id, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

abstract class _$DB extends GeneratedDatabase {
  _$DB(QueryExecutor e) : super(e);
  $DBManager get managers => $DBManager(this);
  late final $LocationTBTable locationTB = $LocationTBTable(this);
  late final $MapSettingsTBTable mapSettingsTB = $MapSettingsTBTable(this);
  late final $AppSettingsTBTable appSettingsTB = $AppSettingsTBTable(this);
  late final $CategoriesTBTable categoriesTB = $CategoriesTBTable(this);
  late final $LoginRegisterTBTable loginRegisterTB =
      $LoginRegisterTBTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [locationTB, mapSettingsTB, appSettingsTB, categoriesTB, loginRegisterTB];
}

typedef $$LocationTBTableCreateCompanionBuilder = LocationTBCompanion Function({
  Value<int?> id,
  required String title,
  Value<String?> vicinity,
  required String picture,
  required double latitude,
  required double rate,
  required double longitude,
  Value<String?> address,
  required String categoryIcon,
  required String categoryName,
  Value<String?> description,
  Value<bool> isFavorite,
  Value<DateTime> timestamp,
});
typedef $$LocationTBTableUpdateCompanionBuilder = LocationTBCompanion Function({
  Value<int?> id,
  Value<String> title,
  Value<String?> vicinity,
  Value<String> picture,
  Value<double> latitude,
  Value<double> rate,
  Value<double> longitude,
  Value<String?> address,
  Value<String> categoryIcon,
  Value<String> categoryName,
  Value<String?> description,
  Value<bool> isFavorite,
  Value<DateTime> timestamp,
});

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

  ColumnFilters<String> get picture => $state.composableBuilder(
      column: $state.table.picture,
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

  ColumnFilters<String> get categoryIcon => $state.composableBuilder(
      column: $state.table.categoryIcon,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get categoryName => $state.composableBuilder(
      column: $state.table.categoryName,
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

  ColumnFilters<DateTime> get timestamp => $state.composableBuilder(
      column: $state.table.timestamp,
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

  ColumnOrderings<String> get picture => $state.composableBuilder(
      column: $state.table.picture,
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

  ColumnOrderings<String> get categoryIcon => $state.composableBuilder(
      column: $state.table.categoryIcon,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get categoryName => $state.composableBuilder(
      column: $state.table.categoryName,
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

  ColumnOrderings<DateTime> get timestamp => $state.composableBuilder(
      column: $state.table.timestamp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$LocationTBTableTableManager extends RootTableManager<
    _$DB,
    $LocationTBTable,
    Location,
    $$LocationTBTableFilterComposer,
    $$LocationTBTableOrderingComposer,
    $$LocationTBTableCreateCompanionBuilder,
    $$LocationTBTableUpdateCompanionBuilder,
    (Location, BaseReferences<_$DB, $LocationTBTable, Location>),
    Location,
    PrefetchHooks Function()> {
  $$LocationTBTableTableManager(_$DB db, $LocationTBTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LocationTBTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LocationTBTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> vicinity = const Value.absent(),
            Value<String> picture = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> rate = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String> categoryIcon = const Value.absent(),
            Value<String> categoryName = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              LocationTBCompanion(
            id: id,
            title: title,
            vicinity: vicinity,
            picture: picture,
            latitude: latitude,
            rate: rate,
            longitude: longitude,
            address: address,
            categoryIcon: categoryIcon,
            categoryName: categoryName,
            description: description,
            isFavorite: isFavorite,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            required String title,
            Value<String?> vicinity = const Value.absent(),
            required String picture,
            required double latitude,
            required double rate,
            required double longitude,
            Value<String?> address = const Value.absent(),
            required String categoryIcon,
            required String categoryName,
            Value<String?> description = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
          }) =>
              LocationTBCompanion.insert(
            id: id,
            title: title,
            vicinity: vicinity,
            picture: picture,
            latitude: latitude,
            rate: rate,
            longitude: longitude,
            address: address,
            categoryIcon: categoryIcon,
            categoryName: categoryName,
            description: description,
            isFavorite: isFavorite,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocationTBTableProcessedTableManager = ProcessedTableManager<
    _$DB,
    $LocationTBTable,
    Location,
    $$LocationTBTableFilterComposer,
    $$LocationTBTableOrderingComposer,
    $$LocationTBTableCreateCompanionBuilder,
    $$LocationTBTableUpdateCompanionBuilder,
    (Location, BaseReferences<_$DB, $LocationTBTable, Location>),
    Location,
    PrefetchHooks Function()>;
typedef $$MapSettingsTBTableCreateCompanionBuilder = MapSettingsTBCompanion
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

class $$MapSettingsTBTableTableManager extends RootTableManager<
    _$DB,
    $MapSettingsTBTable,
    MapSettings,
    $$MapSettingsTBTableFilterComposer,
    $$MapSettingsTBTableOrderingComposer,
    $$MapSettingsTBTableCreateCompanionBuilder,
    $$MapSettingsTBTableUpdateCompanionBuilder,
    (MapSettings, BaseReferences<_$DB, $MapSettingsTBTable, MapSettings>),
    MapSettings,
    PrefetchHooks Function()> {
  $$MapSettingsTBTableTableManager(_$DB db, $MapSettingsTBTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MapSettingsTBTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MapSettingsTBTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<MapLayer?> mapLayer = const Value.absent(),
            Value<MapStyle?> mapStyle = const Value.absent(),
          }) =>
              MapSettingsTBCompanion(
            id: id,
            mapLayer: mapLayer,
            mapStyle: mapStyle,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<MapLayer?> mapLayer = const Value.absent(),
            Value<MapStyle?> mapStyle = const Value.absent(),
          }) =>
              MapSettingsTBCompanion.insert(
            id: id,
            mapLayer: mapLayer,
            mapStyle: mapStyle,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MapSettingsTBTableProcessedTableManager = ProcessedTableManager<
    _$DB,
    $MapSettingsTBTable,
    MapSettings,
    $$MapSettingsTBTableFilterComposer,
    $$MapSettingsTBTableOrderingComposer,
    $$MapSettingsTBTableCreateCompanionBuilder,
    $$MapSettingsTBTableUpdateCompanionBuilder,
    (MapSettings, BaseReferences<_$DB, $MapSettingsTBTable, MapSettings>),
    MapSettings,
    PrefetchHooks Function()>;
typedef $$AppSettingsTBTableCreateCompanionBuilder = AppSettingsTBCompanion
    Function({
  Value<int> id,
  Value<String?> language,
  Value<int?> themeMode,
  Value<bool> autoLogin,
});
typedef $$AppSettingsTBTableUpdateCompanionBuilder = AppSettingsTBCompanion
    Function({
  Value<int> id,
  Value<String?> language,
  Value<int?> themeMode,
  Value<bool> autoLogin,
});

class $$AppSettingsTBTableFilterComposer
    extends FilterComposer<_$DB, $AppSettingsTBTable> {
  $$AppSettingsTBTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get themeMode => $state.composableBuilder(
      column: $state.table.themeMode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get autoLogin => $state.composableBuilder(
      column: $state.table.autoLogin,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AppSettingsTBTableOrderingComposer
    extends OrderingComposer<_$DB, $AppSettingsTBTable> {
  $$AppSettingsTBTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get themeMode => $state.composableBuilder(
      column: $state.table.themeMode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get autoLogin => $state.composableBuilder(
      column: $state.table.autoLogin,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$AppSettingsTBTableTableManager extends RootTableManager<
    _$DB,
    $AppSettingsTBTable,
    AppSettings,
    $$AppSettingsTBTableFilterComposer,
    $$AppSettingsTBTableOrderingComposer,
    $$AppSettingsTBTableCreateCompanionBuilder,
    $$AppSettingsTBTableUpdateCompanionBuilder,
    (AppSettings, BaseReferences<_$DB, $AppSettingsTBTable, AppSettings>),
    AppSettings,
    PrefetchHooks Function()> {
  $$AppSettingsTBTableTableManager(_$DB db, $AppSettingsTBTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AppSettingsTBTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AppSettingsTBTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> language = const Value.absent(),
            Value<int?> themeMode = const Value.absent(),
            Value<bool> autoLogin = const Value.absent(),
          }) =>
              AppSettingsTBCompanion(
            id: id,
            language: language,
            themeMode: themeMode,
            autoLogin: autoLogin,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> language = const Value.absent(),
            Value<int?> themeMode = const Value.absent(),
            Value<bool> autoLogin = const Value.absent(),
          }) =>
              AppSettingsTBCompanion.insert(
            id: id,
            language: language,
            themeMode: themeMode,
            autoLogin: autoLogin,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTBTableProcessedTableManager = ProcessedTableManager<
    _$DB,
    $AppSettingsTBTable,
    AppSettings,
    $$AppSettingsTBTableFilterComposer,
    $$AppSettingsTBTableOrderingComposer,
    $$AppSettingsTBTableCreateCompanionBuilder,
    $$AppSettingsTBTableUpdateCompanionBuilder,
    (AppSettings, BaseReferences<_$DB, $AppSettingsTBTable, AppSettings>),
    AppSettings,
    PrefetchHooks Function()>;
typedef $$CategoriesTBTableCreateCompanionBuilder = CategoriesTBCompanion
    Function({
  Value<int> id,
  Value<int> color,
  Value<String> name,
  Value<String> emoji,
});
typedef $$CategoriesTBTableUpdateCompanionBuilder = CategoriesTBCompanion
    Function({
  Value<int> id,
  Value<int> color,
  Value<String> name,
  Value<String> emoji,
});

class $$CategoriesTBTableFilterComposer
    extends FilterComposer<_$DB, $CategoriesTBTable> {
  $$CategoriesTBTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get emoji => $state.composableBuilder(
      column: $state.table.emoji,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CategoriesTBTableOrderingComposer
    extends OrderingComposer<_$DB, $CategoriesTBTable> {
  $$CategoriesTBTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get color => $state.composableBuilder(
      column: $state.table.color,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get emoji => $state.composableBuilder(
      column: $state.table.emoji,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$CategoriesTBTableTableManager extends RootTableManager<
    _$DB,
    $CategoriesTBTable,
    Categories,
    $$CategoriesTBTableFilterComposer,
    $$CategoriesTBTableOrderingComposer,
    $$CategoriesTBTableCreateCompanionBuilder,
    $$CategoriesTBTableUpdateCompanionBuilder,
    (Categories, BaseReferences<_$DB, $CategoriesTBTable, Categories>),
    Categories,
    PrefetchHooks Function()> {
  $$CategoriesTBTableTableManager(_$DB db, $CategoriesTBTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CategoriesTBTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CategoriesTBTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> emoji = const Value.absent(),
          }) =>
              CategoriesTBCompanion(
            id: id,
            color: color,
            name: name,
            emoji: emoji,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> emoji = const Value.absent(),
          }) =>
              CategoriesTBCompanion.insert(
            id: id,
            color: color,
            name: name,
            emoji: emoji,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTBTableProcessedTableManager = ProcessedTableManager<
    _$DB,
    $CategoriesTBTable,
    Categories,
    $$CategoriesTBTableFilterComposer,
    $$CategoriesTBTableOrderingComposer,
    $$CategoriesTBTableCreateCompanionBuilder,
    $$CategoriesTBTableUpdateCompanionBuilder,
    (Categories, BaseReferences<_$DB, $CategoriesTBTable, Categories>),
    Categories,
    PrefetchHooks Function()>;
typedef $$LoginRegisterTBTableCreateCompanionBuilder = LoginRegisterTBCompanion
    Function({
  Value<int> id,
  Value<String?> password,
});
typedef $$LoginRegisterTBTableUpdateCompanionBuilder = LoginRegisterTBCompanion
    Function({
  Value<int> id,
  Value<String?> password,
});

class $$LoginRegisterTBTableFilterComposer
    extends FilterComposer<_$DB, $LoginRegisterTBTable> {
  $$LoginRegisterTBTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LoginRegisterTBTableOrderingComposer
    extends OrderingComposer<_$DB, $LoginRegisterTBTable> {
  $$LoginRegisterTBTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get password => $state.composableBuilder(
      column: $state.table.password,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$LoginRegisterTBTableTableManager extends RootTableManager<
    _$DB,
    $LoginRegisterTBTable,
    LoginRegisterTBData,
    $$LoginRegisterTBTableFilterComposer,
    $$LoginRegisterTBTableOrderingComposer,
    $$LoginRegisterTBTableCreateCompanionBuilder,
    $$LoginRegisterTBTableUpdateCompanionBuilder,
    (
      LoginRegisterTBData,
      BaseReferences<_$DB, $LoginRegisterTBTable, LoginRegisterTBData>
    ),
    LoginRegisterTBData,
    PrefetchHooks Function()> {
  $$LoginRegisterTBTableTableManager(_$DB db, $LoginRegisterTBTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LoginRegisterTBTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$LoginRegisterTBTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> password = const Value.absent(),
          }) =>
              LoginRegisterTBCompanion(
            id: id,
            password: password,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> password = const Value.absent(),
          }) =>
              LoginRegisterTBCompanion.insert(
            id: id,
            password: password,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LoginRegisterTBTableProcessedTableManager = ProcessedTableManager<
    _$DB,
    $LoginRegisterTBTable,
    LoginRegisterTBData,
    $$LoginRegisterTBTableFilterComposer,
    $$LoginRegisterTBTableOrderingComposer,
    $$LoginRegisterTBTableCreateCompanionBuilder,
    $$LoginRegisterTBTableUpdateCompanionBuilder,
    (
      LoginRegisterTBData,
      BaseReferences<_$DB, $LoginRegisterTBTable, LoginRegisterTBData>
    ),
    LoginRegisterTBData,
    PrefetchHooks Function()>;

class $DBManager {
  final _$DB _db;
  $DBManager(this._db);
  $$LocationTBTableTableManager get locationTB =>
      $$LocationTBTableTableManager(_db, _db.locationTB);
  $$MapSettingsTBTableTableManager get mapSettingsTB =>
      $$MapSettingsTBTableTableManager(_db, _db.mapSettingsTB);
  $$AppSettingsTBTableTableManager get appSettingsTB =>
      $$AppSettingsTBTableTableManager(_db, _db.appSettingsTB);
  $$CategoriesTBTableTableManager get categoriesTB =>
      $$CategoriesTBTableTableManager(_db, _db.categoriesTB);
  $$LoginRegisterTBTableTableManager get loginRegisterTB =>
      $$LoginRegisterTBTableTableManager(_db, _db.loginRegisterTB);
}
