import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:real_estate_app/features/property/domain/use_case/property_use_case.dart';
import 'package:real_estate_app/features/property/presentation/viewmodel/property_viewmodel.dart';

import 'property_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PropertyUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late ProviderContainer container;
  late BuildContext context;
  late PropertyUseCase mockPropertyUsecase;
  setUpAll(() async {
    mockPropertyUsecase = MockPropertyUseCase();

    context = MockBuildContext();
    container = ProviderContainer(
      overrides: [
        propertyViewModelProvider.overrideWith(
          (ref) => PropertyViewModel(mockPropertyUsecase),
        ),
      ],
    );
  });

  test('check for the inital state', () async {
    final authState = container.read(propertyViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.properties, []);
  });
}
