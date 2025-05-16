import 'user.dart';

class LoginUser {
  String? token;
  User? user;

  LoginUser({this.token, this.user});

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
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
