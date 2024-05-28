import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_app/config/constants/api_endpoint.dart';
import 'package:real_estate_app/core/failure/failure.dart';
import 'package:real_estate_app/core/network/remote/http_service.dart';

import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/property_entity.dart';
import '../model/property_api_model.dart';

// final storage = FlutterSecureStorage();

final propertyRemoteDataSourceProvider = Provider(
  (ref) => PropertyRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    propertyApiModel: ref.read(propertyApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class PropertyRemoteDataSource {
  final Dio dio;
  final PropertyApiModel propertyApiModel;
  final UserSharedPrefs userSharedPrefs;

  PropertyRemoteDataSource({
    required this.dio,
    required this.propertyApiModel,
    required this.userSharedPrefs,
  });
  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadPropImage,
        data: formData,
      );
      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<PropertyEntity>>> getAllProperty() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllProperty);
      if (response.statusCode == 200) {
        var properties = (response.data as List)
            .map((property) => PropertyApiModel.fromJson(property).toEntity())
            .toList();
        return Right(properties);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  // Future<void> addProperty(PropertyEntity property) async {
  // Future<void> addProperty(PropertyEntity property) async {

  Future<Either<Failure, bool>> addProperty(PropertyEntity property) async {
// final Either<Failure, String?> authToken =
    //     await userSharedPrefs.getUserToken();
    // final container = ProviderContainer();
    // final userSharedPrefs = container.read(userSharedPrefsProvider);

    // final userSharedPrefs = ref.read(userSharedPrefsProvider);
    // final userToken = await userSharedPrefs.getUserToken();
    // container.dispose(); // Dispose of the container after obtaining the value.

    // if (userToken.isRight()) {
    // User token is available, proceed with adding the property
    // final String? authToken = userToken.getOrElse(() => "");

    const String baseUrl =
        'http://192.168.1.68:3000/'; // Replace with your API base URL
    const String endpoint =
        'property/addProperty'; // Replace with the endpoint for adding properties

    try {
      final userToken = await userSharedPrefs.getUserToken();

      // Response response = await dio.post(
      // container.dispose(); // Dispose of the container after obtaining the value.

      // if (userToken.isRight()) {
      //   ApiEndpoints.addProperty,
      //   data: {
      //   "title": property.title,
      //   "type":property.type,
      //   "desc":property.desc,
      //   "img":property.img,
      //   "price":property.price,
      //   "sqmeters":property.sqmeters,
      //   "continent":property.sqmeters,
      //   "beds":property.beds,
      // }}
      // ,
      // );
      // final response = await http.post(
      //   Uri.parse(baseUrl + endpoint),
      //   headers: {
      //     'Authorization':
      //         'Bearer $userToken', // Include the token in the 'Authorization' header
      //     'Content-Type': 'application/json',
      //   },
      //   body: {
      //     "title": property.title,
      //     "type":property.type,
      //     "desc":property.desc,
      //     "img":property.img,
      //     "price":property.price,
      //     "sqmeters":property.sqmeters,
      //     "continent":property.sqmeters,
      //     "beds":property.beds,
      //   }
      //   // jsonEncode(
      //   //     property.toJson()), // Convert the property object to JSON
      // );

      Response response = await dio.post(
        ApiEndpoints.addProperty,
        data: {
          "title": property.title,
          "type": property.type,
          "desc": property.desc,
          "img": property.img,
          "price": property.price,
          "sqmeters": property.sqmeters,
          "continent": property.continent,
          "beds": property.beds,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $userToken',
        }),
      );

      if (response.statusCode == 201) {
        print('Property added successfully');
        return const Right(true);
        // Handle the success response as needed.
      } else {
        print('Property failed to add');

        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<PropertyApiModel?> fetchPropertyById(String propertyId) async {
    const String baseUrl = 'http://192.168.1.68:3000/';
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/property/find/$propertyId'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PropertyApiModel.fromJson(jsonData);
      } else {
        // Handle API error here
        print(
            'Failed to fetch property details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle any other errors here
      print('Error fetching property details: $e');
      return null;
    }
  }
}
