class User {
  String? id;
  String? name;
  String? email;
  String? role;
  String? gender;

  User({this.id, this.name, this.email, this.role, this.gender});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        role: json['role'] as String?,
        gender: json['gender'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'gender': gender,
      };
}
