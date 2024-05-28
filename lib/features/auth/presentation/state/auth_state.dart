import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
    final String? userId; // Add this field
  final AuthEntity userData; // Add this field to hold user data


  AuthState({
    required this.isLoading,
    this.error,
    this.imageName,
    this.userId,
      required  this.userData, // Initialize this field to null

  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      userId: null,
      // imageName: null
            userData: AuthEntity.empty(), // Initialize with AuthEntity.empty()

    );
  }
  // final AuthEntity userData; // Initialize this field with AuthEntity.empty()

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    String? userId,
        AuthEntity? userData, // Include this in copyWith

  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      userId: userId ?? this.userId,
            userData: userData ?? this.userData, // Update the userData field


    );
  }

  @override
  String toString() => 'AuthState(isLoading: $isLoading, error: $error, imageName: $imageName)';
}
