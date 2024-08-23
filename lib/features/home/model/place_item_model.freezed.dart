// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlaceItemModel _$PlaceItemModelFromJson(Map<String, dynamic> json) {
  return _Place.fromJson(json);
}

/// @nodoc
mixin _$PlaceItemModel {
  String get title => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get distance => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String get categoryIcon => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  LatLong get latlng => throw _privateConstructorUsedError;
  String get picture => throw _privateConstructorUsedError;
  List<int>? get imageByte => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Serializes this PlaceItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaceItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaceItemModelCopyWith<PlaceItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceItemModelCopyWith<$Res> {
  factory $PlaceItemModelCopyWith(
          PlaceItemModel value, $Res Function(PlaceItemModel) then) =
      _$PlaceItemModelCopyWithImpl<$Res, PlaceItemModel>;
  @useResult
  $Res call(
      {String title,
      String address,
      String description,
      String distance,
      String date,
      int? id,
      String categoryIcon,
      String categoryName,
      LatLong latlng,
      String picture,
      List<int>? imageByte,
      double rate,
      bool isFavorite});

  $LatLongCopyWith<$Res> get latlng;
}

/// @nodoc
class _$PlaceItemModelCopyWithImpl<$Res, $Val extends PlaceItemModel>
    implements $PlaceItemModelCopyWith<$Res> {
  _$PlaceItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaceItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? address = null,
    Object? description = null,
    Object? distance = null,
    Object? date = null,
    Object? id = freezed,
    Object? categoryIcon = null,
    Object? categoryName = null,
    Object? latlng = null,
    Object? picture = null,
    Object? imageByte = freezed,
    Object? rate = null,
    Object? isFavorite = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryIcon: null == categoryIcon
          ? _value.categoryIcon
          : categoryIcon // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      latlng: null == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as LatLong,
      picture: null == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String,
      imageByte: freezed == imageByte
          ? _value.imageByte
          : imageByte // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of PlaceItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LatLongCopyWith<$Res> get latlng {
    return $LatLongCopyWith<$Res>(_value.latlng, (value) {
      return _then(_value.copyWith(latlng: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlaceImplCopyWith<$Res>
    implements $PlaceItemModelCopyWith<$Res> {
  factory _$$PlaceImplCopyWith(
          _$PlaceImpl value, $Res Function(_$PlaceImpl) then) =
      __$$PlaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String address,
      String description,
      String distance,
      String date,
      int? id,
      String categoryIcon,
      String categoryName,
      LatLong latlng,
      String picture,
      List<int>? imageByte,
      double rate,
      bool isFavorite});

  @override
  $LatLongCopyWith<$Res> get latlng;
}

/// @nodoc
class __$$PlaceImplCopyWithImpl<$Res>
    extends _$PlaceItemModelCopyWithImpl<$Res, _$PlaceImpl>
    implements _$$PlaceImplCopyWith<$Res> {
  __$$PlaceImplCopyWithImpl(
      _$PlaceImpl _value, $Res Function(_$PlaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlaceItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? address = null,
    Object? description = null,
    Object? distance = null,
    Object? date = null,
    Object? id = freezed,
    Object? categoryIcon = null,
    Object? categoryName = null,
    Object? latlng = null,
    Object? picture = null,
    Object? imageByte = freezed,
    Object? rate = null,
    Object? isFavorite = null,
  }) {
    return _then(_$PlaceImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      categoryIcon: null == categoryIcon
          ? _value.categoryIcon
          : categoryIcon // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      latlng: null == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as LatLong,
      picture: null == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String,
      imageByte: freezed == imageByte
          ? _value._imageByte
          : imageByte // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaceImpl implements _Place {
  const _$PlaceImpl(
      {required this.title,
      required this.address,
      this.description = "",
      this.distance = "",
      this.date = "",
      this.id,
      required this.categoryIcon,
      required this.categoryName,
      required this.latlng,
      required this.picture,
      final List<int>? imageByte,
      this.rate = 0,
      this.isFavorite = false})
      : _imageByte = imageByte;

  factory _$PlaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceImplFromJson(json);

  @override
  final String title;
  @override
  final String address;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String distance;
  @override
  @JsonKey()
  final String date;
  @override
  final int? id;
  @override
  final String categoryIcon;
  @override
  final String categoryName;
  @override
  final LatLong latlng;
  @override
  final String picture;
  final List<int>? _imageByte;
  @override
  List<int>? get imageByte {
    final value = _imageByte;
    if (value == null) return null;
    if (_imageByte is EqualUnmodifiableListView) return _imageByte;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final double rate;
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'PlaceItemModel(title: $title, address: $address, description: $description, distance: $distance, date: $date, id: $id, categoryIcon: $categoryIcon, categoryName: $categoryName, latlng: $latlng, picture: $picture, imageByte: $imageByte, rate: $rate, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaceImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryIcon, categoryIcon) ||
                other.categoryIcon == categoryIcon) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.latlng, latlng) || other.latlng == latlng) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            const DeepCollectionEquality()
                .equals(other._imageByte, _imageByte) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      address,
      description,
      distance,
      date,
      id,
      categoryIcon,
      categoryName,
      latlng,
      picture,
      const DeepCollectionEquality().hash(_imageByte),
      rate,
      isFavorite);

  /// Create a copy of PlaceItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceImplCopyWith<_$PlaceImpl> get copyWith =>
      __$$PlaceImplCopyWithImpl<_$PlaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceImplToJson(
      this,
    );
  }
}

abstract class _Place implements PlaceItemModel {
  const factory _Place(
      {required final String title,
      required final String address,
      final String description,
      final String distance,
      final String date,
      final int? id,
      required final String categoryIcon,
      required final String categoryName,
      required final LatLong latlng,
      required final String picture,
      final List<int>? imageByte,
      final double rate,
      final bool isFavorite}) = _$PlaceImpl;

  factory _Place.fromJson(Map<String, dynamic> json) = _$PlaceImpl.fromJson;

  @override
  String get title;
  @override
  String get address;
  @override
  String get description;
  @override
  String get distance;
  @override
  String get date;
  @override
  int? get id;
  @override
  String get categoryIcon;
  @override
  String get categoryName;
  @override
  LatLong get latlng;
  @override
  String get picture;
  @override
  List<int>? get imageByte;
  @override
  double get rate;
  @override
  bool get isFavorite;

  /// Create a copy of PlaceItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaceImplCopyWith<_$PlaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LatLong _$LatLongFromJson(Map<String, dynamic> json) {
  return _LatLong.fromJson(json);
}

/// @nodoc
mixin _$LatLong {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Serializes this LatLong to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LatLong
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LatLongCopyWith<LatLong> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatLongCopyWith<$Res> {
  factory $LatLongCopyWith(LatLong value, $Res Function(LatLong) then) =
      _$LatLongCopyWithImpl<$Res, LatLong>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$LatLongCopyWithImpl<$Res, $Val extends LatLong>
    implements $LatLongCopyWith<$Res> {
  _$LatLongCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LatLong
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LatLongImplCopyWith<$Res> implements $LatLongCopyWith<$Res> {
  factory _$$LatLongImplCopyWith(
          _$LatLongImpl value, $Res Function(_$LatLongImpl) then) =
      __$$LatLongImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$LatLongImplCopyWithImpl<$Res>
    extends _$LatLongCopyWithImpl<$Res, _$LatLongImpl>
    implements _$$LatLongImplCopyWith<$Res> {
  __$$LatLongImplCopyWithImpl(
      _$LatLongImpl _value, $Res Function(_$LatLongImpl) _then)
      : super(_value, _then);

  /// Create a copy of LatLong
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$LatLongImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LatLongImpl implements _LatLong {
  const _$LatLongImpl({required this.latitude, required this.longitude});

  factory _$LatLongImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatLongImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'LatLong(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatLongImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of LatLong
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LatLongImplCopyWith<_$LatLongImpl> get copyWith =>
      __$$LatLongImplCopyWithImpl<_$LatLongImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LatLongImplToJson(
      this,
    );
  }
}

abstract class _LatLong implements LatLong {
  const factory _LatLong(
      {required final double latitude,
      required final double longitude}) = _$LatLongImpl;

  factory _LatLong.fromJson(Map<String, dynamic> json) = _$LatLongImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of LatLong
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LatLongImplCopyWith<_$LatLongImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
