class NewUser {
  String? name;
  String? email;
  String? password;
  String? role;
  String? profilePhoto;
  DateTime? dateOfBirth;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NewUser({
    this.name,
    this.email,
    this.password,
    this.role,
    this.profilePhoto,
    this.dateOfBirth,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NewUser.fromJson(Map<String, dynamic> json) => NewUser(
    name: json['name'] as String?,
    email: json['email'] as String?,
    password: json['password'] as String?,
    role: json['role'] as String?,
    profilePhoto: json['profilePhoto'] as String?,
    dateOfBirth:
        json['date_of_birth'] == null
            ? null
            : DateTime.parse(json['date_of_birth'] as String),
    id: json['_id'] as String?,
    createdAt:
        json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
    updatedAt:
        json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'role': role,
    'profilePhoto': profilePhoto,
    'date_of_birth': dateOfBirth?.toIso8601String(),
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };
}
