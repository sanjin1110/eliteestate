import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String? id;
  final String? user; // You can use String or any other type to represent the user ID
  final String property; // You can use String or any other type to represent the property ID
  final String? checkIn;
  final String? totalPrice;
  final String? status;

  const BookingEntity({
    this.id,
    this.user,
    required this.property,
    required this.checkIn,
    required this.totalPrice,
   this.status,
  });

  factory BookingEntity.fromJson(Map<dynamic, dynamic> json) => BookingEntity(
        id: json["id"] as String?,
        user: json["user"] as String?,
        property: json["property"] as String,
        checkIn: json["checkIn"] as String?,
        totalPrice: json["totalPrice"] as String?,
        status: json["status"] as String?,
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "user": user,
        "property": property,
        "checkIn": checkIn,
        "totalPrice": totalPrice,
        "status": status,
      };

  @override
  List<Object?> get props => [
        id,
        user,
        property,
        checkIn,
        totalPrice,
        status,
      ];
}
// List<BookingEntity> parseBookings(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<BookingEntity>((json) => BookingEntity.fromJson(json)).toList();
// }
// Map<String, dynamic> createBookingData(BookingEntity bookingEntity) {
//   return bookingEntity.toJson();
// }
