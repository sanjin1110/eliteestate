import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/config/constants/api_endpoint.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/core/network/remote/http_service.dart';
import 'package:real_estate_app/features/booking/data/model/booking_api_model.dart';
import 'package:real_estate_app/features/booking/domain/entity/booking_entity.dart';

import '../../../../core/shared_prefs/user_shared_prefs.dart';

// final storage = FlutterSecureStorage();

final bookingRemoteDataSourceProvider = Provider(
  (ref) => BookingRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    bookingApiModel: ref.read(bookingApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class BookingRemoteDataSource {
  final Dio dio;
  final BookingApiModel bookingApiModel;
  final UserSharedPrefs userSharedPrefs;

  BookingRemoteDataSource({
    required this.dio,
    required this.bookingApiModel,
    required this.userSharedPrefs,
  });
  Future<Either<Failure, List<BookingEntity>>> getAllBookings() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllBooking);
      if (response.statusCode == 200) {
        var bookings = (response.data as List)
            .map((bookings) => BookingApiModel.fromJson(bookings).toEntity())
            .toList();
        return Right(bookings);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Result<void>> bookProperty(String propertyId, String userId) async {
    try {
      final response = await dio.post(
        ApiEndpoints.bookProperty,
        data: {
          'propertyId': propertyId,
          'userId': userId,
        },
      );

      if (response.statusCode == 200) {
        return Result.success(propertyId); // Booking successful
      } else {
        return Result.failure(
          Failure(
            error: response.data['message'] ?? 'Booking failed',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } catch (e) {
      return Result.failure(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }
}
