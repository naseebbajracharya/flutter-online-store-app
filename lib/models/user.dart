import 'package:meta/meta.dart';

class User {
  String id;
  String username;
  String email;
  String address;
  String jwt;
  String cartId;

  User({ @required this.id, @required this.username, @required this.email, @required this.address, @required this.jwt, @required this.cartId });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      address: json['address'],
      jwt: json['jwt'],
      cartId: json['cart_id']
    );
  }
}