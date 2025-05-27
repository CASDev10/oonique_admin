import 'dart:convert';

LoginInput loginInputFromJson(String str) =>
    LoginInput.fromJson(json.decode(str));

String loginInputToJson(LoginInput data) => json.encode(data.toJson());

class LoginInput {
  String email;
  String password;

  LoginInput({required this.email, required this.password});

  LoginInput copyWith({String? email, String? password}) => LoginInput(
    email: email ?? this.email,
    password: password ?? this.password,
  );

  factory LoginInput.fromJson(Map<String, dynamic> json) =>
      LoginInput(email: json["email"], password: json["password"]);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
