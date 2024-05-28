import 'package:real_estate_app/features/property/domain/entity/property_entity.dart';

class PropertyState {
  final bool isLoading;
  final List<PropertyEntity> properties;
  final String? error;
  final String? imageName;


  PropertyState({
    required this.isLoading,
    required this.properties,
    this.error,
    this.imageName

  });

  factory PropertyState.initial() {
    return PropertyState(
      isLoading: false,
      properties: [],
      error: null,
    );
  }
  PropertyState copyWith({
    bool? isLoading,
    List<PropertyEntity>? properties,
    String? error,
    String? imageName,

  }) {
    return PropertyState(
      isLoading: isLoading ?? this.isLoading,
      properties: properties ?? this.properties,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,

    );
  }
}
