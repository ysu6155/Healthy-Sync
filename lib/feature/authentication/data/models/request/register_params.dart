class RegisterParams {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;
  String? role;
  String? specialization;
  String? gender;
  String? dateOfBirth;
  String? profilePhoto;
  List<String>? chronicDiseases;
  String? city;
  String? address;
  String? phone1;
  String? phone2;
  String? image;
  String? description;
  String? rating;
  List<String>? appointments;
  List<String>? medicalHistory;
  List<String>? allergies;
  List<String>? medications;
  List<String>? medicalRecords;
  List<String>? lastVisit;
  List<String>? prescriptions;
  Map<String, dynamic>? other;
  String? experience;

  RegisterParams(
      {this.name,
      this.email,
      this.phone,
      this.password,
      this.passwordConfirmation,
      this.role,
      this.specialization,
      this.gender,
      this.dateOfBirth,
      this.profilePhoto,
      this.chronicDiseases,
      this.city});

  factory RegisterParams.fromJson(Map<String, dynamic> json) {
    return RegisterParams(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
      role: json['role'] as String?,
      specialization: json['specialization'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      profilePhoto: json['profilePhoto'] as String?,
      chronicDiseases: json['chronicDiseases'] as List<String>?,
      city: json['city'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'role': role,
        'specialization': specialization,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'profilePhoto': profilePhoto,
        'chronicDiseases': chronicDiseases,
        'city': city
      };
}
