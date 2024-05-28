import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/property/data/data_source/property_remote_data_source.dart';
import 'package:real_estate_app/features/property/data/model/property_api_model.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';
import 'package:real_estate_app/features/property/domain/repository/property_repository.dart';

final propertyRemoteRepositoryProvider = Provider<IPropertyRepository>(
  (ref) => PropertyRemoteRepositoryImpl(
    propertyRemoteDataSource: ref.read(propertyRemoteDataSourceProvider),
  ),
);

class PropertyRemoteRepositoryImpl implements IPropertyRepository {
  final PropertyRemoteDataSource propertyRemoteDataSource;
  PropertyRemoteRepositoryImpl({required this.propertyRemoteDataSource});

  @override
  Future<Either<Failure, List<PropertyEntity>>> getAllProperty() {
    return propertyRemoteDataSource.getAllProperty();
  }

  @override
  Future<Either<Failure, bool>> addProperty(PropertyEntity property) {
    return propertyRemoteDataSource.addProperty(property);
  }

  @override
  Future<PropertyApiModel?> fetchPropertyById(String propertyId) {
    return propertyRemoteDataSource.fetchPropertyById(propertyId);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return propertyRemoteDataSource.uploadProfilePicture(file);

  }
}
