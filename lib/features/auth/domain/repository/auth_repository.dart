import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/features/auth/data/repository/auth_local_repository.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/auth_remote_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  // final internetStatus = ref.watch(connectivityStatusProvider);
  // if (ConnectivityStatus.isConnected == internetStatus) {
  //     // If internet is available then return remote repo
  //     return ref.watch(authRemoteRepositoryProvider);
  //   } else {
  //     // If internet is not available then return local repo
  //     return ref.watch(authLocalRepositoryProvider);
  //   }
  return ref.read(authRemoteRepositoryProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user);
  Future<Either<Failure, bool>> loginUser(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
Future<Either<Failure, AuthEntity>> fetchUserData(String? userId);
  Future<Either<Failure, AuthEntity?>> getUserData();

}
