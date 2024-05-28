import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/common/snackbar/my_snackbar.dart';
import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';
import 'package:real_estate_app/features/property/domain/use_case/property_use_case.dart';

import '../state/property_state.dart';

final propertyViewModelProvider =
    StateNotifierProvider<PropertyViewModel, PropertyState>(
  (ref) => PropertyViewModel(ref.watch(propertyUseCaseProvider)),
);

class PropertyViewModel extends StateNotifier<PropertyState> {
  final PropertyUseCase _propertyUseCase;
  PropertyViewModel(this._propertyUseCase) : super(PropertyState.initial()) {
    getAllProperty();
  }
  getAllProperty() async {
    state = state.copyWith(isLoading: true);
    var data = await _propertyUseCase.getAllProperty();
    state = state.copyWith(properties: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) =>
          state = state.copyWith(isLoading: false, properties: r, error: null),
    );
  }

  Future<void> addProperty(
      BuildContext context, PropertyEntity property) async {
    state = state.copyWith(isLoading: true);
    var data = await _propertyUseCase.addProperty(property);
    data.fold(
      (l) {
        state = state.copyWith(
          isLoading: false,
          error: l.error,
        );
        showSnackBar(message: l.error, context: context, color: Colors.red);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "successfully added property", context: context);
      },
    );
  }
  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _propertyUseCase.uploadProfilePicture(file!);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (imageName) => state =
          state.copyWith(isLoading: false, error: null, imageName : imageName),
    );
  }
}
