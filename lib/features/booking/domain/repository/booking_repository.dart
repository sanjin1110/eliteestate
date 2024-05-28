import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/booking/data/repository/booking_remote_repository.dart';
import 'package:real_estate_app/features/booking/domain/entity/booking_entity.dart';
import 'package:real_estate_app/features/property/data/model/property_api_model.dart';

import '../../../../core/common/provider/internet_connectivity.dart';

final bookingRepositoryProvider = Provider<IBookingRepository>((ref) {
  // // Check for the internet
  final internetStatus = ref.watch(connectivityStatusProvider);
  return ref.watch(bookingRemoteRepositoryProvider);

  // if (ConnectivityStatus.isConnected == internetStatus) {
  //   // If internet is available then return remote repo
  //   return ref.watch(propertyRemoteRepositoryProvider);
  // } else {
  //   return ref.watch(propertyLocalRepositoryProvider);
  // }
});

abstract class IBookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getAllBookings();
  Future<PropertyApiModel?> fetchPropertyById(String propertyId);
   Future<Result<void>>  bookProperty(String propertyId, String userId);

  // Future addProperty(PropertyEntity property);
}
