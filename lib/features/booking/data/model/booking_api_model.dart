import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:real_estate_app/features/booking/domain/entity/booking_entity.dart';

part 'booking_api_model.g.dart';

final bookingApiModelProvider = Provider((ref) {
  return BookingApiModel(
    user: '',
    property: '',
    checkIn: '',
    totalPrice: '',
    status: '',
  );
});

@JsonSerializable()
class BookingApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? user;
  final String property;
  final String checkIn;
  final String totalPrice;
  final String status;

  BookingApiModel({
    this.id,
    this.user,
    required this.property,
    required this.checkIn,
    required this.totalPrice,
    required this.status,
  });

  factory BookingApiModel.fromJson(Map<dynamic, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$BookingApiModelToJson(this);
  BookingEntity toEntity() => BookingEntity(
      id: id,
      user: user,
      property: property,
      checkIn: checkIn,
      totalPrice: totalPrice,
      status: status);
}
