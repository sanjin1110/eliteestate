import 'package:equatable/equatable.dart';

class PropertyEntity extends Equatable {
  final String? id;
  // final  Map<String, dynamic> currentOwner;
  final String title;
  final String type;
  final String desc;
  final String? img;
  final String? price;
  final String sqmeters;
  final String continent;
  final String beds;

  const PropertyEntity({
    this.id,
    // required this.currentOwner,
    required this.title,
    required this.type,
    required this.desc,
    this.img,
    this.price,
    required this.sqmeters,
    required this.continent,
    required this.beds,
  });
  factory PropertyEntity.fromJson(Map<dynamic, dynamic> json) => PropertyEntity(
        id: json["id"] as String?,
        // currentOwner: json["currentOwner"] as  Map<String, dynamic>,
        title: json["title"] as String,
        type: json["type"] as String,
        desc: json["desc"] as String,
        img: json["img"] as String?,
        price: json["price"] as String?,
        sqmeters: json["sqmeters"] as String,
        continent: json["continent"] as String,
        beds: json["beds"] as String,
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        // "currentOwner": currentOwner,
        "title": title,
        "type": type,
        "desc": desc,
        "img": img,
        "price": price,
        "sqmeters": sqmeters,
        "continent": continent,
        "beds": beds,
      };
  @override
  List<Object?> get props => [
        id,
        title,
        type,
        desc,
        img,
        price,
        sqmeters,
        continent,
        beds,
      ];
}
