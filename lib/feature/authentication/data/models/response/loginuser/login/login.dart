import 'user.dart';

class Login {
  String? token;
  User? user;

  Login({this.token, this.user});

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        token: json['token'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user?.toJson(),
      };
}
