import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:real_estate_app/config/routes/app_route.dart';
import 'package:real_estate_app/features/auth/domain/entity/auth_entity.dart';
import 'package:real_estate_app/features/auth/domain/use_case/auth_usecase.dart';
import 'package:real_estate_app/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../../../../unit_test/auth_unit_test.mocks.dart';

void main() {
  late AuthUseCase mockAuthUsecase;
  late AuthEntity authEntity;

  setUpAll(() async {
    mockAuthUsecase = MockAuthUseCase();

    authEntity = const AuthEntity(
      username: 'sanjin',
      email: 'thapasanjin@gmail.com',
      password: 'sanjin123',
    );
  });
  testWidgets('register view ...', (tester) async {
    when(mockAuthUsecase.registerUser(authEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerRoute,
          routes: AppRoute.getAppRoute(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    //enter username
    await tester.enterText(find.byType(TextFormField).at(0), 'sanjin');
    // Enteremail
    await tester.enterText(
        find.byType(TextFormField).at(1), 'thapasanjin@gmail.com');
    // Enter password
    await tester.enterText(find.byType(TextFormField).at(2), 'sanjin123');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Register'),
    );

    await tester.pumpAndSettle();
    // expect(find.text('Register'), findsOneWidget);


expect(find.widgetWithText(SnackBar, 'Registered successfully'),
        findsOneWidget);
    
  });
}
