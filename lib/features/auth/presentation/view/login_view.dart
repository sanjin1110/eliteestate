import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_route.dart';
import '../viewmodel/auth_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: Form(
        key: _formKey,
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
                      "Let's Sign In",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.emailAddress,
                      // maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "enter your username";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: _obsecureText,
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
                            key: const ValueKey('loginButton'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .loginUser(
                                      context,
                                      usernameController.text,
                                      passwordController.text,
                                    );
                              }
                            },
                            child: const Text(
                              "Login",
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
                        const Center(
                          child: Text("Dont have account?"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoute.registerRoute);
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
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
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
