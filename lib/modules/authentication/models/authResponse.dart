import 'dart:convert';

AuthResponse authResponseFromJson(dynamic json) => AuthResponse.fromJson(json);

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  Data data;
  String result;
  String message;

  AuthResponse({
    required this.data,
    required this.result,
    required this.message,
  });

  AuthResponse copyWith({Data? data, String? result, String? message}) =>
      AuthResponse(
        data: data ?? this.data,
        result: result ?? this.result,
        message: message ?? this.message,
      );

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    data: Data.fromJson(json["data"]),
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "result": result,
    "message": message,
  };
}

class Data {
  String token;
  Admin admin;

  Data({required this.token, required this.admin});

  Data copyWith({String? token, Admin? admin}) =>
      Data(token: token ?? this.token, admin: admin ?? this.admin);

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(token: json["token"], admin: Admin.fromJson(json["admin"]));

  Map<String, dynamic> toJson() => {"token": token, "admin": admin.toJson()};
}

class Admin {
  int id;
  String name;
  dynamic profilePicture;
  String email;
  DateTime createdAt;
  DateTime updatedAt;

  Admin({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  Admin copyWith({
    int? id,
    String? name,
    dynamic profilePicture,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Admin(
    id: id ?? this.id,
    name: name ?? this.name,
    profilePicture: profilePicture ?? this.profilePicture,
    email: email ?? this.email,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"],
    name: json["name"],
    profilePicture: json["profile_picture"],
    email: json["email"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_picture": profilePicture,
    "email": email,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
