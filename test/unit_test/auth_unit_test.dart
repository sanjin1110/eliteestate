import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/auth/domain/use_case/auth_usecase.dart';
import 'package:real_estate_app/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'auth_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late BuildContext context;

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

   // While testing this for now comment the navigation part and snackbar part
  test('login test with valid username and', () async {
    when(mockAuthUsecase.loginUser('sanjin', 'sanjin123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    when(mockAuthUsecase.loginUser('sanjin', 'sanjin1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'sanjin', 'sanjin123');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });


test('check for invalid username and password ', () async {
    when(mockAuthUsecase.loginUser('sanjin', 'sanjin1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));
when(mockAuthUsecase.loginUser('sanjin', 'sanjin123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'sanjin', 'sanjin124');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid');
  });

  tearDownAll(
    () => container.dispose(),
  );
}
