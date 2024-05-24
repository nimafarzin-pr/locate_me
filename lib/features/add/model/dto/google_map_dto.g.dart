// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_map_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoogleMapDtoImpl _$$GoogleMapDtoImplFromJson(Map<String, dynamic> json) =>
    _$GoogleMapDtoImpl(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      placeMark: json['placeMark'] as String?,
      customIcon: json['customIcon'] as String,
    );

Map<String, dynamic> _$$GoogleMapDtoImplToJson(_$GoogleMapDtoImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'placeMark': instance.placeMark,
      'customIcon': instance.customIcon,
    };
