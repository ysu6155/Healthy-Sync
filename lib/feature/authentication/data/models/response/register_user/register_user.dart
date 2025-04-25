import 'data.dart';

class RegisterUser {
  String? message;
  String? token;
  Data? data;

  RegisterUser({this.message, this.token, this.data});

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
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
