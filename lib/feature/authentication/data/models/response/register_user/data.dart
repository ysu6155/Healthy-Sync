import 'new_user.dart';

class Data {
  NewUser? newUser;

  Data({this.newUser});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        newUser: json['newUser'] == null
            ? null
            : NewUser.fromJson(json['newUser'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {'newUser': newUser?.toJson()};
}
