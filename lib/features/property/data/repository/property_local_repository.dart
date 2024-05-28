import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/property/data/data_source/property_local_data_source.dart';
import 'package:real_estate_app/features/property/data/model/property_api_model.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';
import 'package:real_estate_app/features/property/domain/repository/property_repository.dart';

final propertyLocalRepositoryProvider = Provider<IPropertyRepository>((ref) {
  return PropertyLocalRepository(
    ref.read(propertyLocalDataSourceProvider),
  );
});

class PropertyLocalRepository implements IPropertyRepository {
  final PropertyLocalDataSource _propertyLocalDataSource;
  PropertyLocalRepository(this._propertyLocalDataSource);
  @override
  Future<Either<Failure, List<PropertyEntity>>> getAllProperty() {
    return _propertyLocalDataSource.getAllProperty();
  }
  
  @override
  Future<Either<Failure, bool>> addProperty(property) {
    // TODO: implement addProperty
    throw UnimplementedError();
  }

  @override
  Future<PropertyApiModel?> fetchPropertyById(String propertyId) {
    // TODO: implement fetchPropertyById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
