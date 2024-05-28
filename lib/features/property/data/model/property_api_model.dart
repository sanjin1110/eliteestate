import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/property_entity.dart';

// dart run build_runner build --delete-conflicting-outputs

part 'property_api_model.g.dart';

final propertyApiModelProvider = Provider((ref) {
  return PropertyApiModel(
    title: '',
    type: '',
    desc: '',
    img: '',
    price: '',
    sqmeters: '',
    continent: '',
    beds: '',
  );
});

@JsonSerializable()
class PropertyApiModel {
  @JsonKey(name: '_id')
  final String? propertyId;
  // final  Map<String, dynamic> currentOwner;
  final String title;
  final String type;
  final String desc;
  final String? img;
  final String price;
  final String sqmeters;
  final String continent;
  final String beds;

  PropertyApiModel({
    this.propertyId,
    // required this.currentOwner,
    required this.title,
    required this.type,
    required this.desc,
    this.img,
    required this.price,
    required this.sqmeters,
    required this.continent,
    required this.beds,
  });
  factory PropertyApiModel.fromJson(Map<dynamic, dynamic> json) =>
      _$PropertyApiModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$PropertyApiModelToJson(this);

  PropertyEntity toEntity() => PropertyEntity(
        id: propertyId,
        // currentOwner: currentOwner,
        title: title,
        type: type,
        desc: desc,
        img: img,
        price: price,
        sqmeters: sqmeters,
        continent: continent,
        beds: beds,
      );
}
