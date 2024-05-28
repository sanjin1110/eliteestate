import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';

class NewState {
  final bool isLoading;
  final String? error;
  final AuthEntity? user;

  NewState({
    required this.isLoading,
    this.error,
    required this.user,
  });

  factory NewState.initial() {
    return NewState(
      isLoading: false,
      error: null,
      user: null
    );
  }

  NewState copyWith({
    bool? isLoading,
    String? error,
    AuthEntity? user
  }) {
    return NewState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
}
}