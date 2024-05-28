import 'package:json_annotation/json_annotation.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';

part 'get_user_dto.g.dart';

@JsonSerializable()
class GetUserDTO {
  final bool? success;
  final String? message;
  final AuthEntity? data;

  GetUserDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetUserDTOToJson(this);

  factory GetUserDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserDTOFromJson(json);
}


