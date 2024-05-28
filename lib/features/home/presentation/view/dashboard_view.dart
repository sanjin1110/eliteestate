import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/features/home/presentation/view/bottom_view/profile_screen.dart';
import 'package:real_estate_app/features/home/presentation/view/bottom_view/property_category_view.dart';
import 'package:real_estate_app/features/home/presentation/viewmodel/home_viewmodel.dart';

import 'bottom_view/booking_view.dart';
import 'bottom_view/home_view.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  void initState() {
    super.initState();
    accelerometerEvents!.listen((AccelerometerEvent event) {
      double xAxisValue = event.x;
      if (xAxisValue > 8.0) {
        ref.read(homeViewModelProvider.notifier).logout(context);
      }
    });
  }

  int _selectedIndex = 0;

  List<Widget> lstBottomScreen = [
    const HomeView(),
    const PropertyTypesScreen(),
    const BookingView(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: lstBottomScreen[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/addPropertyRoute');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            label: "Booking",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
