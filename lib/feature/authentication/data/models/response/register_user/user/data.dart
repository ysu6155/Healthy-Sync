class Data {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? role;

  Data({this.id, this.name, this.email, this.phone, this.role});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
      };
}
