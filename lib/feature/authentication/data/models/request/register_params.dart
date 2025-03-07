class RegisterParams {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;

  RegisterParams({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  factory RegisterParams.fromJson(Map<String, dynamic> json) {
    return RegisterParams(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      };
}
