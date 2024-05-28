import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repository/auth_repository.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(
    ref.read(authRepositoryProvider),
  );
});
class AuthUseCase {
  final IAuthRepository _authRepository;
  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    return await _authRepository.registerUser(user);
  }

  Future<Either<Failure, bool>> loginUser(
    String username, String password) async {
    return await _authRepository.loginUser(username, password);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await _authRepository.uploadProfilePicture(file);
  }
  Future<Either<Failure, AuthEntity>> fetchUserData(String? userId) {
    return _authRepository.fetchUserData(userId);
  }
  Future<Either<Failure, AuthEntity?>> getUserData() async {
    return await _authRepository.getUserData();
  }
}