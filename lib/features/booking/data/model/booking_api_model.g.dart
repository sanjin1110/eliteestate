// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<dynamic, dynamic> json) =>
    BookingApiModel(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      property: json['property'] as String,
      checkIn: json['checkIn'] as String,
      totalPrice: '${json['totalPrice']}',
      status: json['status'] as String,
    );

Map<dynamic, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <dynamic, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'property': instance.property,
      'checkIn': instance.checkIn,
      'totalPrice': instance.totalPrice,
      'status': instance.status,
    };
