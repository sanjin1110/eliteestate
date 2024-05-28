import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/core/network/local/hive_service.dart';
import 'package:real_estate_app/features/property/data/model/property_hive_model.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';

final propertyLocalDataSourceProvider = Provider(
  (ref) => PropertyLocalDataSource(
    hiveService: ref.read(hiveServiceProvider),
    propertyHiveModel: ref.read(propertyHiveModelProvider),
  ),
);

class PropertyLocalDataSource {
  final HiveService hiveService;
  final PropertyHiveModel propertyHiveModel;

  PropertyLocalDataSource({
    required this.hiveService,
    required this.propertyHiveModel,
  });

  Future<Either<Failure, List<PropertyEntity>>> getAllProperty() async {
    try {
      final property = await hiveService.getAllProperty();
      final propertyEntity = propertyHiveModel.toEntityList(property);
      return Right(propertyEntity);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
