import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';
import 'package:real_estate_app/features/property/domain/repository/property_repository.dart';

final propertyUseCaseProvider = Provider<PropertyUseCase>(
  (ref) => PropertyUseCase(
    propertyRepository: ref.watch(propertyRepositoryProvider),
  ),
);

class PropertyUseCase {
  final IPropertyRepository propertyRepository;
  PropertyUseCase({required this.propertyRepository});

  Future<Either<Failure, List<PropertyEntity>>>  getAllProperty() async {
    return await propertyRepository.getAllProperty();
  }

  Future<Either<Failure, bool>> addProperty(PropertyEntity property) async{
    return await propertyRepository.addProperty(property);
  }
   Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await propertyRepository.uploadProfilePicture(file);
  }
}
