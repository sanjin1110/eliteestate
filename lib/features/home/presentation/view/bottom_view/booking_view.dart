import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/features/booking/data/repository/booking_remote_repository.dart';
import 'package:real_estate_app/features/booking/domain/repository/booking_repository.dart';
import 'package:real_estate_app/features/booking/presentation/viewmodel/booking_viewmodel.dart';
import 'package:real_estate_app/features/booking/presentation/widget/booking_widget.dart';

class BookingView extends ConsumerStatefulWidget {
  const BookingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingViewState();
}

class _BookingViewState extends ConsumerState<BookingView> {
  @override
  Widget build(BuildContext context) {
    var bookingState = ref.watch(bookingViewModelProvider);
        final bookingRepository = ref.read(bookingRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bookings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(child: BookingWidget(bookingList: bookingState.bookings, bookingRepository: bookingRepository))
          ],
        ),
      ),
    );
  }
}
