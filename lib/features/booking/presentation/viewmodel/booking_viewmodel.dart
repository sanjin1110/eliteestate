
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/common/snackbar/my_snackbar.dart';
import 'package:real_estate_app/features/booking/domain/use_case/booking_use_case.dart';
import 'package:real_estate_app/features/booking/presentation/state/booking_state.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';

final bookingViewModelProvider =
    StateNotifierProvider<BookingViewModel, BookingState>(
  (ref) => BookingViewModel(ref.watch(bookingUseCaseProvider)),
);

class BookingViewModel extends StateNotifier<BookingState> {
  final BookingUseCase _bookingUseCase;
  BookingViewModel(this._bookingUseCase) : super(BookingState.initial()) {
    getAllBookings();
  }


  getAllBookings() async {
    state = state.copyWith(isLoading: true);
    var data = await _bookingUseCase.getAllBookings();
    state = state.copyWith(bookings: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, bookings: r, error: null),
    );
  }
Future<void> bookProperty(String propertyId, String userId) async {
    state = state.copyWith(isLoading: true);
    final result = await _bookingUseCase.bookProperty(propertyId, userId);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (_) {
        state = state.copyWith(isLoading: false, error: null, bookingSuccess: true);
      },
    );
  }
//   void bookProperty(BuildContext context, PropertyEntity property) async {
//   final isConfirmed = await showConfirmationDialog(context);

//   if (isConfirmed) {
//     // Proceed with booking logic here
//     // For example, you can make an API call to book the property
//     state = state.copyWith(isLoading: true);
//     var data = await _bookingUseCase.bookProperty(property);

//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         showSnackBar(
//           message: failure.error,
//           context: context,
//           color: Colors.red,
//         );
//       },
//       (success) {
//         state = state.copyWith(isLoading: false, error: null);
//         showSnackBar(
//           message: 'Property booked successfully',
//           context: context,
//           color: Colors.green,
//         );
//       },
//     );
//   }
// }

Future<bool> showConfirmationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirm Booking'),
        content: Text('Do you want to book this property?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}





}
