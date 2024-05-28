import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:real_estate_app/features/property/data/model/property_hive_model.dart';

import '../../../config/constants/hive_table_constant.dart';
import '../../../features/auth/data/model/auth_hive_model.dart';

final hiveServiceProvider = Provider(
  (ref) => HiveService(),
);

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    //Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    // Hive.registerAdapter(PropertyHiveModelAdapter());

    // await addDummyProperty();
  }

  // ======================== User Queries ========================

  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<List<AuthHiveModel>> getAllUser() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var students = box.values.toList();
    box.close();
    return students;
  }

  //Login
  Future<AuthHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var student = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return student;
  }

  // property query
  Future<void> addProperty(PropertyHiveModel property) async {
    var box =
        await Hive.openBox<PropertyHiveModel>(HiveTableConstant.propertyBox);
    await box.put(property.propertyId, property);
  }

  Future<List<PropertyHiveModel>> getAllProperty() async {
    var box =
        await Hive.openBox<PropertyHiveModel>(HiveTableConstant.propertyBox);
    var property = box.values.toList();
    box.close();
    return property;
  }

  Future<void> deleteAllData() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.clear();
  }

  // ======================== Close Hive ========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ======================== Delete Hive ========================
  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteFromDisk();
  }

  // dummy property
  Future<void> addDummyProperty() async {
    var box =
        await Hive.openBox<PropertyHiveModel>(HiveTableConstant.propertyBox);
    if (box.isEmpty) {
      final property1 = PropertyHiveModel(
          title: "property 1",
          type: "beach",
          desc: "This is beach property",
          img: "",
          price: "123456",
          sqmeters: "200",
          continent: "Asia",
          beds: "6");

      final property2 = PropertyHiveModel(
          title: "property 2",
          type: "mountain",
          desc: "This is mountain property",
          img: "",
          price: "120000",
          sqmeters: "100",
          continent: "Asia",
          beds: "9");
      final property3 = PropertyHiveModel(
          title: "property 3",
          type: "village",
          desc: "This is village property",
          img: "",
          price: "99999",
          sqmeters: "70",
          continent: "Asia",
          beds: "10");
      final property4 = PropertyHiveModel(
          title: "property 4",
          type: "beach",
          desc: "This is beach property",
          img: "",
          price: "80000",
          sqmeters: "70",
          continent: "Asia",
          beds: "4");

      List<PropertyHiveModel> properties = [
        property1,
        property2,
        property3,
        property4
      ];

      for (var property in properties) {
        await addProperty(property);
      }
    }
  }
}
