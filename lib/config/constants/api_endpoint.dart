class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 9000);
  static const Duration receiveTimeout = Duration(seconds: 9000);
  static const String baseUrl = "http://192.168.1.68:3000/";
  // static const String baseUrl = "http://192.168.1.68:3000/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getAllProperty = "property/getAll";
  static const String addProperty = "property/addProperty";

  static const String getAllBooking = "booking/allBookings";
  static const String bookProperty = "booking/bookProperty";
  static const String gatuserdata = "user/getUserData";

  static String getUser(String? userId) {
    return 'user/$userId';
  }

  static const String getAllUsers = "user/getAllUsers";
  static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  static const String updateStudent = "auth/updateStudent/";
  static const String deleteStudent = "auth/deleteStudent/";
  static const String imageUrl = "http://192.168.1.68:3000/uploads/";
  // static const String imageUrl = "http://10.0.2.2:3000/uploads/";

  static const String uploadImage = "auth/uploadImage";
  static const String uploadPropImage = "property/uploadImage";
}
