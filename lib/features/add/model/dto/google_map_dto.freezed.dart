// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_map_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GoogleMapDto _$GoogleMapDtoFromJson(Map<String, dynamic> json) {
  return _GoogleMapDto.fromJson(json);
}

/// @nodoc
mixin _$GoogleMapDto {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String? get placeMark => throw _privateConstructorUsedError;
  String get customIcon => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoogleMapDtoCopyWith<GoogleMapDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleMapDtoCopyWith<$Res> {
  factory $GoogleMapDtoCopyWith(
          GoogleMapDto value, $Res Function(GoogleMapDto) then) =
      _$GoogleMapDtoCopyWithImpl<$Res, GoogleMapDto>;
  @useResult
  $Res call({double lat, double lng, String? placeMark, String customIcon});
}

/// @nodoc
class _$GoogleMapDtoCopyWithImpl<$Res, $Val extends GoogleMapDto>
    implements $GoogleMapDtoCopyWith<$Res> {
  _$GoogleMapDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? placeMark = freezed,
    Object? customIcon = null,
  }) {
    return _then(_value.copyWith(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      placeMark: freezed == placeMark
          ? _value.placeMark
          : placeMark // ignore: cast_nullable_to_non_nullable
              as String?,
      customIcon: null == customIcon
          ? _value.customIcon
          : customIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoogleMapDtoImplCopyWith<$Res>
    implements $GoogleMapDtoCopyWith<$Res> {
  factory _$$GoogleMapDtoImplCopyWith(
          _$GoogleMapDtoImpl value, $Res Function(_$GoogleMapDtoImpl) then) =
      __$$GoogleMapDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng, String? placeMark, String customIcon});
}

/// @nodoc
class __$$GoogleMapDtoImplCopyWithImpl<$Res>
    extends _$GoogleMapDtoCopyWithImpl<$Res, _$GoogleMapDtoImpl>
    implements _$$GoogleMapDtoImplCopyWith<$Res> {
  __$$GoogleMapDtoImplCopyWithImpl(
      _$GoogleMapDtoImpl _value, $Res Function(_$GoogleMapDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = null,
    Object? lng = null,
    Object? placeMark = freezed,
    Object? customIcon = null,
  }) {
    return _then(_$GoogleMapDtoImpl(
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      placeMark: freezed == placeMark
          ? _value.placeMark
          : placeMark // ignore: cast_nullable_to_non_nullable
              as String?,
      customIcon: null == customIcon
          ? _value.customIcon
          : customIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoogleMapDtoImpl implements _GoogleMapDto {
  _$GoogleMapDtoImpl(
      {required this.lat,
      required this.lng,
      this.placeMark,
      required this.customIcon});

  factory _$GoogleMapDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoogleMapDtoImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;
  @override
  final String? placeMark;
  @override
  final String customIcon;

  @override
  String toString() {
    return 'GoogleMapDto(lat: $lat, lng: $lng, placeMark: $placeMark, customIcon: $customIcon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleMapDtoImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.placeMark, placeMark) ||
                other.placeMark == placeMark) &&
            (identical(other.customIcon, customIcon) ||
                other.customIcon == customIcon));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng, placeMark, customIcon);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoogleMapDtoImplCopyWith<_$GoogleMapDtoImpl> get copyWith =>
      __$$GoogleMapDtoImplCopyWithImpl<_$GoogleMapDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoogleMapDtoImplToJson(
      this,
    );
  }
}

abstract class _GoogleMapDto implements GoogleMapDto {
  factory _GoogleMapDto(
      {required final double lat,
      required final double lng,
      final String? placeMark,
      required final String customIcon}) = _$GoogleMapDtoImpl;

  factory _GoogleMapDto.fromJson(Map<String, dynamic> json) =
      _$GoogleMapDtoImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;
  @override
  String? get placeMark;
  @override
  String get customIcon;
  @override
  @JsonKey(ignore: true)
  _$$GoogleMapDtoImplCopyWith<_$GoogleMapDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
