import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';
import '../model/auth_hive_model.dart';

final authLocalDataSourseProvider = Provider(
  (ref) => AuthLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(authHiveModelProvider),
  ),
);

class AuthLocalDataSource {
  final HiveService _hiveService;
  final AuthHiveModel _authHiveModel;
  AuthLocalDataSource(this._hiveService, this._authHiveModel);

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      await _hiveService.addUser(_authHiveModel.toHiveModel(user));
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String username,
    String password,
  ) async {
    try {
      AuthHiveModel? users = await _hiveService.login(username, password);
      if (users == null) {
        return Left(Failure(error: 'Username or password is wrong'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
