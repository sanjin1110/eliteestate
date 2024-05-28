import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_app/config/constants/api_endpoint.dart';
import 'package:real_estate_app/features/booking/domain/entity/booking_entity.dart';
import 'package:real_estate_app/features/booking/domain/repository/booking_repository.dart';
import 'package:real_estate_app/features/property/presentation/viewmodel/property_viewmodel.dart';

import '../../../../core/common/provider/internet_connectivity.dart';

class BookingWidget extends ConsumerStatefulWidget {
  final List<BookingEntity> bookingList;
  final IBookingRepository bookingRepository;

  const BookingWidget(
      {super.key, required this.bookingList, required this.bookingRepository});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends ConsumerState<BookingWidget> {
  @override
  Widget build(BuildContext context) {
    final connectivityStatus = ref.watch(connectivityStatusProvider);
    final propertyState = ref.watch(propertyViewModelProvider);

    return GridView.builder(
      shrinkWrap: true,
      itemCount: widget.bookingList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // Handle property details page navigation or any action
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 227, 227, 227),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.white,
                width: 5.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      connectivityStatus == ConnectivityStatus.isConnected
                          ? ApiEndpoints.imageUrl +
                              propertyState.properties[index].img!
                          : 'http://192.168.1.68:3000/upload/',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${propertyState.properties[index].title}  \$${propertyState.properties[index].price}",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue, // Set the background color
                      ),
                      child: TextButton(
                        onPressed: () async {
                          final isConfirmed = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Do you want to delete this booking?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (isConfirmed == true) {
                            var bookingId = propertyState.properties[index].id;
                            // '64d241db6c5a36803b59c3a1'; // Replace with the booking ID

                            var apiUrl =
                                'http://192.168.1.68:3000/booking/$bookingId'; // Replace with your API endpoint
                            print('rhe booking id is $bookingId');
                            final response =
                                await http.delete(Uri.parse(apiUrl));

                            if (response.statusCode == 200) {
                              // Deletion successful, handle success here
                            } else {
                              // Deletion failed, handle error here
                            }
                          }
                          // Your booking logic here
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white, // Set the text color
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
