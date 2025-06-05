import 'dart:convert';

AllSupportResponse allSupportResponseFromJson(dynamic json) =>
    AllSupportResponse.fromJson(json);

String allSupportResponseToJson(AllSupportResponse data) =>
    json.encode(data.toJson());

class AllSupportResponse {
  String result;
  List<SupportResponseModel> data;
  int totalItems;
  int currentPage;
  int totalPages;

  AllSupportResponse({
    required this.result,
    required this.data,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
  });

  AllSupportResponse copyWith({
    String? result,
    List<SupportResponseModel>? data,
    int? totalItems,
    int? currentPage,
    int? totalPages,
  }) => AllSupportResponse(
    result: result ?? this.result,
    data: data ?? this.data,
    totalItems: totalItems ?? this.totalItems,
    currentPage: currentPage ?? this.currentPage,
    totalPages: totalPages ?? this.totalPages,
  );

  factory AllSupportResponse.fromJson(Map<String, dynamic> json) =>
      AllSupportResponse(
        result: json["result"],
        data: List<SupportResponseModel>.from(
          json["data"].map((x) => SupportResponseModel.fromJson(x)),
        ),
        totalItems: json["totalItems"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "totalItems": totalItems,
    "currentPage": currentPage,
    "totalPages": totalPages,
  };
}

class SupportResponseModel {
  int id;
  int userId;
  String firstName;
  String lastName;
  String email;
  String subject;
  String message;
  String status;
  String createdAt;
  String updatedAt;
  List<ImageData> images;

  SupportResponseModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.subject,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  SupportResponseModel copyWith({
    int? id,
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? subject,
    String? message,
    String? status,
    String? createdAt,
    String? updatedAt,
    List<ImageData>? images,
  }) => SupportResponseModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    subject: subject ?? this.subject,
    message: message ?? this.message,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    images: images ?? this.images,
  );

  factory SupportResponseModel.fromJson(Map<String, dynamic> json) =>
      SupportResponseModel(
        id: json["id"] ?? -1,
        userId: json["user_id"] ?? -1,
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? "",
        subject: json["subject"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        images: List<ImageData>.from(
          json["images"].map((x) => ImageData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "subject": subject,
    "message": message,
    "status": status,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class ImageData {
  int id;
  String image;

  ImageData({required this.id, required this.image});

  ImageData copyWith({int? id, String? image}) =>
      ImageData(id: id ?? this.id, image: image ?? this.image);

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      ImageData(id: json["id"], image: json["image"]);

  Map<String, dynamic> toJson() => {"id": id, "image": image};
}
