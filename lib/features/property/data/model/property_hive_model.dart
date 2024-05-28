import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:real_estate_app/config/constants/hive_table_constant.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';
import 'package:uuid/uuid.dart';

part 'property_hive_model.g.dart';

final propertyHiveModelProvider = Provider(
  (ref) => PropertyHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.propertyTableId)
class PropertyHiveModel {
  @HiveField(0)
  final String propertyId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String desc;

  @HiveField(4)
  final String? img;

  @HiveField(5)
  final String? price;

  @HiveField(6)
  final String sqmeters;

  @HiveField(7)
  final String continent;

  @HiveField(8)
  final String beds;

  PropertyHiveModel({
    String? propertyId,
    // required this.currentOwner,
    required this.title,
    required this.type,
    required this.desc,
    this.img,
    this.price,
    required this.sqmeters,
    required this.continent,
    required this.beds,
  }) : propertyId = propertyId ?? const Uuid().v4();

  PropertyHiveModel.empty()
      : this(
            propertyId: '',
            title: '',
            type: '',
            desc: '',
            img: '',
            price: '',
            sqmeters: '',
            continent: '',
            beds: '');

  PropertyEntity toEntity() => PropertyEntity(
        id: propertyId,
        // currentOwner: currentOwner,
        title: title,
        type: type,
        desc: desc,
        price: price,
        sqmeters: sqmeters,
        continent: continent,
        beds: beds,
      );

  PropertyHiveModel toHiveModel(PropertyEntity entity) => PropertyHiveModel(
        propertyId: const Uuid().v4(),
        // currentOwner: entity.currentOwner,
        title: entity.title,
        type: entity.type,
        desc: entity.desc,
        img: entity.img,
        price: entity.price,
        sqmeters: entity.sqmeters,
        continent: entity.continent,
        beds: entity.beds,
      );

  List<PropertyEntity> toEntityList(List<PropertyHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'propertyId :$propertyId,  title:$title, type:$type';
  }
}
