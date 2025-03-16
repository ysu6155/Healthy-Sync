import 'data.dart';

class User {
  String? message;
  String? token;
  Data? data;

  User({this.message, this.token, this.data});

  factory User.fromJson(Map<String, dynamic> json) => User(
    message: json['message'] as String?,
    token: json['token'] as String?,
    data:
        json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'token': token,
    'data': data?.toJson(),
  };
}
