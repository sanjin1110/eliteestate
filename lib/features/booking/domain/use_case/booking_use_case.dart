import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/booking/domain/entity/booking_entity.dart';
import 'package:real_estate_app/features/booking/domain/repository/booking_repository.dart';
import 'package:real_estate_app/features/property/data/model/property_api_model.dart';
import 'package:real_estate_app/features/property/domain/repository/property_repository.dart';

final bookingUseCaseProvider = Provider<BookingUseCase>(
  (ref) => BookingUseCase(
    bookingRepository: ref.watch(bookingRepositoryProvider),
    propertyRepository: ref.watch(propertyRepositoryProvider),
  ),
);

class BookingUseCase {
  final IBookingRepository bookingRepository;
  final IPropertyRepository propertyRepository;

  BookingUseCase(
      {required this.bookingRepository, required this.propertyRepository});

  Future<Either<Failure, List<BookingEntity>>> getAllBookings() {
    return bookingRepository.getAllBookings();
  }

  Future<PropertyApiModel?> fetchPropertyById(String propertyId) {
    return propertyRepository.fetchPropertyById(propertyId);
  }

   Future<Result<void>>  bookProperty(
      String propertyId, String userId) async {
    return bookingRepository.bookProperty(propertyId, userId);
  }
}
