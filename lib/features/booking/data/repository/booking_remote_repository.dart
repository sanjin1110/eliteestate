import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/booking/data/data_source/booking_remote_data_source.dart';
import 'package:real_estate_app/features/booking/domain/entity/booking_entity.dart';
import 'package:real_estate_app/features/booking/domain/repository/booking_repository.dart';
import 'package:real_estate_app/features/property/data/data_source/property_remote_data_source.dart';
import 'package:real_estate_app/features/property/data/model/property_api_model.dart';

final bookingRemoteRepositoryProvider = Provider<IBookingRepository>(
  (ref) => BookingRemoteRepositoryImpl(
      bookingRemoteDataSource: ref.read(bookingRemoteDataSourceProvider),
      propertyRemoteDataSource: ref.read(propertyRemoteDataSourceProvider)),
);

class BookingRemoteRepositoryImpl implements IBookingRepository {
  final BookingRemoteDataSource bookingRemoteDataSource;
  final PropertyRemoteDataSource propertyRemoteDataSource;

  BookingRemoteRepositoryImpl(
      {required this.bookingRemoteDataSource,
      required this.propertyRemoteDataSource});

  @override
  Future<Either<Failure, List<BookingEntity>>> getAllBookings() {
    return bookingRemoteDataSource.getAllBookings();
  }

// Add a method to fetch property details by ID
  @override
  Future<PropertyApiModel?> fetchPropertyById(String propertyId) async {
    return propertyRemoteDataSource.fetchPropertyById(propertyId);
  }

  @override
  Future<Result<void>>  bookProperty(String propertyId, String userId) {
    // TODO: implement bookProperty
    return bookingRemoteDataSource.bookProperty(propertyId, userId);
  }
  // @override
  // Future addProperty(PropertyEntity property) {
  //   return propertyRemoteDataSource.addProperty(property);
  // }
}
