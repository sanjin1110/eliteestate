import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/routes/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/use_case/auth_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.read(authUseCaseProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState.initial());

  Future<void> registerUser(BuildContext context, AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerUser(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "Successfully registered", context: context);
      },
    );
  }

  Future<void> loginUser(
      BuildContext context, String username, String password) async {
    state = state.copyWith(isLoading: true);
    // bool isLogin = false;
    var data = await _authUseCase.loginUser(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: 'Invalid credential', context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
      },
    );

    // return isLogin;
  }

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.uploadProfilePicture(file!);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (imageName) => state =
          state.copyWith(isLoading: false, error: null, imageName: imageName),
    );
  }

  // Future<void> fetchUserData(BuildContext context, String? userId) async {
  //   state = state.copyWith(isLoading: true);

  //   var data = await _authUseCase.fetchUserData(userId); // Replace with the actual method call
  //   data.fold(
  //     (failure) {
  //       state = state.copyWith(isLoading: false, error: failure.error);
  //       showSnackBar(
  //           message: 'Failed to fetch user data', context: context, color: Colors.red);
  //     },
  //     (userData) { // Change the parameter name here to userData
  //       state = state.copyWith(
  //         isLoading: false,
  //         error: null,
  //         imageName: userData.image, // Access the image property from the userData
  //         userId: userData.id, // Access the id property from the userData
  //       );
  //       // Handle successful data retrieval, if needed
  //     },
  //   );
  // }
  Future<void> fetchUserData(BuildContext context, String? userId) async {
    state = state.copyWith(isLoading: true);

    var data = await _authUseCase.fetchUserData(userId);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: 'Failed to fetch user data',
            context: context,
            color: Colors.red);
      },
      (userData) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          imageName: userData.image,
          userData: userData, // Set the user data in the state
        );
      },
    );
  }
}


// expect(find.widgetWithText(SnackBar, 'Registered successfully'),
    //     findsOneWidget);
