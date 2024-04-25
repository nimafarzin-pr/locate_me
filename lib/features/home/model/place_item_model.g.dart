// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceImpl _$$PlaceImplFromJson(Map<String, dynamic> json) => _$PlaceImpl(
      title: json['title'] as String,
      address: json['address'] as String,
      distance: json['distance'] as String,
      date: json['date'] as String,
      latlng: LatLong.fromJson(json['latlng'] as Map<String, dynamic>),
      icon: json['icon'] as String,
      rate: (json['rate'] as num).toDouble(),
      isSaved: json['isSaved'] as bool,
    );

Map<String, dynamic> _$$PlaceImplToJson(_$PlaceImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'address': instance.address,
      'distance': instance.distance,
      'date': instance.date,
      'latlng': instance.latlng,
      'icon': instance.icon,
      'rate': instance.rate,
      'isSaved': instance.isSaved,
    };

_$LatLongImpl _$$LatLongImplFromJson(Map<String, dynamic> json) =>
    _$LatLongImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$LatLongImplToJson(_$LatLongImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
