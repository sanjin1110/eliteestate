import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:real_estate_app/config/constants/hive_table_constant.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);
@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.email,
    required this.username,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  //empty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          email: '',
          username: '',
          password: '',
        );

  //Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        username: username,
        email: email,
        password: password,
      );

  //Convert entity to hive object

  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        email: entity.email,
        username: entity.username,
        password: entity.password,
      );

      
  //convert entity list to hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

 @override
  String toString() {
    return 'userId: $userId, email: $email, username: $username, password: $password';
  }

}
