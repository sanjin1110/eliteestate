import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:real_estate_app/config/routes/app_route.dart';

void main() {
  testWidgets('property rp ...', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          routes: AppRoute.getAppRoute(),
          initialRoute: AppRoute.addPropertyRoute,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Add Property'), findsNWidgets(2));
  });

  testWidgets('property fail ...', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          routes: AppRoute.getAppRoute(),
          initialRoute: AppRoute.addPropertyRoute,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Add Property'), findsOneWidget);
  });
}
