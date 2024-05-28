import 'package:real_estate_app/features/booking/domain/entity/booking_entity.dart';

class BookingState {
  final bool isLoading;
  final List<BookingEntity> bookings;
  final String? error;
  final bool bookingSuccess;

  BookingState({
    required this.isLoading,
    required this.bookings,
    this.error,
    this.bookingSuccess = false,
  });

  factory BookingState.initial() {
    return BookingState(
      isLoading: false,
      bookings: [],
    );
  }

  BookingState copyWith({
    bool? isLoading,
    List<BookingEntity>? bookings,
    String? error,
    bool? bookingSuccess,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      bookings: bookings ?? this.bookings,
      bookingSuccess: bookingSuccess ?? this.bookingSuccess,
    );
  }

  // @override
  // String toString() => 'BookingState(isLoading: $isLoading, error: $error, bookings: $bookings)';
}
