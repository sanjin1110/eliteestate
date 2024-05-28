import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/property/data/model/property_api_model.dart';
import 'package:real_estate_app/features/property/data/repository/property_local_repository.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../data/repository/property_remote_repository.dart';

final propertyRepositoryProvider = Provider<IPropertyRepository>((ref) {
  // // Check for the internet
  final internetStatus = ref.watch(connectivityStatusProvider);
  return ref.watch(propertyRemoteRepositoryProvider);

  // if (ConnectivityStatus.isConnected == internetStatus) {
  //   // If internet is available then return remote repo
  //   return ref.watch(propertyRemoteRepositoryProvider);
  // } else {
  //   return ref.watch(propertyLocalRepositoryProvider);
  // }
});

abstract class IPropertyRepository {
  Future<Either<Failure, List<PropertyEntity>>> getAllProperty();
  Future<Either<Failure, bool>> addProperty(PropertyEntity property);
  Future<PropertyApiModel?> fetchPropertyById(String propertyId);
  Future<Either<Failure, String>> uploadProfilePicture(File file);

}
