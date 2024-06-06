// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceImpl _$$PlaceImplFromJson(Map<String, dynamic> json) => _$PlaceImpl(
      title: json['title'] as String,
      address: json['address'] as String,
      description: json['description'] as String? ?? "",
      distance: json['distance'] as String? ?? "",
      date: json['date'] as String? ?? "",
      id: (json['id'] as num?)?.toInt(),
      category: json['category'] as String,
      latlng: LatLong.fromJson(json['latlng'] as Map<String, dynamic>),
      icon: json['icon'] as String,
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$PlaceImplToJson(_$PlaceImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'address': instance.address,
      'description': instance.description,
      'distance': instance.distance,
      'date': instance.date,
      'id': instance.id,
      'category': instance.category,
      'latlng': instance.latlng,
      'icon': instance.icon,
      'rate': instance.rate,
      'isFavorite': instance.isFavorite,
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
