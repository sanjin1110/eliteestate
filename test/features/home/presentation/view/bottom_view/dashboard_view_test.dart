import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:real_estate_app/config/routes/app_route.dart';

void main() {
  testWidgets('dashboard view ...', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          routes: AppRoute.getAppRoute(),
          initialRoute: AppRoute.dashboardRoute,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Category'), findsOneWidget);
  });
  testWidgets('dashboard test ...', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          routes: AppRoute.getAppRoute(),
          initialRoute: AppRoute.dashboardRoute,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Dashboard View'), findsOneWidget);
  });
}
