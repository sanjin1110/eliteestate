import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/features/auth/presentation/viewmodel/user_vm_provider.dart';
import 'package:real_estate_app/features/booking/presentation/viewmodel/booking_viewmodel.dart';
import 'package:real_estate_app/features/property/presentation/widget/property_widget.dart';
import 'package:real_estate_app/features/property/presentation/viewmodel/property_viewmodel.dart';

import '../../../../../core/common/snackbar/my_snackbar.dart';
import '../../viewmodel/home_viewmodel.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  Future<void> _refreshData() async {
    // Call the data fetching method here
    await ref.read(propertyViewModelProvider.notifier).getAllProperty();
    await ref.read(bookingViewModelProvider.notifier).getAllBookings();
   await ref.read(userVMProvider.notifier).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    var propertyState = ref.watch(propertyViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard View"),
        actions: [
          IconButton(
            onPressed: () async {
              showSnackBar(message: 'Refressing...', context: context);
              await _refreshData();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Properties',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
                child: PropertyWidget(propertyList: propertyState.properties))
          ],
        ),
      ),
    );
  }
}
