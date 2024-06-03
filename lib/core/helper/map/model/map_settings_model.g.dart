// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapSettingsModelImpl _$$MapSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MapSettingsModelImpl(
      mapLayer: $enumDecodeNullable(_$MapLayerEnumMap, json['mapLayer']),
      mapStyle: $enumDecodeNullable(_$MapStyleEnumMap, json['mapStyle']),
    );

Map<String, dynamic> _$$MapSettingsModelImplToJson(
        _$MapSettingsModelImpl instance) =>
    <String, dynamic>{
      'mapLayer': _$MapLayerEnumMap[instance.mapLayer],
      'mapStyle': _$MapStyleEnumMap[instance.mapStyle],
    };

const _$MapLayerEnumMap = {
  MapLayer.google: 'google',
  MapLayer.osm: 'osm',
};

const _$MapStyleEnumMap = {
  MapStyle.standard: 'standard',
  MapStyle.dark: 'dark',
  MapStyle.silver: 'silver',
};
