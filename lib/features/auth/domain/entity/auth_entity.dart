import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String username;
  final String email;
  final String password;
  final String? image;

  const AuthEntity({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.image,
  });
  static AuthEntity empty() {
    return AuthEntity(
      id: null,
      username: '',
      email: '',
      password: '',
      image: null,
    );
  }
factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      id: json['id'] as String?,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'image': image,
    };
  }
  @override
  List<Object?> get props => [id, username, email, password, image];
}
