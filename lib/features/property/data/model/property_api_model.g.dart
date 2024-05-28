// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyApiModel _$PropertyApiModelFromJson(Map<dynamic, dynamic> json) =>
    PropertyApiModel(
      propertyId: json['_id'] as String?,
      title: json['title'] as String,
      type: json['type'] as String,
      desc: json['desc'] as String,
      img: json['img'] as String?,
      price: '${json['price']}',
      sqmeters: '${json['sqmeters']}',
      continent: json['continent'] as String,
      beds: '${json['beds']}',
    );

Map<dynamic, dynamic> _$PropertyApiModelToJson(PropertyApiModel instance) =>
    <dynamic, dynamic>{
      '_id': instance.propertyId,
      'title': instance.title,
      'type': instance.type,
      'desc': instance.desc,
      'img': instance.img,
      'price': instance.price,
      'sqmeters': instance.sqmeters,
      'continent': instance.continent,
      'beds': instance.beds,
    };



