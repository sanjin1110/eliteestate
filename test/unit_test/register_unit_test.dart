import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';
import 'package:real_estate_app/features/auth/domain/use_case/auth_usecase.dart';
import 'package:real_estate_app/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'auth_unit_test.mocks.dart';

void main() {
  late ProviderContainer container;
  late BuildContext context;
  late AuthUseCase mockAuthUsecase;

  setUpAll(() {
    mockAuthUsecase = MockAuthUseCase();
    context = MockBuildContext();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockAuthUsecase),
        ),
      ],
    );
  });

  test('check for the inital state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });
  test('Register for valid username and password ', () async {
    var user = const AuthEntity(
        id: null,
        email: "sanjin1neymar@gmail.com",
        password: "sanjin",
        username: "sanjin123",
        image: '');

    when(mockAuthUsecase.registerUser(user))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(context, user);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });
  test('Register for invalid username and password ', () async {
    var user = const AuthEntity(
      id: null,
        email: "sanjin1neymar",
        password: "sanjin",
        username: "sanjin123",
        image: '');

    when(mockAuthUsecase.registerUser(user))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(context, user);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid user');
  });
  tearDownAll(
    () => container.dispose(),
  );
}
