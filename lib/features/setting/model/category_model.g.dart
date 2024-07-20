// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      name: json['name'] as String? ?? "",
      iconString: json['iconString'] as String? ?? "",
      color: (json['color'] as num?)?.toInt() ?? 0,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'iconString': instance.iconString,
      'color': instance.color,
      'id': instance.id,
    };
