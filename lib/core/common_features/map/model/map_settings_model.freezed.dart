// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MapSettingsModel _$MapSettingsModelFromJson(Map<String, dynamic> json) {
  return _MapSettingsModel.fromJson(json);
}

/// @nodoc
mixin _$MapSettingsModel {
  MapLayer? get mapLayer => throw _privateConstructorUsedError;
  MapStyle? get mapStyle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MapSettingsModelCopyWith<MapSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapSettingsModelCopyWith<$Res> {
  factory $MapSettingsModelCopyWith(
          MapSettingsModel value, $Res Function(MapSettingsModel) then) =
      _$MapSettingsModelCopyWithImpl<$Res, MapSettingsModel>;
  @useResult
  $Res call({MapLayer? mapLayer, MapStyle? mapStyle});
}

/// @nodoc
class _$MapSettingsModelCopyWithImpl<$Res, $Val extends MapSettingsModel>
    implements $MapSettingsModelCopyWith<$Res> {
  _$MapSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapLayer = freezed,
    Object? mapStyle = freezed,
  }) {
    return _then(_value.copyWith(
      mapLayer: freezed == mapLayer
          ? _value.mapLayer
          : mapLayer // ignore: cast_nullable_to_non_nullable
              as MapLayer?,
      mapStyle: freezed == mapStyle
          ? _value.mapStyle
          : mapStyle // ignore: cast_nullable_to_non_nullable
              as MapStyle?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapSettingsModelImplCopyWith<$Res>
    implements $MapSettingsModelCopyWith<$Res> {
  factory _$$MapSettingsModelImplCopyWith(_$MapSettingsModelImpl value,
          $Res Function(_$MapSettingsModelImpl) then) =
      __$$MapSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MapLayer? mapLayer, MapStyle? mapStyle});
}

/// @nodoc
class __$$MapSettingsModelImplCopyWithImpl<$Res>
    extends _$MapSettingsModelCopyWithImpl<$Res, _$MapSettingsModelImpl>
    implements _$$MapSettingsModelImplCopyWith<$Res> {
  __$$MapSettingsModelImplCopyWithImpl(_$MapSettingsModelImpl _value,
      $Res Function(_$MapSettingsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapLayer = freezed,
    Object? mapStyle = freezed,
  }) {
    return _then(_$MapSettingsModelImpl(
      mapLayer: freezed == mapLayer
          ? _value.mapLayer
          : mapLayer // ignore: cast_nullable_to_non_nullable
              as MapLayer?,
      mapStyle: freezed == mapStyle
          ? _value.mapStyle
          : mapStyle // ignore: cast_nullable_to_non_nullable
              as MapStyle?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MapSettingsModelImpl implements _MapSettingsModel {
  const _$MapSettingsModelImpl({this.mapLayer, this.mapStyle});

  factory _$MapSettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MapSettingsModelImplFromJson(json);

  @override
  final MapLayer? mapLayer;
  @override
  final MapStyle? mapStyle;

  @override
  String toString() {
    return 'MapSettingsModel(mapLayer: $mapLayer, mapStyle: $mapStyle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapSettingsModelImpl &&
            (identical(other.mapLayer, mapLayer) ||
                other.mapLayer == mapLayer) &&
            (identical(other.mapStyle, mapStyle) ||
                other.mapStyle == mapStyle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, mapLayer, mapStyle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MapSettingsModelImplCopyWith<_$MapSettingsModelImpl> get copyWith =>
      __$$MapSettingsModelImplCopyWithImpl<_$MapSettingsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MapSettingsModelImplToJson(
      this,
    );
  }
}

abstract class _MapSettingsModel implements MapSettingsModel {
  const factory _MapSettingsModel(
      {final MapLayer? mapLayer,
      final MapStyle? mapStyle}) = _$MapSettingsModelImpl;

  factory _MapSettingsModel.fromJson(Map<String, dynamic> json) =
      _$MapSettingsModelImpl.fromJson;

  @override
  MapLayer? get mapLayer;
  @override
  MapStyle? get mapStyle;
  @override
  @JsonKey(ignore: true)
  _$$MapSettingsModelImplCopyWith<_$MapSettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
