import 'user.dart';

class UpdateUser {
  String? message;
  User? user;

  UpdateUser({this.message, this.user});

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
    message: json['message'] as String?,
    user:
        json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'message': message, 'user': user?.toJson()};
}
