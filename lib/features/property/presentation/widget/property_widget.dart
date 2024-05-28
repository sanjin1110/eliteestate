import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_app/config/constants/api_endpoint.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';
import 'package:real_estate_app/features/property/presentation/viewmodel/property_viewmodel.dart';

import '../../../../core/common/provider/internet_connectivity.dart';

class PropertyWidget extends ConsumerStatefulWidget {
  final List<PropertyEntity> propertyList;

  const PropertyWidget({super.key, required this.propertyList});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PropertyWidgetState();
}

class _PropertyWidgetState extends ConsumerState<PropertyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final connectivityStatus = ref.watch(connectivityStatusProvider);
        final propertyState = ref.watch(propertyViewModelProvider);
        if (connectivityStatus == ConnectivityStatus.isConnected) {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: widget.propertyList.length,
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
                            ApiEndpoints.imageUrl +
                                propertyState.properties[index].img!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.propertyList[index].title}  \$${widget.propertyList[index].price}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                      Row(children: [
                        const Icon(
                          Icons.location_on,
                          size: 20, // Specify the desired icon size
                          color: Colors.blue, // Specify the desired icon color
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.propertyList[index].continent,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
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
                                      title: const Text('Confirm Booking'),
                                      content: const Text(
                                          'Do you want to book this property?'),
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
                                  final propertyId =
                                      widget.propertyList[index].id;
                                  // final propertyId = '64acac08049a289fa833bb8c';
                                  const userId = '64d233ea90cdf0cc684c3755';
                                  const apiUrl =
                                      'http://192.168.1.68:3000/booking/bookProperty'; // Replace with your API endpoint

                                  final bookingData = {
                                    "user": userId,
                                    "property": propertyId,
                                    "checkIn": "2023-08-16",
                                    "totalPrice": 8000,
                                    "status": "pending",
                                  };

                                  final response = await http.post(
                                    Uri.parse(apiUrl),
                                    headers: {
                                      'Content-Type': 'application/json'
                                    },
                                    body: jsonEncode(bookingData),
                                  );

                                  if (response.statusCode == 200) {
                                    // Booking successful, handle success here
                                  } else {
                                    // Booking failed, handle error here
                                  }
                                }
                              },
                              child: const Text(
                                'Book',
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
        } else {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: 4,
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
                          child: Image.asset(
                            'assets/images/house.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Property For Sale  \$ 100000",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                      const Row(children: [
                        Icon(
                          Icons.location_on,
                          size: 20, // Specify the desired icon size
                          color: Colors.blue, // Specify the desired icon color
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "kathmandu",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blue, // Set the background color
                          ),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('No Internet Access'),
                                      content: const Text(
                                          'You need internet access to book a property.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text(
                              'Book',
                              style: TextStyle(
                                color: Colors.white, // Set the text color
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
