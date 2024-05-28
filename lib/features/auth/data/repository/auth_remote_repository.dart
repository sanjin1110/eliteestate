import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/auth_entity.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  );
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String username, String password) {
    return _authRemoteDataSource.loginUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return _authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return _authRemoteDataSource.uploadProfilePicture(file);
  }
  
  @override
  Future<Either<Failure, AuthEntity>> fetchUserData(String? userId) {
        return _authRemoteDataSource.fetchUserData(userId);

    
  }
   @override
  Future<Either<Failure, AuthEntity?>> getUserData() {
    return _authRemoteDataSource.getUserDetails();
  }
}
