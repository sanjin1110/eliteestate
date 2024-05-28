import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>((ref) {
  return AuthApiModel(
    email: '',
    username: '',
    password: '',
  );
});

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? id;
  
  final String? image;
  final String username;
  final String email;
  final String password;

  AuthApiModel({
    this.id,
    
    this.image,
    required this.email,
    required this.username,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // convert AuthApiModel to AuthEntity
  AuthEntity toEntity(List<AuthApiModel> data) => AuthEntity(
        id: id ?? '',
        image: image ?? '',
        email: email,
        username: username,
        password: password,
      );

  // Convert Entity to API Object
  AuthApiModel fromEntity(AuthEntity entity) => AuthApiModel(
        id: entity.id ?? '',
       
        email: entity.email,
        image: entity.image ?? '',
         username: entity.username,
        password: entity.password
      );



  @override
  String toString() {
    return 'AuthApiModel(id: $id,  image: $image, email: $email, username: $username, password: $password)';
  }
}
