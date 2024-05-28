import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';

import '../../../../config/routes/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../viewmodel/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final key = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool _obsecureText = true;
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(authViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: Form(
        key: key,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 227, 227, 227),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100.0,
                      width: 190.0,
                      padding: const EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    const Text(
                      "Sign Up to Elite Estates",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey[300],
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(ref, ImageSource.camera);
                                      Navigator.pop(context);
                                      // Upload image it is not null
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      checkCameraPermission();
                                      _browseImage(ref, ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _img != null
                                ? FileImage(_img!)
                                : const AssetImage(
                                        'assets/images/profilepic.png')
                                    as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      // maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "enter your email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    TextFormField(
                      controller: usernameController,
                      // maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "UserName",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "enter your UserName";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    TextFormField(
                      obscureText: _obsecureText,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      // maxLines: 2,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obsecureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "enter your password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                var user = AuthEntity(
                                  username: usernameController.text,
                                  email: emailController.text,
                                  image: authState.imageName,
                                  password: passwordController.text,
                                );
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .registerUser(context, user);
                                    // .registerUser( user);
                                if (authState.error != null) {
                                  showSnackBar(
                                    message: authState.error.toString(),
                                    context: context,
                                    color: Colors.red,
                                  );
                                } else {
                                  showSnackBar(
                                    message: 'Registered successfully',
                                    context: context,
                                  );
                                }
                              }
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoute.loginRoute);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
