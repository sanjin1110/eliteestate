import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/config/constants/api_endpoint.dart';
import 'package:real_estate_app/core/common/snackbar/my_snackbar.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';
import 'package:real_estate_app/features/auth/presentation/viewmodel/user_vm_provider.dart';
import 'package:real_estate_app/features/home/presentation/viewmodel/home_viewmodel.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(userVMProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(userVMProvider.notifier).getUserData();
              showSnackBar(message: 'Refressing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          loadProfile(user: userState.user, context: context),
          ElevatedButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red, // Text color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 3,
            ),
            child: const Text(
              "Logout",
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

Widget loadProfile({
  AuthEntity? user,
  required BuildContext context,
}) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: const BouncingScrollPhysics(),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                color: Colors.white,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Cover image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            "assets/images/apartment2.png", // default coverpage image
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    // Profile image
                    Positioned(
                      bottom: 0,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: user!.image != null
                                  ? Image.network(
                                      ApiEndpoints.imageUrl + user.image!,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/profile.jpg",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 20),
              Text(
                user.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    user.username,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        )
      ],
    ),
  );
}



