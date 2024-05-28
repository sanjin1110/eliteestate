import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:real_estate_app/config/routes/app_route.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/features/auth/domain/use_case/auth_usecase.dart';
import 'package:real_estate_app/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../../../../unit_test/auth_unit_test.mocks.dart';

void main() {
  late AuthUseCase mockAuthUsecase;
  late bool isLogin;

  setUpAll(() async {
    mockAuthUsecase = MockAuthUseCase();
    isLogin = true;
  });
  testWidgets('login test with username and password and open dashboard',
      (WidgetTester tester) async {
    when(mockAuthUsecase.loginUser('sanjin', 'sanjin123'))
        .thenAnswer((_) async => Right(isLogin));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getAppRoute(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Type in first textformfield/TextField
    await tester.enterText(find.byType(TextField).at(0), 'sanjin');
    // Type in second textformfield
    await tester.enterText(find.byType(TextField).at(1), 'sanjin123');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Login'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
  });


  testWidgets('login test with invalid username and password ',
      (WidgetTester tester) async {
    when(mockAuthUsecase.loginUser('sanjin', 'sanjin'))
        .thenAnswer((_) async => Left(Failure(error: "invalid")));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getAppRoute(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Type in first textformfield/TextField
    await tester.enterText(find.byType(TextField).at(0), 'sanjin123');
    // Type in second textformfield
    await tester.enterText(find.byType(TextField).at(1), 'sanjin');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Login'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
  });
}
